################################################################################
#
# PRBOOM
#
################################################################################
# Version.: Commits on Aug 16, 2021
LIBRETRO_PRBOOM_VERSION = 9814a1fbc45936a93046307ec41a95cb0e4b9efa
LIBRETRO_PRBOOM_SITE = $(call github,libretro,libretro-prboom,$(LIBRETRO_PRBOOM_VERSION))
LIBRETRO_PRBOOM_LICENSE = GPLv2

LIBRETRO_PRBOOM_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S812),y)
LIBRETRO_PRBOOM_PLATFORM = armv neon

else ifeq ($(BR2_aarch64),y)
LIBRETRO_PRBOOM_PLATFORM = unix

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI3),y)
LIBRETRO_PRBOOM_PLATFORM = armv neon
endif

define LIBRETRO_PRBOOM_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_PRBOOM_PLATFORM)"
endef

define LIBRETRO_PRBOOM_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/prboom_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/prboom_libretro.so
endef

$(eval $(generic-package))
