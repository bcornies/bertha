# Creating a cms module

When creating a new cms module for use in Puppet, you need to address three responsibilities:

1. Theme scaffolding and layout
2. Web server provisioning
3. Deployment tasks
4. Local tooling

We'll walk through these one at a time.

## Theme scaffolding and layout

Bertha is setup to support theme development for CMS systems. This means that any projects created by Bertha will contain only the elements required for a single theme. It will _not_ contain _any_ CMS framework files.

You will be responsible for ensuring that the CMS module creates any files/directories necessary for a functioning theme within your CMS.

## Web server provisioning

Bertha projects use a local VM for a development environment. The Bertha Core supplies a Vagrantfile for you project that will manage your local VM. However, your CMS module needs to know what to put on the VM and how to provision it.

Tasks typically include installing a web server (such as Apache), a database and the CMS framework.

## Deployment tasks

Each CMS requires a different approach to deploying/installing your theme and managing the upload content and data. Here you will support 1 or more builders by implementing a build script that handles these deploy tasks.

## Local tooling

If your CMS deploy tasks require certain binaries or tools to be present, this is where you ensure they're installed. For example, the WordPress CMS module requires that the `mysqldump` tool be installed on your system.
