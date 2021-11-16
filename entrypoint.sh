#!/bin/sh
# Docker entrypoint script.



# echo $PWD
# exec ls
# # Sets up tables and running migrations.

"app/bin/moodle" eval "Moodle.Release.migrate"
"app/bin/moodle" eval "start"
# # Start our app
# # exec start


