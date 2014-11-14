zypper-wrapper
--------------

This script is a very simple zypper wrapper (but I'm not a Rapper).
If you run:

  # ./zypper-wrapper.sh in $2

and it returns output with "No provider of '$2' found." this script will
automagically run:

  # zypper se $2

NOTES
-----

The script will (hopefully) fail gracefully if you specify more than
one pacakge/file name. (Sorry, don't have time to implement that yet.)

If you like the script and want to 'replace' zypper with it (and you
run bash), just edit your .bashrc (or similar) file to include the
following line:

alias zypper='/path/to/zypper/wrapper.sh'

Also, I don't have OpenSUSE installed (prefer Debian/Arch) so I'm not
even sure if this works. If you use this and it doesn't work, please
file some bug reports on Github, thanks!

LICENSE
-------

MIT (see LICENSE for details)
