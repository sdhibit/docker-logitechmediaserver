#! /bin/sh
set -e

squeezeboxserver --prefsdir /state/prefs --logdir /state/logs --cachedir /state/cache --charset=utf8
