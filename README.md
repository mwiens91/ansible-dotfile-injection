# ansible-dotfile-injection

There are two Ansible playbooks in this repo. The first,
`nonroot_playbook.yaml`, adds your public ssh key to the remotes'
`authorized_hosts` file and transfers dotfiles from the local machine to
remote machines; the second, `root_playbook.yaml`, installs useful
programs to the remote machines and additionally transfers over some zsh
configuration files. `nonroot_playbook.yaml`, as indicated by its name,
doesn't require root access on the remote machines;
`root_playbook.yaml`, as indicated by *its* name, does require root
access on remote machines—it also assumes the remotes are using `apt` as
their package managers, so Red Hat and similar are not supported :(

As it goes with most Ansible playbooks, these will only work on both
local and remote machines that don't have prehistoric versions of
Python—sadly, not a foregone conclusion.

## Running the playbooks

Put the hosts you want to inject dotfiles to in `hosts.yaml`. Then, to
run either playbook, use

```
ansible-playbook this_playbook.yaml -i hosts.yaml
```

(the `-vvv` very very verbose flag is useful if tasks are mysteriously
failing)

For convenience, you can run `combined_playbook.yaml` to run both of the
playbooks, which executes `nonroot_playbook.yaml` first and then
`root_playbook.yaml` second.

## Why this is great

A common approach to manage dotfiles across machines is to bundle them
together in a git repository. If you prefer that, great! But this
approach has some unique benefits:

+ none of your dotfiles are pushed online (security)
+ this injects your public ssh key (functionality)
+ this installs common programs (functionality)
+ straightforward to add/exclude dotfiles/tasks (mutability)
+ all of this happens in one command (simplicity)

The downside, which is a very big downside if you're working on ancient
machines, is that

+ you **need** to have Ansible supported
