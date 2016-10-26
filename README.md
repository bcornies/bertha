# Bertha

A WordPress theme bootstrapper built with Puppet.

Bertha is a full-stack WordPress theme bootstrapping and configuration engine built on top of Puppet. You tell it everything you need when you build a WordPress theme and Bertha will install, configure and provision a new WordPress theme project skeleton for you, ready to develop and test.

Here's what Bertha will setup for you:

* SASS framework and skeleton style files
* WordPress plugins
* JS, SASS, CSS libraries
* Font Awesome framework
* Apache webserver VM using Vagrant
* Build scripts to minify and bundle your website for deployment
* Deployment scripts for syncing and deploying to multiple webservers

Due to the idempotent nature of Puppet, you can use it to evolve your WordPress theme development standards, and ensure all of your themes stay up-to-date with your latest standards. Easily keep all of your WordPress theme projects in-sync and working using the same toolsets and conventions.

# Requirements

### OS

- Mac OS X Mavericks 10.9.3 and above

It will probably work on other versions of OS X. It should also work on various Linux distros but it would probably require a little bit of extra compatibility effort.

### Ruby and Bundler

    $ ruby --version
    ruby 2.0.0p353 (2013-11-22 revision 43784) [x86_64-darwin13.2.0]
    $ bundler --version
    Bundler version 1.7.3

# Getting Started

## 1. Configure it

### (Optional) Edit the default configuration

Browse to the `configuration` directory. Open the `defaults.yaml` file and edit to suit your preferences. These are all the default settings that your website project will inherit.

### Create a new website configuration

Copy `configuration/websites/project.yaml.template` to `configuration/websites/<your_project_name>.yaml`. This file will contain any configurations that are specific to your new website project.

Here you can override any default settings in the `defaults.yaml` file.

## 2. Run it

    Usage: ./bertha.sh [-dt] <website>
        -d Turns Puppet debugging on
        -t Turns Puppet error tracing on
        <website> maps to a hiera (yaml) file in configuration/websites

The first time you run Bertha, it will bootstrap itself with everything it needs:

* Puppet (the configuration engine bertha is built on)
* r10k (for installing required Puppet modules)

It will create a `bertha.lock` file after the first run. This prevents it from attempting to bootstrap itself more than once. If you want to force it to re-run the bootstrap, just delete the `bertha.lock` file. I'm sure there's a better way of doing this, but this works for now and it saves time when running `bertha` repetitively.

## 3. Launch development environment

### Navigate to your new WordPress theme project

    $ cd /path/to/your/project

_By default, this will be in the `bertha::websites_dir` as configured in `configuration/defaults.yaml`._

### Create development distribution

    $ ant dist-develop

_This will create a `dist` directory in your project with compiled/minimized versions of your libraries and an environment-specific `wp-config.php` file._

### Create and provision your Vagrant Apache webserver VM

    $ vagrant up

## 4. Configure WordPress

#### a. Browse to http://ip.of.your.server

You should see this address at the top of the `vagrant up` output.

#### b. Fill out WordPress setup form

## 5. Run SASS watcher

    $ ./run_sass.sh

## 6. Develop and test your theme!

Simply save your file and refresh your browser.
