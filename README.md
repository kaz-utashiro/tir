# tir - tea is ready

**tir** is a command line kitchen timer for macOS.  When the time is
up, it shows the message on the terminal and in the notification
center, and reads it out with speech.

```sh
tir 3min                # "Tea is ready" in 3 minutes
tir 5min Your noodle    # "Your noodle is ready"
tir -GR                 # gorgeous ramen: 3 minutes, sung by "Good News"
```

The manual is [tir.md](tir.md); `tir -h` shows the options.

## Install

With [Homebrew](https://brew.sh/):

```sh
brew install tecolicom/tap/app-tir
```

tir is a single Bash script that uses `say` and `osascript` of macOS,
so it can also be installed by hand: put it in your `PATH`, and the
man page where `man` finds it:

```sh
cp tir ~/bin/
cp tir.1 /usr/local/share/man/man1/
```

## Development

The manual is written in Markdown at the end of `tir` (between
`: <<'END_OF_MANUAL'` and `END_OF_MANUAL`).  `tir -h` prints it up to
the Version line, and `gmake build` generates `tir.md` and `tir.1`
from it; do not edit those two files directly.

To release, add entries under `{{$NEXT}}` in `Changes`, raise the
`Version` line in the manual of `tir` and commit it, then run:

```sh
gmake release
```

Only `Changes` and `tir.1` may be left uncommitted; the release stops
at once if anything else is, so commit the raised Version line before
it.

The `Makefile` needs GNU Make 3.82 or later; the `make` of macOS is
3.81, so use `gmake` there (`brew install make`).

This tags the version on the `Version` line (`Version 0.11` becomes
`v0.11`), rewrites `Changes`, regenerates `tir.md` and `tir.1`, and
commits, tags and pushes after asking.  See the `Makefile` for the
steps.

## License

MIT License.  See [LICENSE](LICENSE).
