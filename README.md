# vagrant-host-shell plugin

a vagrant provisioner to run commands on the host when a VM boots.

simple example based on question asked [on vagrant mailing list](https://groups.google.com/forum/#!topic/vagrant-up/CsNx-FErplY)

## example usage

Install as a plugin:

```
vagrant plugin install vagrant-host-shell
```

Add this to `Vagrantfile`:

```ruby
  config.vm.provision :host_shell do |host_shell|
    host_shell.inline = 'touch /tmp/hostshell-works && echo hello from the host && hostname 1>&2'
  end
```

Run `vagrant up` (or `vagrant provision` if machine is already running.)

Observe that `/tmp/hostshell-works` is present on your host, and that the provisioner output:

```
[stdout] hello from the host
[stderr] (your host's hostname)
```
