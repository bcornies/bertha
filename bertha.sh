#!/bin/bash

# Defaults
DEBUG=false
HIERA_DIR=hieradata/hiera.yaml

function usage {
	echo "Usage: ./bertha [-d] <website>"
	echo "   -d Turns Puppet debugging on"
	echo "   <website> maps to a hiera file in hieradata/websites"
}

function bootstrap {
  if [ -f 'bertha.lock' ]; then
    return
  fi

  sudo gem install bundler
  bundle install
  r10k puppetfile install

  touch bertha.lock
}

function run_bertha {
  # Build our Puppet command
  CMD="sudo FACTER_website=$1 puppet apply --hiera_config $HIERA_DIR --modulepath=bertha_modules:modules --parser future manifests/main.pp"

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

bootstrap
run_bertha $1
