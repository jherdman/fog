module Fog
  module Compute

    autoload :AWS,            'fog/aws/compute'
    autoload :Bluebox,        'fog/bluebox/compute'
    autoload :Brightbox,      'fog/brightbox/compute'
    autoload :Cloudstack,     'fog/cloudstack/compute'
    autoload :Clodo,          'fog/clodo/compute'
    autoload :Ecloud,         'fog/ecloud/compute'
    autoload :Glesys,         'fog/glesys/compute'
    autoload :GoGrid,         'fog/go_grid/compute'
    autoload :HP,             'fog/hp/compute'
    autoload :IBM,            'fog/ibm/compute'
    autoload :Joyent,         'fog/joyent/compute'
    autoload :Libvirt,        'fog/libvirt/compute'
    autoload :Linode,         'fog/linode/compute'
    autoload :BareMetalCloud, 'fog/bare_metal_cloud/compute'
    autoload :Ninefold,       'fog/ninefold/compute'
    autoload :OpenStack,      'fog/openstack/compute'
    autoload :Ovirt,          'fog/ovirt/compute'
    autoload :Rackspace,      'fog/rackspace/compute'
    autoload :StormOnDemand,  'fog/storm_on_demand/compute'
    autoload :Vcloud,         'fog/vcloud/compute'
    autoload :Voxel,          'fog/voxel/compute'
    autoload :Vsphere,        'fog/vsphere/compute'
    autoload :XenServer,      'fog/xenserver/compute'

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
      when :brightbox
        Brightbox.new(attributes)
      when :cloudstack
        Cloudstack.new(attributes)
      when :clodo
        Clodo.new(attributes)
      when :ecloud
        Ecloud.new(attributes)
      when :glesys
        Glesys.new(attributes)
      when :gogrid
        GoGrid.new(attributes)
      when :hp
        HP.new(attributes)
      when :ibm
        IBM.new(attributes)
      when :joyent
        Joyent.new(attributes)
      when :libvirt
        Libvirt.new(attributes)
      when :linode
        Linode.new(attributes)
      when :new_servers
        warn "[DEPRECATION] `new_servers` is deprecated. Please use `bare_metal_cloud` instead."
        BareMetalCloud.new(attributes)
      when :baremetalcloud
        BareMetalCloud.new(attributes)
      when :ninefold
        Ninefold.new(attributes)
      when :openstack
        OpenStack.new(attributes)
      when :ovirt
        Ovirt.new(attributes)
      when :rackspace
        Rackspace.new(attributes)
      when :stormondemand
        StormOnDemand.new(attributes)
      when :vcloud
        Fog::Vcloud::Compute.new(attributes)
      when :virtualbox
        VirtualBox.new(attributes)
      when :vmfusion
        Vmfusion.new(attributes)
      when :voxel
        Voxel.new(attributes)
      when :vsphere
        Vsphere.new(attributes)
      when :xenserver
        XenServer.new(attributes)
      else
        raise ArgumentError.new("#{provider} is not a recognized compute provider")
      end
    end

    def self.providers
      Fog.services[:compute]
    end

    def self.servers
      servers = []
      for provider in self.providers
        begin
          servers.concat(self[provider].servers)
        rescue # ignore any missing credentials/etc
        end
      end
      servers
    end

  end
end
