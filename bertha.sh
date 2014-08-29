#!/bin/bash

# Setup
DEBUG=false
HIERA_CONFIG=hiera.yaml

function usage {
	echo "Usage: ./bertha [-d] <website>"
	echo "   -d Turns Puppet debugging on"
	echo "   <website> maps to a hiera file in hieradata/websites"
}

function bootstrap {
	sudo gem install bundler
	bundle install

	puppet module install puppetlabs/stdlib --modulepath=modules/imports
	puppet module install bjoernalbers/homebrew --modulepath=modules/imports
}

function run_bertha {
	export FACTER_website=$1
	export FACTER_cwd=`pwd`
	export FACTER_user=$USER
	export FACTER_home=$HOME

	# Build our Puppet command
	MODULE_PATH="modules/core"
	MODULE_PATH="$MODULE_PATH:modules/engines"
	MODULE_PATH="$MODULE_PATH:modules/imports"
	MODULE_PATH="$MODULE_PATH:modules/servers"
	CMD="sudo -E puppet apply --hiera_config $HIERA_CONFIG --modulepath=$MODULE_PATH --show_diff --parser future manifests/main.pp"

	if [ $DEBUG == true ]
	then
		CMD="$CMD --debug"
	fi

	# Run puppet!
	$CMD
}

while getopts ":d" opt; do
	case $opt in
		d)
			DEBUG=true
			;;
		\?)
			echo "Invalid option: -$OPTARG"
			usage
			exit 1
			;;
	esac
done

shift $((OPTIND - 1))

if [ $# -eq 0 ]
then
	echo "No arguments supplied"
	usage
	exit 1
fi

if [ ! -f 'bertha.lock' ]; then
	bootstrap
	touch bertha.lock
fi

run_bertha $1
