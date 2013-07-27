module VagrantPlugins::HostShell
  class Config < Vagrant.plugin('2', :config)
    attr_accessor :inline

    def initialize
      @inline = UNSET_VALUE
    end

    def finalize!
      @inline = nil if @inline == UNSET_VALUE
    end

    def validate(machine)
      errors = _detected_errors

      unless inline
        errors << ':host_shell provisioner requires inline to be set'
      end

      { 'host shell provisioner' => errors }
    end
  end
end
