# Intro

** This project is very much a work in progress! There are no official releases yet. **

Bertha is a website bootstrapping engine built on top of Puppet.

Features:

* Bootstraps 3 different kinds of web projects:
    * Plain ol' HTML5 site
    * Concrete5 theme
    * Wordpress theme
* Dynamically patch existing projects with features added after initial project bootstrap
* Drop-in any javascript, css, or sass frameworks and pick-and-choose which projects need what
* Builds a custom Ant build script for each project that...
    * Compiles your scss files
    * Minifies and concatenates your css and js
    * Publishes your project via FTP
    * Keeps your CMS databases in sync

# Setup it up

### For Mac OS X (Tested on Mavericks 10.9.3)

1. Download the latest puppet, hiera and facter dmg packages from [PuppetLabs' Mac OS X Downloads](https://downloads.puppetlabs.com/mac/)

2. Install all three dmg packages

3. Install the rgen Ruby gem (this is required for Puppet's future parser)

    $ sudo gem install rgen

# Run it

    Usage: ./bertha [-d] <website>
        -d Turns Puppet debugging on
        <website> maps to a hiera file in hieradata/websites