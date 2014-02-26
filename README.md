# Configs

## Bashrc

Some of the things in my bashrc that I really like:

* History is saved per tty so one terminal doesn't overwrite history
  from another. Everything is saved in ~/.history.
* Function ff to find a file with matching pattern. I use this a lot.
* The 'edit' function which when run on a remote machine, calls back
  to the machine I am on and opens the remote file in Emacs using
  Tramp. This means I don't need to edit remotely and edit without lag
  with a known emacs config.
* My colorful two line prompt:
  * Current time and filesystem path. Path turns red if last command
    failed. Also shows git branch and status if in a git repo.
  * Shows user and hostname. User is red when root.
* Function 'sagent'; if ssh-agent has valid key, setup environment so
  that ssh key exchange works.

## Tmux

I am still trying to integrate tmux into my workflow so don't look at
the tmux configuration too closely.

# Emacs

The emacs config is managed by [El-Get][1]. Some of the reasons I like
it is that it contains every piece of emacs config that I have every
wanted to add. It has stabilized and makes it easy to keep my emacs
setup in sync at work and at home. Here are some of the modules that I
really like

## Org-mode

I keep my todo list in org. I have used org-beamer to make
presentation slides. It is a great tool.

## Magit

No need to switch to terminal to commit and push new code. I use it
all the time and it works well.

## Undo Tree

This package completely changed the way I think about undo and redo. I
have written my own undo/redo stack and I remember dropping redo
events when new events come in. This package saves everything in a
tree format and allows traversal of all the event state. I haven't
used it often, but it has come in really handy a few times.

## Flycheck

Puppet must be installed. I use latest from puppetlabs. To install
puppet-lint as normal user I used:

    gem install --user-install puppet-lint
    ln -s ~/.gem/ruby/1.9.1/bin/puppet-lint ~/bin/puppet-lint

To enable C++ syntax checking:

    sudo aptitude install clang

## Clang-complete-async

On 13.10 the clang version is 3.2 and to get things to compile I had
to make a link to llvm-config:

    sudo aptitude install libclang-dev
    ln -s /usr/bin/llvm-config-3.2 ~/bin/llvm-config

To get it to run I had to all libclang to library path:

    echo "/usr/lib/llvm-3.2/lib" > /tmp/llvm.conf
    sudo mv /tmp/llvm.conf /etc/ld.so.conf.d/
    sudo ldconfig

[1]: http://tapoueh.org/emacs/el-get.html
