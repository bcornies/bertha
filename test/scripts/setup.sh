#!/bin/bash

cd /tmp
git clone https://github.com/bcornies/bertha.git bertha

cd bertha

cp hiera/defaults.yaml.template hiera/defaults.yaml
sed -i 's/bertha::websites_dir: /bertha::websites_dir: \/tmp/g' hiera/defaults.yaml
sed -i 's/bertha::mysql_path: /bertha::mysql_path:  \/tmp/g' hiera/defaults.yaml

cp hiera/websites/project.yaml.template hiera/websites/project.yaml

./bertha.sh project

cd /tmp/project
ant
