# Creating a Bertha "CMS" module

## Overview

A custom CMS module is a Puppet module that provisions everything you need to create and test a theme for your chosen CMS platform. In a nutshell, this entails...

- bootstrapping your project with all the files/directories required to create a theme in your CMS
- creating a development VM that runs your CMS and all of its prerequisites
- providing tools for deploying your theme onto your development VM

## File Structure Walkthrough

A Bertha CMS module will typically have the following structure:

    `files`
      |- `server`
          |- `Puppetfile`
    `manifests`
      |- `init.pp`
      |- `theme.pp`
      |- `config.pp`
      |- `tools.pp`
    `templates`
      |- `server`
          |- `deploy.xml.erb`
          |- `site.pp.erb`
      |- `theme_path.erb`



We'll walk through these one at a time. This documentation is based on the Concrete5 CMS module, you can follow along in the code as you read through each section.



### manifests

This is where your Puppet manifests live. They are responsible to staging and maintaining your CMS-based projects as well as ensuring your workstation has all the necessary tools installed to work with the CMS.

- `init.pp` - This is the entry point into a Puppet module. Here you can specify any parameters that your module accepts to customize its behaviour. You can put all of your Puppet resources here if you like but we're going to split our Puppet logic into the helper classes listed below.
- `theme.pp` - The `theme.pp` Puppet manifest should deal with building a skeleton of everything required to create a theme in your CMS. It ensures that all directories and files that are required to create a minimally viable theme are present. The files should be [boilerplate](http://test.com)-d so a theme developer can get up and running as fast as possible.
- `config.pp` - Manages any deployment scripts and configuration that is required to run your CMS. This typically consists of a database configuration file so your CMS can talk to the correct database.
- `tools.pp` - Ensures any tools that are required for managing and deploying your CMS-based project are installed on the user's workstation.

### files

- `Puppetfile` - Responsible for ensuring that all Puppet modules required for building a local development VM to host your CMS are downloaded and included when running Vagrant.

### templates

- `theme_path.erb` - This defines your CMS-specifc code snippet generating the theme path. This gets used when creating the `<script>` and `<style>` tags that will end up in the `head` element.
- `server/deploy.xml.erb` - A deploy script that handles installing and configuring your theme onto a server running your CMS. This can be any kind of script and can use any deployment/scripting technology you choose. Just be sure to ensure that any tools required to run your deployment script are installed! You should place any tool requirements in the `tools.pp` manifest.
- `server/site.pp.erb` - A Puppet manifest that gets run as part of the provisioning phase of local development VM creation via Vagrant. This manifest declares everything that needs to be installed and configured on your VM to create a fully-functional development environment for CMS theme development. It should ensure: a) that an apporprate web server is installed and running, b) your CMS is installed, and c) a database is installed with any necessary users/grants already configured.

## Getting Started

**Note:** This tutorial assumes that you already have a reasonable familiarity with [Puppet](). If not, there is an [excellent guided tutorial]() that Puppetlabs has made available for learning Puppet.

We will walk through the process of creating a Bertha CMS module for Wordpress.

To start we'll need to create a new project directory. We'll call it `bertha-wordpress`. Prefixing Bertha module projects with `bertha-` is a standard convention. The `bertha-wordpress` is the name of the `project` (and Git repo). The _module name_ is everything after the prefix, so our _module name_ is `wordpress`.

    $ mkdir bertha-wordpress
    $ cd bertha-wordpress

Now, let's make our "entry point" into our module. In the Puppet world, this is the `init.pp` manifest. Let's create that now.

    $ mkdir manifets
    $ touch init.pp

Inside of `init.pp` we will create a class that has the same name as our module. The name of the class must exactly match the name of our module. Inside of the class we'll put a simple notify resource that will let us know that everything is wired up properly once we've integrated our module into Bertha.

    # Content of init.pp
    class wordpress {
      notify { 'Hello world': }
    }

## Integrating with Bertha

Eventually, we will publish your module to Github and give Bertha the URL for downloading and installation. For now (and for ease of development) we will symlink your module into Bertha's `modules` directory. So, if you haven't, clone Bertha onto your local workstation.

### Install Bertha

    $ git clone git@github.com:bcornies/bertha.git
    $ cd bertha
    $ ./bertha.sh
    No arguments supplied
    Usage: ./bertha [-d] <website>
    -d Turns Puppet debugging on
    <website> maps to a hiera file in configuration/websites


