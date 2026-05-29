#!/bin/bash
#
# Since Docker run can only have one "entry point" this script enables calling
# either log2timeline or other utility scripts e.g.
# docker run log2timeline/plaso:latest image_export
# docker run log2timeline/plaso:latest log2timeline
# docker run log2timeline/plaso:latest pinfo
# docker run log2timeline/plaso:latest psort
# docker run log2timeline/plaso:latest psteal
#
# or to run it on actual data:
# mkdir -p /data/sources    # put the files to parse here
# mkdir -p /data/results    # a Plaso storage file will appear here
# docker run -ti -v /data:/data:z log2timeline/plaso:latest \
#     log2timeline --storage-file=/data/results/result.plaso /data/sources

case "$1" in
    image_export|image_export.py)
        /usr/local/bin/image_export --unattended "${@:2}" ;;
    log2timeline|log2timeline.py)
        /usr/local/bin/log2timeline --unattended "${@:2}" ;;
    pinfo|pinfo.py)
        /usr/local/bin/pinfo "${@:2}" ;;
    psort|psort.py)
        /usr/local/bin/psort --unattended "${@:2}" ;;
    psteal|psteal.py)
        /usr/local/bin/psteal --unattended "${@:2}" ;;
    "")
        /usr/local/bin/log2timeline --unattended "${@:2}" ;;
    *)
        echo "Unsupported command: $1"
esac
