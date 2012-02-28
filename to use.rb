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
  
  describe "default shot instance attributes" do

    let(:shot) { Dish::Shot.new('21603') }

    it "must have a title attribute" do
      shot.must_respond_to :title
    end

    it "must have the right title" do
      shot.title.must_equal 'Moon'
    end

  end
  
  describe "GET shot profile" do

    let(:shot) { Dish::Shot.new('21603') }

    before do
      VCR.insert_cassette 'shot', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it "must have a shot method" do
      shot.must_respond_to :shot_profile
    end

    it "must parse the api response from JSON to Hash" do
      shot.player.must_be_instance_of Hash
    end

    it "must get the right shot id" do
      shot.id.must_equal 21603
    end

    describe "dynamic attributes" do
      
      before do
        shot.player
      end
      
      it "must return that attribute value if present in the profile" do
        player.id.must_equal 1
      end
      
      it "must raise method missing if attribute is not present" do
        lambda { player.foo_attribute }.must_raise NoMethodError
      end
      
    end
  
  end
  
end
  
