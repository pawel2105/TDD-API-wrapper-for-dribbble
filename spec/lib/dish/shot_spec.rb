require_relative '../../spec_helper'
 
describe Dish::Shot do
 
  describe "default attributes" do
    it "must include httparty methods" do
      Dish::Shot.must_include HTTParty
    end
 
    it "must have the base url set to the Dribble API endpoint" do
      Dish::Shot.base_uri.must_equal 'http://api.dribbble.com'
    end  
  end
  
  describe "GET shot" do
    before do
      VCR.insert_cassette 'shot', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    # it "records the fixture" do
    #   Dish::Shot.get('/shots/21603')
    # end

    it "must have a shot_profile method" do
      shot.must_respond_to :profile
    end

    it "must parse the api response from JSON to Hash" do
      shot.profile.must_be_instance_of Hash
    end

    it "must get the right shot" do
      shot.profile["id"].must_equal 21603
    end
    
    describe "dynamic attributes" do
      before do
        shot.profile
      end
      
      it "must return that attribute value if present in the profile" do
        shot.id.must_equal 21603
      end
      
      it "must raise method missing if attribute is not present" do
        lambda { player.foo_attribute }.must_raise NoMethodError
      end
    end
    
    describe "caching" do
      before do
        shot.profile
        stub_request(:any, /api.dribbble.com/).to_timeout
      end
      
      it "must cache the shot" do
        shot.profile.must_be_instance_of Hash
      end
      
      it "must refresh the shot if forced" do
        lambda { shot.profile(true) }.must_raise Timeout::Error
      end
    end
  end
end
  
