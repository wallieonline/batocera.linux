################################################################################
#
# WATARA
#
################################################################################
# Version.: Commits on Aug 05, 2021
LIBRETRO_WATARA_VERSION = 1327cd6f10ed50b998ecc41a927240929e71a4b7
LIBRETRO_WATARA_SITE = $(call github,libretro,potator,$(LIBRETRO_WATARA_VERSION))
LIBRETRO_WATARA_LICENSE = GPLv2

LIBRETRO_WATARA_PLATFORM = $(LIBRETRO_PLATFORM)
LIBRETRO_WATARA_EXTRA_ARGS =

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI1),y)
LIBRETRO_WATARA_PLATFORM = rpi1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI2),y)
LIBRETRO_WATARA_PLATFORM = rpi2

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI3),y)
    ifeq ($(BR2_aarch64),y)
        LIBRETRO_WATARA_PLATFORM = rpi3_64
    else
        LIBRETRO_WATARA_PLATFORM = rpi3
    endif

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI4),y)
LIBRETRO_WATARA_PLATFORM = rpi4

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S812),y)
LIBRETRO_WATARA_PLATFORM = armv cortexa9 neon hardfloat

else ifeq ($(BR2_aarch64),y)
LIBRETRO_WATARA_PLATFORM = aarch64
LIBRETRO_WATARA_EXTRA_ARGS += ARCH=arm64

else ifeq ($(BR2_x86_64),y)
LIBRETRO_WATARA_EXTRA_ARGS += ARCH=x86_64
endif

define LIBRETRO_WATARA_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/platform/libretro -f Makefile platform="$(LIBRETRO_WATARA_PLATFORM)" $(LIBRETRO_WATARA_EXTRA_ARGS)
endef

define LIBRETRO_WATARA_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/platform/libretro/potator_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/potator_libretro.so
endef

$(eval $(generic-package))
