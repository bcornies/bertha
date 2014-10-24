#!/bin/bash

# Setup
DEBUG=false
HIERA_CONFIG=configuration/hiera.yaml

function usage {
	echo "Usage: ./bertha [-d] <website>"
	echo "   -d Turns Puppet debugging on"
	echo "   <website> maps to a hiera file in configuration/websites"
}

function check_prereqs {
	command -v bundle
	if [ $? -ne 0 ] ; then
		echo "I require bundler but it's not installed.  Please install by running 'gem install bundler' before proceeding."
		exit 1
	fi
}

function bootstrap {
	bundle install
	librarian-puppet install
}

function run_bertha {
	export FACTER_website=$1
	export FACTER_cwd=`pwd`
	export FACTER_user=$USER
	export FACTER_home=$HOME

	# Build our Puppet command
	MODULE_PATH="modules/core"
	MODULE_PATH="$MODULE_PATH:modules/builders"
	MODULE_PATH="$MODULE_PATH:modules/docks"
	MODULE_PATH="$MODULE_PATH:modules/frameworks"
	MODULE_PATH="$MODULE_PATH:modules/imports"
	MODULE_PATH="$MODULE_PATH:modules/package_managers"
	MODULE_PATH="$MODULE_PATH:modules/servers"

	CMD="puppet apply --hiera_config $HIERA_CONFIG --modulepath=$MODULE_PATH --show_diff --parser future --ordering manifest manifests/main.pp"

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

check_prereqs

if [ ! -f 'bertha.lock' ]; then
	bootstrap
	touch bertha.lock
fi

run_bertha $1
