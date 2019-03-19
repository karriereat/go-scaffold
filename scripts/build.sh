#!/usr/bin/env bash
set -e

if [ ! -z $1 ]; then
    VERSION=$1
fi

# Get the version from the command line
if [ -z $VERSION ]; then
    echo "Please specify a version."
    exit 1
fi

# If its dev mode, only build for ourself
if [ "$VERSION" == "dev" ]; then
    XC_OS=$(go env GOOS)
    XC_ARCH=$(go env GOARCH)
fi

# Get the parent directory of where this script is.
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
DIR="$( cd -P "$( dirname "$SOURCE" )/.." && pwd )"

# Change into that directory
cd "$DIR"

echo -n "## Recreate directory... "
rm -rf build && mkdir build
echo "OK"

# instruct to build statically linked binaries
export CGO_ENABLED=0

# build cmds
echo "## Build..."
if [ -d ./cmd ]; then
    for cmd in ./cmd/*; do
        if [ ! -d "$cmd" ]; then
            continue
        fi
        for OS in $XC_OS; do
            for ARCH in $XC_ARCH; do
                if ([ $OS == "darwin" ] && ([ $ARCH == "386" ] || [ $ARCH == "arm" ])) ||
                ([ $OS == "windows" ] && [ $ARCH == "arm" ])
                then
                    continue
                fi
                GOOS=$OS GOARCH=$ARCH go build -o build/$OS-$ARCH/${cmd##*/} ./cmd/${cmd##*/}
                echo "- $OS-$ARCH finished"
            done
        done
    done
fi