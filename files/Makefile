CURL      := curl -sLOJ
FONTFORGE := fontforge
RM        := rm -rf

ARTIFACT_DIR             := fonts
ARTIFACT_DIR_FOR_WINDOWS := $(ARTIFACT_DIR)/windows

MIGU_VERSION  := 20150712
MIGU_FONT_DIR := migu-$(MIGU_VERSION)
MIGU_ZIP      := migu-1m-$(MIGU_VERSION).zip
MIGU_ZIP_URI  := http://iij.dl.osdn.jp/mix-mplus-ipa/63545/$(MIGU_ZIP)
MIGU_FONTS    := $(MIGU_FONT_DIR)

INCONSOLATA_BASE_URI := https://github.com/google/fonts/raw/master/ofl/inconsolata
INCONSOLATA_REGULAR  := Inconsolata-Regular.ttf
INCONSOLATA_BOLD     := Inconsolata-Bold.ttf
INCONSOLATA_FONTS    := $(INCONSOLATA_REGULAR) $(INCONSOLATA_BOLD)

RICTY_BASE_URI            := http://www.rs.tus.ac.jp/yyusa/ricty
RICTY_SCRIPT              := ricty_generator.sh
RICTY_DISCORD_OPT_DEFAULT := \"\'*+,-.07:\;\<\>=DZ^\`rz\|~
RICTY_DISCORD_OPT         ?= $(RICTY_DISCORD_OPT_DEFAULT)
RICTY_REGULAR             := Ricty-Regular.ttf
RICTY_BOLD                := Ricty-Bold.ttf
RICTY_DISCORD_REGULAR     := RictyDiscord-Regular.ttf
RICTY_DISCORD_BOLD        := RictyDiscord-Bold.ttf
RICTY_FONTS               := $(RICTY_REGULAR) $(RICTY_BOLD) $(RICTY_DISCORD_REGULAR) $(RICTY_DISCORD_BOLD)

POWERLINE_PATCHER_BASE_URI := https://github.com/powerline/fontpatcher/raw/develop
POWERLINE_PATCHER          := powerline-fontpatcher
POWERLINE_FONT             := powerline-symbols.sfd
POWERLINE_FILES            := $(POWERLINE_PATCHER) $(POWERLINE_FONT)

RICTY_FOR_POWERLINE_REGULAR         := Ricty\ Discord\ Regular\ for\ Powerline.ttf
RICTY_FOR_POWERLINE_REGULAR_RENAMED := RictyDiscord-Regular-for-Powerline.ttf
RICTY_FOR_POWERLINE_BOLD            := Ricty\ Discord\ Bold\ for\ Powerline.ttf
RICTY_FOR_POWERLINE_BOLD_RENAMED    := RictyDiscord-Bold-for-Powerline.ttf
RICTY_FOR_POWERLINE_FONTS           := $(RICTY_FOR_POWERLINE_REGULAR_RENAMED) $(RICTY_FOR_POWERLINE_BOLD_RENAMED)

ALL_RICTY_FONTS := $(RICTY_FONTS) $(RICTY_FOR_POWERLINE_FONTS)

ARTIFACTS             := $(addprefix $(ARTIFACT_DIR)/,$(ALL_RICTY_FONTS))
ARTIFACTS_FOR_WINDOWS := $(addprefix $(ARTIFACT_DIR_FOR_WINDOWS)/,$(ALL_RICTY_FONTS))

all: unix windows

unix: ricty

windows: ricty_windows

ricty: $(ARTIFACTS)

ricty_windows: $(ARTIFACTS_FOR_WINDOWS)

clean:
	$(RM) migu-* Inconsolata-* powerline-* Ricty*.ttf \
		$(ARTIFACT_DIR) $(ARTIFACT_DIR_FOR_WINDOWS) $(RICTY_SCRIPT)

.PHONY: all clean unix windows ricty ricty_windows

$(ARTIFACTS): $(ALL_RICTY_FONTS) | $(ARTIFACT_DIR)
	cp $(@F) $(@D)

$(ARTIFACTS_FOR_WINDOWS): SHELL := /bin/bash
$(ARTIFACTS_FOR_WINDOWS): $(ALL_RICTY_FONTS) | $(ARTIFACT_DIR_FOR_WINDOWS)
	@font=$(notdir $@); \
	xml=$${font/%.ttf/.win.ttx}; \
	ttx -t OS/2 -q -o - $$font | sed -e 's/\(xAvgCharWidth value=\)"940"/\1"500"/g' > $$xml; \
	ttx -m $$font $$xml; \
	rm $$xml; \
	mv $${xml/%.ttx/.ttf} $(ARTIFACT_DIR_FOR_WINDOWS)/$$font

$(ARTIFACT_DIR) $(ARTIFACT_DIR_FOR_WINDOWS):
	mkdir -p $@

$(INCONSOLATA_REGULAR) $(INCONSOLATA_BOLD):
	$(CURL) $(INCONSOLATA_BASE_URI)/$@

$(MIGU_ZIP):
	$(CURL) $(MIGU_ZIP_URI)

$(MIGU_FONT_DIR): $(MIGU_ZIP)
	unzip -d $@ -j $^ \*/\*.ttf

$(RICTY_SCRIPT):
	$(CURL) $(RICTY_BASE_URI)/$@
	chmod a+x $@

$(POWERLINE_PATCHER):
	$(CURL) $(POWERLINE_PATCHER_BASE_URI)/scripts/$@
	chmod a+x $@

$(POWERLINE_FONT):
	$(CURL) $(POWERLINE_PATCHER_BASE_URI)/fonts/$@

$(RICTY_REGULAR): $(MIGU_FONTS) $(INCONSOLATA_FONTS) $(RICTY_SCRIPT) $(POWERLINE_FILES)
	./$(RICTY_SCRIPT) $(if $(RICTY_DISCORD_OPT),-d $(RICTY_DISCORD_OPT),) -f $(FONTFORGE) auto

$(RICTY_BOLD) $(RICTY_DISCORD_REGULAR) $(RICTY_DISCORD_BOLD): $(RICTY_REGULAR)

$(RICTY_FOR_POWERLINE_REGULAR_RENAMED): $(RICTY_FONTS) $(POWERLINE_FONT)
	./$(POWERLINE_PATCHER) --source-font $(POWERLINE_FONT) $(RICTY_DISCORD_REGULAR)
	mv $(RICTY_FOR_POWERLINE_REGULAR) $@

$(RICTY_FOR_POWERLINE_BOLD_RENAMED): $(RICTY_FONTS) $(POWERLINE_FONT)
	./$(POWERLINE_PATCHER) --source-font $(POWERLINE_FONT) $(RICTY_DISCORD_BOLD)
	mv $(RICTY_FOR_POWERLINE_BOLD) $@
