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
        options = {
          new_line: false,
          prefix: false,
        }

        color = io_name == :stdout ? :green : :red
        options[:color] = color # if !config.keep_color

        @machine.env.ui.info(data, options)
      end

      if config.abort_on_nonzero && !result.exit_code.zero?
        raise VagrantPlugins::HostShell::Errors::NonZeroStatusError.new(config.inline, result.exit_code)
      end

    end
  end
end
