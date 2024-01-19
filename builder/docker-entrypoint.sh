#!/bin/bash
#
# Build site, potentially after fetching from GitHub first
#

MKDOCS_CMD="$1"
shift

SITE_DIR="/mkdocs/site"
LISTEN="0.0.0.0:8000"

if [ -f /mkdocs/source/mkdocs.yml -o -f /mkdocs/source/mkdocs.yaml ]; then

    WORKDIR="/mkdocs/source"

else

    mkdir -p /mkdocs/source-remote

    if [ -n "$GITHUB_SOURCE" ]; then

        git clone "$GITHUB_SOURCE" /mkdocs/source-remote

        if [ -n "$GITHUB_CHECKOUT" ]; then

            ( cd /mkdocs/source-remote && git checkout "$GITHUB_CHECKOUT" )

        fi

    else

        echo "Local source does not contain mkdocs.(yml|yaml), and GITHUB_SOURCE not provided."
        exit 10

    fi

    WORKDIR="/mkdocs/source-remote"
fi

cd $WORKDIR

case $MKDOCS_CMD in
    build)
            exec mkdocs $MKDOCS_CMD --site-dir=$SITE_DIR $@
            ;;
    serve)
            exec mkdocs $MKDOCS_CMD --dev-addr=$LISTEN $@
            ;;
    *)
            echo "Command '$MKDOCS_CMD' is not supported by this container."
            exit 20
            ;;
esac

