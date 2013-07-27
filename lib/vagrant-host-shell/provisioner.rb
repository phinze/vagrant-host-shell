module VagrantPlugins::HostShell
  class Provisioner < Vagrant.plugin('2', :provisioner)
    def provision
      Vagrant::Util::Subprocess.execute(
        '/bin/bash',
        '-c',
        config.inline
      )
    end
  end
end
