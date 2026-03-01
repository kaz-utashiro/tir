# NAME

tir - kitchen timer with notification, speech, and countdown

# SYNOPSIS

**tir** [*options*] [*wait*] [*what*]

# DESCRIPTION

**tir** is a command line kitchen timer for Apple macOS 10.9 (Mavericks)
and later.  It will show the message on terminal, notification center,
and read it out using audible speech.  The default message is "Tea is
ready" and the "tea" is replaced by the command argument.  If the first
argument is a number, the command waits that time in seconds.

Time can be specified with suffixes: **60** (seconds), **3min**
(minutes), **1h** (hours), or **5:30** (minutes:seconds).

Countdown messages are announced every 10 minutes (>10min), every
minute (>1min), then at 30, 20, 10, and 5 seconds.  Use the **-c**
option to set a fixed interval, or 0 to disable.

If Music is playing, its volume is faded to half by default during a
speech.  Select control from *fade*, *volume*, *pause* or *no* by the
**-i** option.

# OPTIONS

- **-w** *time*

  Wait time (default: 0).

- **-m** *message*

  Set message format (default: "%s is ready").

- **-c** *time*

  Set countdown interval (default: adaptive, set 0 to disable).

- **-C** *count*

  Set message repeat count (default: 1).

- **-I** *time*

  Set message repeat interval in seconds (default: 2).

- **-v** *voice*

  Choose speech voice (default: Fred).
  Use **-v ?** to list available voices.

- **-r**

  Same as **-v random**.

- **-l** *voice*

  Choose voice for last message.

- **-b** *sound*

  Choose notification sound (default: Default).
  Use **-b ?** to list available sounds.

- **-V** *volume*

  Set system sound volume temporarily (0-100).
  Volume is restored after one second.

- **-i** *control*

  Music control during speech: *fade* (default), *volume*, *pause* or *no*.

- **-W** *count*

  Set syllable count manually for **-G** option.

- **-e**/**-E**

  Echo message or not (default: yes).

- **-n**/**-N**

  Send notification or not (default: yes on macOS).

- **-s**/**-S**

  Speak or not (default: yes on macOS).

- **-R**

  Ramen shortcut (3 minutes).

- **-Y**

  Yakisoba shortcut (4 minutes).

- **-U**

  Udon shortcut (5 minutes).

- **-GR**, **-GY**, **-GU**

  Gorgeous versions of **-R**, **-Y** and **-U**.
  These use the "Good News" voice to sing the completion message to a
  melody.  The message format is automatically adjusted based on the
  syllable count of the target word to match the melody timing.

- **-h**

  Show help message.

# EXAMPLES

- **tir 60**

  Wait 60 seconds and say "Tea is ready".

- **tir 180 Ramen**

  Wait 180 seconds and say "Ramen is ready".

- **tir 5min Your noodle**

  Wait 5 minutes and say "Your noodle is ready".

- **tir -c 10 10min**

  Wait 10 minutes with countdown every 10 seconds.

- **tir -GR**

  Gorgeous ramen timer (3 minutes with Good News voice).

# TIPS

Apple removed the voice "Good News", used by the **-G** option, from
the default voice list on recent operating systems.  You can download
it from System Preferences: select Accessibility, then Speech, and
choose Customize in the System Voice pulldown.

# BUGS

When used with the **-G** option, the command counts syllables using a
very simple algorithm, which sometimes produces incorrect results.  Use
the **-W** option to manually specify the correct syllable count.

# SEE ALSO

osascript(1), say(1)

- [Tea is ready - Command line kitchen timer for OS X Mavericks](https://utashiro.hatenablog.com/entry/2014/03/02/164732) (Japanese)
- [Mavericks command line kitchen timer "Gorgeous Ramen" option](https://qiita.com/kaz-utashiro/items/72f9e4c089c46210dec4) (Japanese)
- [macOS voice "Good News" revival and kitchen timer tir version update](https://qiita.com/kaz-utashiro/items/9027eba0c1347d441bd9) (Japanese)

# LICENSE

MIT License

# AUTHOR

Kazumasa Utashiro
<https://github.com/kaz-utashiro/tir/>
