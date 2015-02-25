# Creating a CMS module

A custom CMS module is nothing more than a Puppet module that...

- bootstraps a skeleton theme
- manages the development server configuration
- defines deployment logic

A CMS module must have the following minimum structure:

    `files`
      |- `server`
          |- `Puppetfile` (required!)
    `manifests`
      |- `init.pp` (required!) <- declares any necessary parameters and includes class declared in other manifests
      |- `theme.pp` <- manages all files and directories required to bootstrap a skeleton theme for the CMS
      |- `config.pp` <- manages any configuration file templates for connecting to a CMS database (for example)
      |- `tools.pp` <- ensures any client tools that are required to work with CMS are installed locally
    `templates`
      |- `server`
          |- `deploy.xml.erb` <- A deployment engine with logic for how to deploy and configure for all environments
          |- `site.pp.erb` (required!) <- Puppet manifest for provisioning development virtual machine to run CMS
      |- `css.php.erb` <-
      |- `js.php.erb`

When creating a new CMS module for use in Puppet, you need to address five requirements:

1. Theme scaffolding and layout
2. How css and js files get included
3. Web server provisioning
4. Deployment tasks
5. Local tooling

We'll walk through these one at a time. This documentation is based on the Concrete5 CMS module, you can follow along in the code as you read through each section.

## `manifests/init.pp`

This is the entry point into a Puppet module. Here you can specify any parameters that your module accepts to customize its behaviour. You can put all of your Puppet resources here if you like but we're going to split our Puppet logic into the helper classes listed below.

## `manifests/theme.pp`

The `theme.pp` Puppet manifest will deal with building a skeleton of everything required to create a theme in your CMS. It should ensure that all directories and files that are required to create a minimally viable theme are present. The files should be boilerplated so a theme developer can get up and running as fast as possible.
