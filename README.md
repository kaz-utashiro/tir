# NAME

tir - tea is ready

# SYNOPSIS

tir [ wait ] [ what ]

tir 60

tir 180 Ramen

tir 5min Your noodle

Options:

	-w time		wait time
	-b sound	choose notification sound
	-v voice	choose speech voice
	-v random	use random voice
	-V volume	set speech volume
	-m message	set message to show
	-e/-E		echo message or not
	-n/-N		send notification or not
	-s/-S		speak or not
	-i/-I		pause iTunes or not


# DESCRIPTION

__tir__ is very simple command just say "Tea is ready".

If the first argument is number, wait that period in second.

Optional argument is taken as subject of readiness.
If "Your ramen" is given, it will tell you that "Your ramen is ready".

By default, it will show the message on the terminal,
send system notification, and read it out.

It uses OS X capabilities and will not run on other systems.


# SEE ALSO

osascript(1), say(1)


# AUTHOR

Kazumasa Utashiro

https://github.com/kaz-utashiro/tir