### Configure Bertha

Now that Bertha is installed, we need setup some default configurations for it to use. Bertha ships with a template for the default configuration. We can simply copy it and name it defaults.yaml (case-sensitive!).

    $ cd configuration
    $ cp defaults.yaml.template defaults.yaml

Let's tell Bertha our preferences by editing the `defaults.yaml` file. We just want set the bare minimum required to get Bertha running so we can test our `wordpress` module.

    # fully qualified path to a directory where you want your websites to reside
    bertha::websites_dir: /Users/<you>/websites


### Configure a new Website Project

we'll need to create a new website configuration so we have something to test. A website configuration consists of a home directory and some other data that tells Bertha what kind of website it will be. We do this by creating a new yaml configuration file in `configuration/websites`. We will call it `tutorial.yaml`.

    $ cd configuration/websites
    $ touch tutorial.yaml

For now, all Bertha needs to know about our new website project is that it will be a wordpress theme. We do this by specifying the `cms` key as `wordpress`.

    # Content of tutorial.yaml
    cms: wordpress

Let's try running Bertha now.

    $ ./bertha.sh tutorial
    Error: Evaluation Error: Error while evaluating a Function Call, Could not find class ::wordpress for bryans-macbook-pro at     /private/tmp/tutorial/bertha/manifests/main.pp:24:1 on node bryans-macbook-pro

### Link your CMS module into Bertha

Since we haven't told Bertha about our new `wordpress` module it doesn't recognize the name of the class. For now, we'll create a symlink so our `wordpress` module gets included in the `modules` directory of Bertha.

    $ ln -s /path/to/your/projects/bertha-wordpress modules/wordpress
    $ ./bertha.sh tutorial
    Error: Could not find template 'wordpress/theme_path.erb' on node bryans-macbook-pro

That looks better. Our Wordpress module is integrated with Bertha. Now we need to add in the necessary files that are required of every CMS module.

### Adding required files to your CMS module

#### Create some empty file placeholders

    $ mkdir templates/server
    $ touch templates/server/site.pp.erb
    $ mkdir files
    $ mkdir files/server
    $ touch files/server/Puppetfile

#### JS and CSS inclusion strategies

How does your CMS handle including javascript and CSS files? Depending on the your answer you have 2 options in how to handle this in your CMS module.

**Note:** For our Wordpress module, we'll be going with Option 2.

**Option 1 - A simple theme path**

If your CMS only requires a small PHP injection in your `<script>` or `<style>` tags, then this is the option for you.

You create a `templates/theme_path.erb` file in your module. This is a Ruby ERB template file. It should contain a single line that specifies the code snippet your CMS uses for pathing to the "theme" directory (or your CMS's equivalent). This is the path that gets added to `<script>` and `<style>` tags when specifying javascript and css files in your html header.

    # Example templates/theme_path.erb file (from bertha-concrete5)
    <?php echo $this->getThemePath(); ?>

A resulting `<script>` tag would look like: `<script type="text/javascript" src="<?php echo $this->getThemePath(); ?>/js/lib/jquery-1.11.1.js"></script>`

**Option 2 - A custom includes class**

If the way your CMS handles javascript and CSS file inclusion is more complicated, you will need to create a custom includes class. The will live in a `manifests/includes.pp` file.

    # Content manifests/includes.pp
    class wordpress::includes {
      ...Puppet code...
    }

That's the easy part. Now for the _real_ work. We have access to the global `$::libraries` variable in our class. This is a hash of all the libraries a developer wants to include in their Website project. Wordpress handles library includes using the `wp_enqueue_style()` and `wp_enqueue_script()` functions which can be found in the `functions.php` file. I think we're going to want to create an ERB template for this file so that we can iterate over our `$::libraries` and include them in the appropriate manor using the aforementioned functions.

    $ touch templates/functions.php.erb


    $ ./bertha.sh tutorial
    ...
    Notice: /Stage[main]/Wordpress/Notify[Hello world!]/message: defined 'message' as 'Hello world!'






## Parking Lot Content

You should support 2 different database configuration files:
- A pre-populated one used for connecting to your development environment
- A static template that can be used to inject environment-specific configuration during deployment



When creating a new CMS module for use in Puppet, you need to address five requirements:

1. Theme scaffolding and layout
2. How css and js files get included
3. Web server provisioning
4. Deployment tasks
5. Local tooling
