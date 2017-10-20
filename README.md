# NAME

    tir - tea is ready


# SYNOPSIS

    tir [ wait ] [ what ]


# SAMPLES

    % tir 60

        wait 60 seconds and say "Tea is ready"

    % tir 180 Ramen

        wait 180 seconds and say "Ramen is ready"

    % tir 5min Your noodle

        wait 300 seconds and say "Your noodle is ready"

    % tir -c 10 10min

        wait 10 minutes with countdown every 10 seconds

    % tir -GR

        try and listen


# OPTIONS

    -w time     wait time
    -b sound    choose notification sound
    -r          same as -v random
    -v voice    choose speech voice
    -l voice    choose voice for last message
    -V volume   set speech volume
    -m message  set message to show
    -c time     set countdown interval (set 0 to disable)
    -i control  iTunes control (*fade, volume, pause, no)
    -e/-E       echo message or not
    -n/-N       send notification or not
    -s/-S       speak or not
    -GR         gorgeous ramen
    -GY         gorgeous yakisoba
    -GU         gorgeous udon


# DESCRIPTION

This is a command line kitchen timer for Apple macOS 10.9 (Mavericks)
and later.  It will show the message on terminal, notification center,
and read it out using audible speech.  The default message is "Tea is
ready" and the "tea" is replaced by the command argument.  If the
first argument is number, command waits that time in second.

It produces countdown message every 10 minutes (> 60min), 60 seconds
(> 60sec), 30 seconds (> 30sec) or 10 seconds.  Countdown interval can
be set by __-c__ option and set value 0 to disable it.

If iTunes is playing, its volume is faded into half by default during
a speech.  Select control from *fade*, *volume*, *pause* or *no* by
__-i__ option.

Use __-v__ option to change the voice.  Option __-r__ is just a
shortcut for __-v random__ and choose random voice.  Voice used for
the last message can be set by __-l__ option.

Option __-V__ can be used to set system sound volume temporarily.
Volume is the number between 0 and 100, and it will set just for one
second.

Special option __-R__, __-Y__ and __-U__ are prepared for Ramen,
Yakisoba and Udon.  They set wait time 3min, 4min, 5min respectively.
Use __-GR__, __GY__ and __-GU__ for gorgeous version.


# TIPS

Apple removed the voice *Good News*, used by __-G__ option, and
others from default voice list on recent operating systems.  You can
download disappeared voices from System Preference interface.  Select
*Accessibility*, then *Speech* and choose *Customize* in *System
Voice* pulldown bar.


# BUGS

When used with __-G__ option, command try to count syllables within
the target string using very simple algorithm, which sometimes comes up
to wrong result.


# SEE ALSO

osascript(1), say(1)


# AUTHOR

Kazumasa Utashiro

https://github.com/kaz-utashiro/tir/
