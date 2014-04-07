module VagrantPlugins::HostShell
  class Provisioner < Vagrant.plugin('2', :provisioner)
    def provision
      result = Vagrant::Util::Subprocess.execute(
        'bash',
        '-c',
        config.inline,
        :notify => [:stdout, :stderr],
        :workdir => config.cwd
      ) do |io_name, data|
        @machine.env.ui.info "[#{io_name}] #{data}"
      end

      if config.abort_on_nonzero && !result.exit_code.zero?      
        raise VagrantPlugins::HostShell::Errors::NonZeroStatusError.new(config.inline, result.exit_code)  
      end

    end
  end
end
