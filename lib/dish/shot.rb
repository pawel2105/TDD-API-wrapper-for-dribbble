module Dish
  class Shot

    attr_accessor :id
    include HTTParty
    base_uri 'http://api.dribbble.com'
    
    def initialize(id)
      self.id = id
    end
    
    def profile(force = false)
      force ? @profile = get_profile : @profile ||= get_profile
    end

    def method_missing(name, *args, &block)
      profile.has_key?(id.to_s) ? profile[id.to_s] : super
    end
    
    private
    
    def get_profile
      self.class.get("/shots/#{self.id}")
    end

  end
end