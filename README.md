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

    -w time     wait time (default: 0)
    -b sound    choose notification sound (default: Default)
    -r          same as -v random
    -v voice    choose speech voice (default: Fred)
    -l voice    choose voice for last message
    -V volume   set speech volume (0-100)
    -m message  set message to show (default: "%s is ready")
    -c time     set countdown interval (default: adaptive, set 0 to disable)
    -C count    set message repeat count (default: 1)
    -I time     set message repeat interval in seconds (default: 2)
    -i control  Music control (*fade, volume, pause, no)
    -W count    set syllable count
    -e/-E       echo message or not (default: yes)
    -n/-N       send notification or not (default: yes on macOS)
    -s/-S       speak or not (default: yes on macOS)
    -R          ramen shortcut
    -Y          yakisoba shortcut
    -U          udon shortcut
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
be set by **-c** option and set value 0 to disable it.

If Music is playing, its volume is faded into half by default during
a speech.  Select control from *fade*, *volume*, *pause* or *no* by
**-i** option.

Use **-v** option to change the voice.  Option **-r** is just a
shortcut for **-v random** and choose random voice.  Voice used for
the last message can be set by **-l** option.

Option **-V** can be used to set system sound volume temporarily.
Volume is the number between 0 and 100, and it will set just for one
second.

Option **-C** can be used to repeat the final message multiple times,
with **-I** option controlling the interval between repetitions.

Special option **-R**, **-Y** and **-U** are prepared for Ramen,
Yakisoba and Udon.  They set wait time 3min, 4min, 5min respectively.
Use **-GR**, **-GY** and **-GU** for gorgeous version.

Option **-W** can be used to manually override the syllable count when
using **-G** option with *Good News* voice.


# TIPS

Apple removed the voice *Good News*, used by **-G** option, and
others from default voice list on recent operating systems.  You can
download disappeared voices from System Preference interface.  Select
*Accessibility*, then *Speech* and choose *Customize* in *System
Voice* pulldown bar.


# BUGS

When used with **-G** option, the command tries to count syllables within
the target string using a very simple algorithm, which sometimes comes up
with the wrong result. Use **-W** option to manually specify the correct
syllable count in such cases.


# SEE ALSO

osascript(1), say(1)


# AUTHOR

Kazumasa Utashiro

https://github.com/kaz-utashiro/tir/
