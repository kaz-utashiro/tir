#
# Makefile for tir release management
#
# Targets:
#   make build           - Generate tir.1 from README.md and show version
#   make check           - Verify working tree is clean
#   make check-changes   - Verify Changes has entries under {{$NEXT}}
#   make release VERSION=v0.9
#                        - Release a new version:
#                          1. Check clean working tree
#                          2. Validate VERSION format and uniqueness
#                          3. Check Changes has entries
#                          4. Generate man page with version
#                          5. Rewrite {{$NEXT}} in Changes
#                          6. Commit, tag, and push
#
# Workflow:
#   1. During development, add entries under {{$NEXT}} in Changes
#   2. Run: make release VERSION=v0.9
#

NAME    := tir
CURRENT := $(shell git describe --tags --abbrev=0 2>/dev/null)
YEAR    := $(shell date +%Y)
DATE    := $(shell date +%Y-%m-%d)

.ONESHELL:
.PHONY: build check check-changes release

VER  := $(CURRENT)

build:
	pandoc -s -t man \
		-M title=TIR -M section=1 -M header="User Commands" \
		-V footer="$(NAME) $(VER)" \
		-V date="$(YEAR)" \
		--lua-filter=deflist.lua \
		README.md -o $(NAME).1
	@echo "Version: $(VER)"
	@grep '^\.TH' $(NAME).1

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
ifndef VERSION
	$(error VERSION required: make release VERSION=v0.9)
endif
	set -e
	$(MAKE) check
	echo "$(VERSION)" | grep -qE '^v[0-9]' \
		|| { echo "ERROR: VERSION must start with v"; exit 1; }
	! git tag -l | grep -qx "$(VERSION)" \
		|| { echo "ERROR: tag $(VERSION) already exists"; exit 1; }
	$(MAKE) check-changes
	echo "Releasing $(VERSION) (current: $(CURRENT))"
	$(MAKE) build VER=$(VERSION)
	# Rewrite {{$$NEXT}} in Changes
	sed -i '' 's/{{\$$NEXT}}/{{\$$NEXT}}\'$$'\n''\'$$'\n''$(VERSION) $(DATE)/' Changes
	git add -u
	git diff --cached --stat
	read -p "Commit and tag $(VERSION)? [y/N] " ans
	[ "$$ans" = y ] || { echo "Aborted"; exit 1; }
	git commit -m "Release $(VERSION)"
	git tag $(VERSION)
	git push origin master $(VERSION)
	echo "Released $(VERSION)"
