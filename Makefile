export ARCHS = arm64 arm64e
export SYSROOT = $(THEOS)/sdks/iPhoneOS14.4.sdk
#export PREFIX= $(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/
export TARGET = iphone:clang::14.0

INSTALL_TARGET_PROCESSES = SpringBoard

TWEAK_NAME = Kori
$(TWEAK_NAME)_FILES = $(shell find Sources/Tweak -name '*.swift') $(shell find Sources/TweakC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
$(TWEAK_NAME)_SWIFTFLAGS = -ISources/TweakC/include
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -ISources/TweakC/include
$(TWEAK_NAME)_FRAMEWORKS = CoverSheet
$(TWEAK_NAME)_EXTRA_FRAMEWORKS = Cephei


BUNDLE_NAME = KoriPreferences
$(BUNDLE_NAME)_FILES = $(shell find Sources/Preferences -name '*.swift')
$(BUNDLE_NAME)_INSTALL_PATH = /Library/PreferenceBundles
$(BUNDLE_NAME)_CFLAGS = -fobjc-arc
$(BUNDLE_NAME)_EXTRA_FRAMEWORKS = Cephei

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/bundle.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p "$(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences"$(ECHO_END)
	$(ECHO_NOTHING)cp Resources/entry.plist "$(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/$(BUNDLE_NAME).plist"$(ECHO_END)

