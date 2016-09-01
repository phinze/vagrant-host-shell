module VagrantPlugins::HostShell
  class Provisioner < Vagrant.plugin('2', :provisioner)
    def provision
      ssh_info = @machine.ssh_info
      raise Vagrant::Errors::SSHNotReady if ssh_info.nil?

      variables = {
        host_key: machine.name,
        ssh_host: ssh_info[:host],
        ssh_port: ssh_info[:port],
        ssh_user: ssh_info[:username],
        keys_only: ssh_info[:keys_only],
        paranoid: ssh_info[:paranoid],
        private_key_path: ssh_info[:private_key_path],
        log_level: ssh_info[:log_level],
        forward_agent: ssh_info[:forward_agent],
        forward_x11:   ssh_info[:forward_x11],
        proxy_command: ssh_info[:proxy_command],
        ssh_command:   ssh_info[:ssh_command],
        forward_env:   ssh_info[:forward_env],
      }

      template = "commands/ssh_config/config"
      ssh_config = Vagrant::Util::TemplateRenderer.render(template, variables)

      Tempfile.open("#{machine.name}") do |f|
        f.write(ssh_config)
        f.flush()
        result = Vagrant::Util::Subprocess.execute(
          'bash',
          '-c',
          config.inline,
          :notify => [:stdout, :stderr],
          :workdir => config.cwd,
          :env => {
            PATH: ENV["VAGRANT_OLD_ENV_PATH"],
            VAGRANT_SSH_CONFIGFILE: f.path,
          },
        ) do |io_name, data|
          @machine.env.ui.info "[#{io_name}] #{data}"
        end

        if config.abort_on_nonzero && !result.exit_code.zero?
          raise VagrantPlugins::HostShell::Errors::NonZeroStatusError.new(config.inline, result.exit_code)
        end
      end
    end
  end
end
