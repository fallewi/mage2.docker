#!/bin/bash

set -e


message () {
  echo "";
  echo -e "$1"
  echo "------------------------------------------------------------------------------"
}

dockerRefresh() {
    if ! [[ -x "$(command -v docker-compose)" ]]; then
        message 'Error: docker-compose is not installed.' >&2
        exit 1
    fi

    if [[ $(uname -s) == "Darwin" ]]; then
        osxExtraPackages
        rePlaceInEnv "false" "SSL"
        osxDockerSync
        message "docker-compose -f docker-compose.osx.yml up -d"
        docker-compose -f docker-compose.osx.yml up -d
    else
        message "docker-compose up -d;"
        docker-compose up -d
    fi

    message "sleep for 1min";
    sleep 60;
}

dockerRefresh