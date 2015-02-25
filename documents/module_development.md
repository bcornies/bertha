# Creating a CMS module

A custom CMS module is nothing more than a Puppet module that...

- bootstraps a skeleton theme
- manages the development server configuration
- defines deployment logic

A CMS module must have the following minimum structure:

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

When creating a new CMS module for use in Puppet, you need to address five requirements:

1. Theme scaffolding and layout
2. How css and js files get included
3. Web server provisioning
4. Deployment tasks
5. Local tooling

We'll walk through these one at a time. This documentation is based on the Concrete5 CMS module, you can follow along in the code as you read through each section.

## `manifests` directory

This is where your Puppet manifests live. They are responsible to staging and maintaining your CMS-based projects as well as ensuring your workstation has all the necessary tools installed to work with the CMS.

### `init.pp`

This is the entry point into a Puppet module. Here you can specify any parameters that your module accepts to customize its behaviour. You can put all of your Puppet resources here if you like but we're going to split our Puppet logic into the helper classes listed below.

### `theme.pp`

The `theme.pp` Puppet manifest should deal with building a skeleton of everything required to create a theme in your CMS. It ensures that all directories and files that are required to create a minimally viable theme are present. The files should be [boilerplate](http://test.com)-d so a theme developer can get up and running as fast as possible.

### `config.pp`

Manages any deployment scripts and configuration that is required to run your CMS. This typically consists of a database configuration file so your CMS can talk to the correct database.

You should support 2 different database configuration files:
  - A pre-populated one used for connecting to your development environment
  - A static template that can be used to inject environment-specific configuration during deployment

This manifest should also manage any deployment files/scripts used to deploy your CMS-based project to any environments.

### `tools.pp`

Ensures any tools that are required for managing and deploying your CMS-based project are installed on the user's workstation.

## `files` directory

### `Puppetfile`

The `Puppetfile` is responsible ensuring that all Puppet modules required for building a local development VM to host your CMS are downloaded and included when running Vagrant.

## `templates` directory

### `theme_path.erb`

This defines your CMS-specifc code snippet generating the theme path. This gets used when creating the `<script>` and `<style>` tags that will end up in the `head` element.

### `server/deploy.xml.erb`

A deploy script that handles installing and configuring your theme onto a server running your CMS. This can be any kind of script and can use any deployment/scripting technology you choose. Just be sure to ensure that any tools required to run your deployment script are installed! You should place any tool requirements in the `tools.pp` manifest.

### `server/site.pp.erb`

A Puppet manifest that gets run as part of the provisioning phase of local development VM creation via Vagrant. This manifest declares everything that needs to be installed and configured on your VM to create a fully-functional development environment for CMS theme development. It should ensure...

- an apporprate web server is installed and running
- your CMS is installed
- a database is installed with any necessary users/grants already configured
