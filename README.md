# Bertha

Bootstraps _everything_ you need to build websites _your_ way. Declaratively.

Bertha is a full-stack website bootstrapping _and_ maintenance engine built on top of Puppet. You tell it everything you need when you build websites and Bertha will both install and configure it all. You can go from a pristine, just-unboxed workstation to developing your website with every tool you need in minutes.

Due to the idempotent nature of Puppet, you can also use it to incrementally add to, modify, and maintain all of your web projects. Easily keep all of your web projects in-sync and working using the same toolsets and conventions.

Some of the assumptions made may be a bit opinionated but I've tried to keep it as configurable and flexible as possible.

The main components are divided up into the following logical groupings. The intention is to make these **pluggable modules** so anyone can contribute their own modules for different systems:

- **builder** (Current modules: `ant`) The build system you use to compile SASS, concatenate js files, compress images, etc.
- **cms** (Current modules: `html`, `wordpress`, `concrete5`) What kind of web project you're building. Is it a plain HTML website, a Wordpress theme or a Concrete5 theme?
- **frameworks** (Current modules: `sass`, `bourbon`) Any pre-processors or other development frameworks you rely on.
- **package_manager** (Current modules: `local`) Manages all your third-party js files, jquery plugins, css files, etc.

# Requirements

### OS

- Mac OS X Mavericks 10.9.3
- Mac OS X Yosemite 10.10.0

It will _probably_ work on other versions of OS X. It _should_ also work on various Linux distros but it would probably require a little bit of extra compatibility effort.

### Ruby and Bundler

    $ ruby --version
    ruby 2.0.0p353 (2013-11-22 revision 43784) [x86_64-darwin13.2.0]
    $ bertha git:(master) ✗ bundler --version
    Bundler version 1.7.3

# Run it

    Usage: ./bertha [-d] <website>
        -d Turns Puppet debugging on
        <website> maps to a hiera (yaml) file in hieradata/websites

The first time you run bertha, it will bootstrap itself with everything it needs:

* Puppet (the configuration engine bertha is built on)
* r10k (for installing required Puppet modules)

It will create a `bertha.lock` file after the first run. This prevents it from attempting to bootstrap itself more than once. If you want to force it to re-run the bootstrap, just delete the `bertha.lock` file. I'm sure there's a better way of doing this, but this works for now and it saves time when running `bertha` repetitively.
