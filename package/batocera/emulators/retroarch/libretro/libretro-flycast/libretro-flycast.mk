################################################################################
#
# LIBRETRO-FLYCAST
#
################################################################################
# Version.: Commits on Mar 22, 2021
LIBRETRO_FLYCAST_VERSION = ddb617aed135c4a084cf884770c7c80a7c883e34
LIBRETRO_FLYCAST_SITE = $(call github,libretro,flycast,$(LIBRETRO_FLYCAST_VERSION))
LIBRETRO_FLYCAST_LICENSE = GPLv2
LIBRETRO_FLYCAST_DEPENDENCIES = retroarch

LIBRETRO_FLYCAST_PLATFORM = $(LIBRETRO_PLATFORM)
LIBRETRO_FLYCAST_EXTRA_ARGS = HAVE_OPENMP=1

# LIBRETRO_PLATFORM is not good for this core, because
# for rpi, it contains "unix rpi" and this core do an "if unix elif rpi ..."

# special cases for special plateform then...
# an other proper way may be to redo the Makefile to do "if rpi elif unix ..." (from specific to general)
# the Makefile imposes that the platform has gles (or force FORCE_GLES is set) to not link with lGL

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI4),y)
	LIBRETRO_FLYCAST_PLATFORM = rpi-rpi4_64
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm64
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI3),y)
	LIBRETRO_FLYCAST_PLATFORM = rpi-rpi3
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm FORCE_GLES=1 LDFLAGS=-lrt
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_XU4),y)
	LIBRETRO_FLYCAST_PLATFORM = odroid
	LIBRETRO_FLYCAST_EXTRA_ARGS += BOARD=ODROID-XU4 FORCE_GLES=1 ARCH=arm
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_LIBRETECH_H5),y)
	LIBRETRO_FLYCAST_PLATFORM = h5
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm64 FORCE_GLES=1 LDFLAGS=-lrt
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDC2),y)
	LIBRETRO_FLYCAST_PLATFORM = odroidc2
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm64 FORCE_GLES=1 LDFLAGS=-lrt
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ORANGEPI_ZERO2),y)
	LIBRETRO_FLYCAST_PLATFORM = h616
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm64 FORCE_GLES=1 LDFLAGS=-lrt
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S905),y)
	LIBRETRO_FLYCAST_PLATFORM = AMLGX
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm64 FORCE_GLES=1 LDFLAGS=-lrt
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S912),y)
	LIBRETRO_FLYCAST_PLATFORM = AMLGXM
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm64 FORCE_GLES=1 LDFLAGS=-lrt
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDC4)$(BR2_PACKAGE_BATOCERA_TARGET_S905GEN3),y)
	LIBRETRO_FLYCAST_PLATFORM = odroidc4
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm64 FORCE_GLES=1 LDFLAGS=-lrt
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RK3399),y)
	LIBRETRO_FLYCAST_PLATFORM = rpi-rpi4_64
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm64 FORCE_GLES=1 LDFLAGS=-lrt
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDN2)$(BR2_PACKAGE_BATOCERA_TARGET_VIM3),y)
	LIBRETRO_FLYCAST_PLATFORM = odroid-n2
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm64 FORCE_GLES=1 LDFLAGS=-lrt
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDGOA),y)
ifeq ($(BR2_arm),y)
	LIBRETRO_FLYCAST_PLATFORM = classic_armv8_a35
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm FORCE_GLES=1 LDFLAGS=-lrt
else
	LIBRETRO_FLYCAST_PLATFORM = arm64
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm64 FORCE_GLES=1 LDFLAGS=-lrt
endif
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ORANGEPI_PC),y)
	LIBRETRO_FLYCAST_PLATFORM = sun8i
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm FORCE_GLES=1 LDFLAGS=-lrt
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S812),y)
	LIBRETRO_FLYCAST_PLATFORM = odroid
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm FORCE_GLES=1 LDFLAGS=-lrt
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_TINKERBOARD),y)
	LIBRETRO_FLYCAST_PLATFORM = tinkerboard
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_MIQI),y)
	LIBRETRO_FLYCAST_PLATFORM = tinkerboard
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=arm
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_X86),y)
	LIBRETRO_FLYCAST_EXTRA_ARGS += ARCH=x86
endif

define LIBRETRO_FLYCAST_BUILD_CMDS
    $(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile \
		platform="$(LIBRETRO_FLYCAST_PLATFORM)" $(LIBRETRO_FLYCAST_EXTRA_ARGS)
endef

define LIBRETRO_FLYCAST_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/flycast_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/flycast_libretro.so
endef

$(eval $(generic-package))
