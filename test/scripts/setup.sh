#!/bin/bash

cd /tmp
git clone https://github.com/bcornies/bertha.git bertha

cd bertha

cp configuration/defaults.yaml.template configuration/defaults.yaml
sed -i 's/bertha::websites_dir: /bertha::websites_dir: \/tmp/g' configuration/defaults.yaml
sed -i 's/bertha::mysql_path: /bertha::mysql_path:  \/tmp/g' configuration/defaults.yaml

cp configuration/websites/project.yaml.template configuration/websites/project.yaml

./bertha.sh project

cd /tmp/project
ant
