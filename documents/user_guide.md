# Initial setup

After cloning Bertha, you'll need to do some one-time setup to tell it about your system.

1. Navigate to the `configuration` directory and edit rename (or copy) `defaults.yaml.template` to `defaults.yaml`.
2. Edit `defaults.yaml`, filling in values that reflect your working environment and preferences.

## A note about configuration (bonus reading)

Bertha relies on a configuration engine called [Hiera](https://docs.puppetlabs.com/hiera/1/). Bertha defines a configuration hierarchy that it uses to determine which parameter values to use for your different website projects. By default, all projects inherit values from `defaults.yaml`, pretty self-explanatory stuff. Then, depending on which CMS system a project requires, Bertha will look up values in the appropriate yaml file in the `cms` directory. Lastly, you can create project-specific yaml files in the `websites` directory. Here you can set any parameters that are unique to a specific project.

## Configuration Parameters

- `bertha::websites_dir` - The directory you want your website projects to live.
- `bertha::server_ip` -
- `bertha::server_network` -
- `bertha::is_cms` -
- `bertha::view_mode` -
- `bertha::mysql_path` -
- `bertha::sites` -
- `bertha::dist_items` -
