# Intro

** This project is very much a work in progress! There are no official releases yet. **

Bertha is a website bootstrapping engine built on top of Puppet.

Features:

* Bootstraps 3 different kinds of web projects:
    * Plain ol' HTML5 site
    * Concrete5 theme (not implemented yet)
    * Wordpress theme (not implemented yet)
* Dynamically patch existing projects with features added after initial project bootstrap
* Drop-in any javascript, css, or sass frameworks and pick-and-choose which projects need what
* Builds a custom Ant build script for each project that...
    * Compiles your scss files
    * Minifies and concatenates your css and js
    * Publishes your project via FTP
    * Keeps your CMS databases in sync

# Prerequisites

### This has only been tested on Mac OS X Mavericks 10.9.3

You should only need Ruby installed. I'm using 2.0.0 currently.

# Run it

    Usage: ./bertha [-d] <website>
        -d Turns Puppet debugging on
        <website> maps to a hiera (yaml) file in hieradata/websites

The first time you run bertha, it will bootstrap itself with everything it needs:

* bundler (for installing required ruby gems)
* Puppet (the configuration engine bertha is built on)
* r10k (for installing required Puppet modules)

It will create a `bertha.lock` file after the first run. This prevents it from
attempting to bootstrap itself more than once. If you want to force it to re-run
the bootstrap, just delete the `bertha.lock` file.
