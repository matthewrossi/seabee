# Troubleshooting

Help! Something is broken!

If you don't find a solution here, please create an issue on our GitHub,
we apologize this project is still under active development.

## Is SeaBee Failing to build?

### missing a dependency

something may have gone wrong with the `update_dependencies.sh` script.

Try running `make udpate` again

### bpftool not found

The following error occurs with how `bpftool` is installed on ubuntu.
`bpftool` needs to match the underlying kernel version.
If you recently ran `apt upgrade` or `make update`, you may have installed
a new kernel version. You should reboot into that new kernel and recompile
SeaBee for the newer kernel.

```Bash
WARNING: bpftool not found for kernel 5.15.0-144
    You may need to install the following packages for this specific kernel:
      linux-tools-5.15.0-144-generic
      linux-cloud-tools-5.15.0-144-generic
    You may also want to install one of the following packages to keep up to date:
      linux-tools-generic
      linux-cloud-tools-generic
  Error: failed to generate vmlinux.h: failed to generate vmlinux using bpftool: exit status: 2
```

### Issues with kernel modules

Most of the issues with kernel modules can be solved by recompiling the kernel modules
or rebooting.

- `make clean` and `make test`
- `sudo reboot`

Some errors I've encountered and fix this way:

```Bash
# Failing to load kernel modules during testing
modprobe: ERROR: could not insert 'test_kmod': Operation not permitted
```

[Issue 11](https://github.com/NationalSecurityAgency/seabee/issues/11) and [Issue 36](https://github.com/NationalSecurityAgency/seabee/issues/36)
are related to kernel modules.

## SeaBee won't turn off

- check with `systemctl status <daemon_name>` or with `ps -aux | grep seabee`

If so, we will need to shut it off. If SeaBee is running with the `--sigint allow` option,
then we can kill it with `sudo kill -2 <Pid>` or `systemctl stop <daemon_name>`.

## SeaBee state corrupted

If SeaBee's saved state is corrupted, first shut SeaBee down and wait for its
protections to unload. Then, to reset all saved state, run:

```bash
sudo rm -r /etc/seabee
```

This permanently removes all saved keys, policies, signatures, the root key, and
configuration. You must reinstall a root key before starting SeaBee again.

Once that is done, you should be able to use the [getting started](./getting_started.md) instructions to get SeaBee working again from scratch.

## Checking the SeaBee Logs

See [logging](./logging.md)
