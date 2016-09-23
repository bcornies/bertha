# Bertha

Bootstraps _everything_ you need to develop a Wordpress website. Declaratively.

Bertha is a full-stack website bootstrapping _and_ configuration engine built on top of Puppet. You tell it everything you need when you build websites and Bertha will both install and configure it all. You can go from a pristine, just-unboxed workstation to developing your website with every tool you need in minutes.

Here's what Bertha will setup for you:

* Customizable WordPress theme skeleton
  * SASS support
  * WordPress plugin management
  * JS, SASS, CSS library management
* Sandboxed development webserver using Vagrant
* Build scripts to minify and bundle your website for deployment
* Deployment scripts for syncing and deploying to multiple webservers

Due to the idempotent nature of Puppet, you can also use it to incrementally add to, modify, and maintain all of your web projects. Easily keep all of your web projects in-sync and working using the same toolsets and conventions.

Some of the assumptions made may be a bit opinionated but I've tried to keep it as configurable and flexible as possible.

# Requirements

### OS

- Mac OS X Mavericks 10.9.3 and above

It will _probably_ work on other versions of OS X. It _should_ also work on various Linux distros but it would probably require a little bit of extra compatibility effort.

### Ruby and Bundler

    $ ruby --version
    ruby 2.0.0p353 (2013-11-22 revision 43784) [x86_64-darwin13.2.0]
    $ bundler --version
    Bundler version 1.7.3

# Getting Started

## 1. Configure it

### Rename defaults.yaml.template -> defaults.yaml

Customize to your preferences.

### Create a website.yaml

Copy configuration/websites/project.yaml.template to configuration/websites/<your_project_name>.yaml.

Customize to your preferences.

## 2. Run it

    Usage: ./bertha.sh [-d] <website>
        -d Turns Puppet debugging on
        <website> maps to a hiera (yaml) file in hieradata/websites

The first time you run Bertha, it will bootstrap itself with everything it needs:

* Puppet (the configuration engine bertha is built on)
* r10k (for installing required Puppet modules)

It will create a `bertha.lock` file after the first run. This prevents it from attempting to bootstrap itself more than once. If you want to force it to re-run the bootstrap, just delete the `bertha.lock` file. I'm sure there's a better way of doing this, but this works for now and it saves time when running `bertha` repetitively.
