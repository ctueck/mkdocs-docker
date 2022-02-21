# Dockerized MkDocs configuration

This is a simple setup with a container running MkDocs to build a site, which is then served by an Nginx container.

## Quick Start

Customise behaviour with a `.env` file. The MkDocs source may reside in:

 - the `source` sub-directory of the repository (default),
 - another local directory, specified by `LOCAL_SOURCE`, or
 - a Git repository, specified by `GITHUB_SOURCE`

In default configuration, the directory specified by `LOCAL_SOURCE` (or, if not specified, the `source` sub-directory of the repository) is bind-mounted into the container. If it contains an MkDocs config file, this directory will be used.

If the local directories do not contain an MkDocs config file, the container will attempt to clone `GITHUB_SOURCE`.

Set `HOSTNAME` to control the host name to be used in `nginx.conf` - default is `localhost`.

Set `PORT` to set on which host port the Nginx container should be published (default: `8080`).

For development/editing purposes, the `builder` container can also be run stand-alone with the `serve` command. Additional parameters are passed through to MkDocs.

## Future Ideas

 - include a simple HTTP server that will listen for GitHub web hooks, automatically pull and then rebuild the site

