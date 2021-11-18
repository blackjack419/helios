# This file is included with the rest of the buildroot makefile logic
# It should be used to include and source additional package makes located in the package/ directory

# Use our custom version instead of buildroot's
HELIOS_VERSION="v0.0.1"

# [openrc] Override Buildroot's sysname for our own
OPENRC_MAKE_OPTS_ADJ := $(filter-out "BRANDING%",$(OPENRC_MAKE_OPTS))
OPENRC_MAKE_OPTS = $(OPENRC_MAKE_OPTS_ADJ) \
		BRANDING="HeliOS Alpha $(HELIOS_VERSION)"
