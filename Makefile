#
# Makefile for tir release management
#
# Targets:
#   gmake build          - Generate tir.md and tir.1 from the manual
#                          at the end of tir, and show version
#   gmake check          - Verify working tree is clean
#   gmake check-changes  - Verify Changes has entries under {{$NEXT}}
#   gmake release        - Release the version on the Version line of tir:
#                          1. Check clean working tree
#                          2. Validate the version and that its tag is new
#                          3. Check Changes has entries
#                          4. Rewrite {{$NEXT}} in Changes
#                          5. Generate tir.md and man page
#                          6. Commit, tag, and push
#
# Workflow:
#   1. During development, add entries under {{$NEXT}} in Changes
#   2. Raise the Version line in the manual of tir, and commit it
#   3. Run: gmake release
#
# GNU Make 3.82 or later is required for .ONESHELL; on macOS, where
# make is 3.81, use gmake.
#

ifeq ($(filter oneshell,$(.FEATURES)),)
$(error GNU Make 3.82 or later is required for .ONESHELL; run gmake)
endif

NAME    := tir
# the Version line of the manual in tir, and its tag
VERSION := $(shell sed -n 's/^Version  *//p' $(NAME))
TAG     := v$(VERSION)
CURRENT := $(shell git describe --tags --abbrev=0 2>/dev/null)
DATE    := $(shell date +%Y-%m-%d)
MAKE    := $(MAKE) --no-print-directory

.ONESHELL:
.PHONY: build check check-changes release

# the Markdown between ": <<'END_OF_MANUAL'" and END_OF_MANUAL in tir
MANUAL := sed -e '1,/^: <<.END_OF_MANUAL/d' -e '/^END_OF_MANUAL$$/,$$d' $(NAME)

build:
	@$(MANUAL) > $(NAME).md
	pandoc -s -t man \
		-M title=TIR -M section=1 -M header="User Commands" \
		-V footer="$(NAME) $(TAG)" \
		-V date="$(DATE)" \
		--ascii --lua-filter=deflist.lua \
		$(NAME).md -o $(NAME).1
	echo "Version: $(VERSION)"
	grep '^\.TH' $(NAME).1

check:
	@git diff --quiet -- ':!$(NAME).1' ':!Changes' \
	 && git diff --cached --quiet -- ':!$(NAME).1' ':!Changes' \
		|| { echo "ERROR: uncommitted changes"; exit 1; }
	echo "Working tree is clean"

check-changes:
	@awk '/\{\{.NEXT\}\}/{f=1; next} f && /^[[:space:]]+[^[:space:]]/{ok=1; exit} f && /^[^[:space:]]/{exit 1} END{exit(ok ? 0 : 1)}' Changes \
		|| { echo "ERROR: No entries under {{\$$NEXT}} in Changes"; exit 1; }
	echo "Changes OK"

release:
	@set -e
	git diff --quiet -- ':!$(NAME).1' ':!Changes' \
	 && git diff --cached --quiet -- ':!$(NAME).1' ':!Changes' \
		|| { echo "ERROR: uncommitted changes"; exit 1; }
	echo "$(VERSION)" | grep -qE '^[0-9]+(\.[0-9]+)+$$' \
		|| { echo "ERROR: no Version line like 'Version 0.11' in $(NAME)"; exit 1; }
	! git tag -l | grep -qx "$(TAG)" \
		|| { echo "ERROR: tag $(TAG) already exists; raise the Version line of $(NAME)"; exit 1; }
	if grep -q '^$(TAG) ' Changes; then
		echo "Changes already has $(TAG) entry, skipping rewrite"
	else
		awk '/\{\{.NEXT\}\}/{f=1; next} f && /^[[:space:]]+[^[:space:]]/{ok=1; exit} f && /^[^[:space:]]/{exit 1} END{exit(ok ? 0 : 1)}' Changes \
			|| { echo "ERROR: No entries under {{\$$NEXT}} in Changes"; exit 1; }
		sed -i '' 's/{{\$$NEXT}}/{{\$$NEXT}}\'$$'\n''\'$$'\n''$(TAG) $(DATE)/' Changes
	fi
	echo "Releasing $(TAG) (current: $(CURRENT))"
	$(MAKE) build
	git add -u
	msg="Checking in changes prior to tagging of version $(TAG)."$$'\n\n'"Changelog diff is:"$$'\n\n'"$$(git --no-pager diff --cached -- Changes)"
	echo "$$msg"
	echo "---"
	git --no-pager diff --cached --stat
	read -p "Commit and tag $(TAG)? [y/N] " ans
	[ "$$ans" = y ] || { echo "Aborted"; exit 1; }
	git commit -m "$$msg"
	git tag $(TAG)
	git push origin master $(TAG)
	echo "Released $(TAG)"
