# ansible-dotfile-injection

There are two Ansible playbooks in this repo. Both perform configuration
management on remote machines using configuration files on a local
machine.

The first, [`nonroot_playbook.yaml`](nonroot_playbook.yaml), adds your
public SSH key to the remotes machines' `authorized_hosts` file and
transfers dotfiles from the local machine to remote machines; the
second, [`root_playbook.yaml`](root_playbook.yaml), installs useful
programs to the remote machines and additionally transfers over some Zsh
configuration files. `nonroot_playbook.yaml`, as indicated by its name,
doesn't require root access on the remote machines;
`root_playbook.yaml`, as indicated by *its* name, does require root
access on remote machines—it also assumes the remotes are using `apt` as
their package managers, so non-Debian-based distros are not supported
:disappointed:.

As it goes with Ansible, these will only work on both local and remote
machines that don't have prehistoric versions of Python—sadly, not a
foregone conclusion.

## Running the playbooks

Copy [`hosts.yaml.example`](hosts.yaml.example) to `hosts.yaml` and then
fill in `hosts.yaml` with the hosts you want to run the playbooks on.
Then, to run either playbook, use

```
ansible-playbook this_playbook.yaml -i hosts.yaml
```

(the `-vvv` very very verbose flag may be useful if tasks are
mysteriously failing)

For convenience, you can run
[`combined_playbook.yaml`](combined_playbook.yaml) to run both of the
playbooks, which executes
[`nonroot_playbook.yaml`](nonroot_playbook.yaml) first and then
[`root_playbook.yaml`](root_playbook.yaml) second.

## Why this is great

A common approach to managing dotfiles across machines is to bundle them
together in a Git repository. If you prefer that, great! But this
approach has some unique benefits:

+ none of your dotfiles are pushed online (security)
+ this injects your public SSH key (functionality)
+ this installs common programs (functionality)
+ it's straightforward to add/exclude playbook steps (mutability)
+ all of this happens in one command (simplicity)

The downsides are that

+ you need to have Ansible installed on your local machine
+ you need to be running a Debian-based distro on your remote machines
+ you need to have Python 2.6+ or 3.5+ available on your remote machines
