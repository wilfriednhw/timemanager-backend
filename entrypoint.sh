#!/bin/sh
# Docker entrypoint script.



bin="/app/bin/moodle"
eval "$bin" "Moodle.Release.migrate"
exec "$bin" "start"



