module Fog
  module CDN

    autoload :AWS,       'fog/aws/cdn'
    autoload :HP,        'fog/hp/cdn'
    autoload :Rackspace, 'fog/Rackspace/cdn'

    def self.[](provider)
      self.new(:provider => provider)
    end

    def self.new(attributes)
      attributes = attributes.dup # prevent delete from having side effects
      case provider = attributes.delete(:provider).to_s.downcase.to_sym
      when :aws
        AWS.new(attributes)
      when :hp
        HP.new(attributes)
      when :rackspace
        Rackspace.new(attributes)
      else
        raise ArgumentError.new("#{provider} is not a recognized cdn provider")
      end
    end

    def self.providers
      Fog.services[:cdn]
    end

  end
end
