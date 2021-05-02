#!/bin/sh
#
# execute wpcli within the container with given arguments
#

usage() {
>&2 cat <<EOF
Usage: ${0##*/} --path=/path/to/docker-compose.yml [arguments]

If no --path= is given, \$PWD is assumed.
EOF
exit 1
}

case $1 in
    -h|--help)
        usage
        ;;
    --path=*)
        if cd "${1#--path=}" ; then
            shift
        else
            >&2 printf 'Could not cd to %s\n\n' "${1#--path=}"
            usage
        fi
esac

if [ -f docker-compose.yml ] ; then
    exec env -i docker-compose run --rm wpcli "$@"
else
    usage
fi
