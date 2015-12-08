#!/bin/bash

function setupGolang {
    cd
    mkdir -p bin
    ORIGINAL_PATH="$PATH"
    mkdir -p src
    # Build a bootstrap version of Go
    git clone git@github.com:golang/go.git go1.4
    cd go1.4
    export GOBIN=$HOME/go1.4/bin
    git checkout go1.4.2
    cd src
    ./all.bash
    # Now build the current version of Go
    cd
    git clone git@github.com:golang/go.git go
    cd go/src
    export GOBIN=$HOME/go/bin
    ./all.bash
    # Update our local environment
    cd
    # Add a configuration examples to the .bashrc file
    echo 'You problably want to add the following to your .bashrc or .profile'
    echo ''
    echo '# Golang Setup '$(date)
    echo 'export PATH=$PATH:$HOME/bin:$HOME/go/bin'
    echo 'export GOPATH=$HOME'
    echo 'export GOBIN=$HOME/bin'
    echo
}

cat <<EOF

    This script will check to see if go is installed. If go is missing
    then this script will attempt to download go from the golang Github
    repository, compile version 1.4.2 and then use 1.4.2 to compile the 
    current development version of go. These will install to your home 
    directory.

    Often it is easier to install Go from precompiled binaries at 
    golang.org or using your systems' package manager.

EOF

GO_CMD=$(which go)
if [ "$GO_CMD" = "" ]; then
    setupGolang
else
    echo "Go installed at $GO_CMD"
    echo "Version is "$(go version)
    echo "Gospace needs version 1.5 or better to compile."
fi
