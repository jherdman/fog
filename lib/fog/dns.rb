module Fog
  module DNS

    autoload :AWS,         'fog/aws/dns'
    autoload :Bluebox,     'fog/bluebox/dns'
    autoload :DNSimple,    'fog/dnsimple/dns'
    autoload :DNSMadeEasy, 'fog/dnsmadeeasy/dns'
    autoload :Dynect,      'fog/dynect/dns'
    autoload :Linode,      'fog/linode/dns'
    autoload :Zerigo,      'fog/zerigo/dns'
    autoload :Rackspace,   'fog/rackspace/dns'

    def self.[](provider)
      self.new(:provider => provider)
    end

    def self.new(attributes)
      attributes = attributes.dup # prevent delete from having side effects
      case provider = attributes.delete(:provider).to_s.downcase.to_sym
      when :aws
        AWS.new(attributes)
      when :bluebox
        Bluebox.new(attributes)
      when :dnsimple
        DNSimple.new(attributes)
      when :dnsmadeeasy
        DNSMadeEasy.new(attributes)
      when :dynect
        Dynect.new(attributes)
      when :linode
        Linode.new(attributes)
      when :zerigo
        Zerigo.new(attributes)
      when :rackspace
        Rackspace.new(attributes)
      else
        raise ArgumentError.new("#{provider} is not a recognized dns provider")
      end
    end

    def self.providers
      Fog.services[:dns]
    end

    def self.zones
      zones = []
      for provider in self.providers
        begin
          zones.concat(self[provider].zones)
        rescue # ignore any missing credentials/etc
        end
      end
      zones
    end

  end
end
