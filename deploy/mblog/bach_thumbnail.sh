#! /bin/bash

declare -r CURR_DIR=$(cd `dirname $0`;pwd)

TH_PATH=${CURR_DIR}/storage/thumbnails/_signature

find ${TH_PATH} -size +20k | xargs -i gm convert -thumbnail '240x135' -strip {} ${TH_PATH}/{}