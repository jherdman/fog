module Fog
  module Identity

    autoload :OpenStack, 'fog/openstack/identity'

    def self.[](provider)
      self.new(:provider => provider)
    end

    def self.new(attributes)
      attributes = attributes.dup # Prevent delete from having side effects
      case provider = attributes.delete(:provider).to_s.downcase.to_sym
      when :openstack
        OpenStack.new(attributes)
      else
        raise ArgumentError.new("#{provider} has no identity service")
      end
    end

    def self.providers
      Fog.services[:idenity]
    end

  end
end
