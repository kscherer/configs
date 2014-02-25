# Configs

emacs config which uses el-get.

bashrc with my crazy prompt

I am still trying to integrate tmux into my workflow so don't look at
the tmux configuration to closely

# Notes for emacs package config

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
