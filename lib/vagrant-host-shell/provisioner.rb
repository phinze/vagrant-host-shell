module VagrantPlugins::HostShell
  class Provisioner < Vagrant.plugin('2', :provisioner)
    def provision
      Vagrant::Util::Subprocess.execute(
        '/bin/bash',
        '-c',
        config.inline,
        :notify => [:stdout, :stderr]
      ) do |io_name, data|
        @machine.env.ui.info "[#{io_name}] #{data}"
      end
    end
  end
end
