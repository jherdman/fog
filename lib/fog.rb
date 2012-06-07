require 'fog/core'

module Fog

  unless const_defined?(:VERSION)
    VERSION = '1.3.1'
  end

  autoload :CDN,      'fog/cdn'
  autoload :Compute,  'fog/compute'
  autoload :DNS,      'fog/dns'
  autoload :Identity, 'fog/identity'
  autoload :Image,    'fog/image'
  autoload :Storage,  'fog/storage'
  autoload :Volume,   'fog/volume'

end

# FIXME: these should go away (force usage of Fog::[Compute, CDN, DNS, Storage]  etc)
require 'fog/providers'
require 'fog/terremark'
