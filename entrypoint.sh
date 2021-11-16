#!/bin/sh
# Docker entrypoint script.



# echo $PWD
# exec ls
# # Sets up tables and running migrations.

eval "Moodle.Release.migrate"
exec "start"
# # Start our app
# # exec start


