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
the Version line, and `make build` generates `tir.md` and `tir.1`
from it; do not edit those two files directly.

To release, add entries under `{{$NEXT}}` in `Changes`, then run:

```sh
make release VERSION=v0.10
```

This sets the Version line of `tir`, regenerates `tir.md` and
`tir.1`, rewrites `Changes`, and commits, tags and pushes after
asking.  See the `Makefile` for the steps.

## License

MIT License.  See [LICENSE](LICENSE).
