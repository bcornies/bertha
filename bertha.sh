#!/bin/bash

# Defaults
DEBUG=false
HIERA_DIR=hieradata/hiera.yaml

function usage {
	echo "Usage: ./bertha [-d] <website>"
	echo "   -d Turns Puppet debugging on"
	echo "   <website> maps to a hiera file in hieradata/websites"
}

# Parse command line options
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

# Set our website fact which hooks into hiera
export FACTER_website=$1

# Build our Puppet command
CMD="puppet apply --hiera_config $HIERA_DIR --modulepath=modules --parser future manifests/main.pp"

if [ $DEBUG == true ]
then
	CMD="$CMD --debug" 
fi

# Run puppet!
$CMD
