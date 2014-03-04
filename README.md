# NAME

tir - tea is ready

# SYNOPSIS

tir [ wait ] [ what ]

# SAMPLES

	% tir 60

		wait 60 second and say "Tea is ready"

	% tir 180 Ramen

		wait 180 seconds and say "Ramen is ready"

	% tir 5min Your noodle

		wait 300 seconds and say "Your noodle is ready"

# OPTIONS

	-w time		wait time
	-b sound	choose notification sound
	-r		same as -v random
	-v voice	choose speech voice
	-V volume	set speech volume
	-m message	set message to show
	-e/-E		echo message or not
	-n/-N		send notification or not
	-s/-S		speak or not
	-i/-I		pause iTunes or not


# DESCRIPTION

This is the command line kitchen timer for Apple OS X Mavericks.  It
will show the message on terminal, notification center, and read it
out using audible speech.  Default message is "Tea is ready" and the
"tea" is replaced by the command argument.  If the first argument is
number, command waits that time in second.  Playing iTunes is paused
automatically during speech.

Use __-v__ option to change voice.  Option __-r__ is shortcut for __-v
random__ and choose random voice.

Option __-V__ can be used to set system sound volume temporarily.
Volume is the number between 0 and 100, and it will set just for one
second.


# OTHER SAMPLES

	tir -w 3m -v good -m 'tea is ready tea is tea is ready ee tea is ready tea is tea is ready now'

	tir -w 3m -v good -m 'ramen is ready ee ramen is ready, your ramen is ready ramen is ready'


# SEE ALSO

osascript(1), say(1)


# AUTHOR

Kazumasa Utashiro

https://github.com/kaz-utashiro/tir/
