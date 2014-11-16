#! /bin/sh
set -e

squeezeboxserver --user nobody --prefsdir /state/prefs --logdir /state/logs --cachedir /state/cache --charset=utf8
