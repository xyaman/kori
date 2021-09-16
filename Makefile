export ARCHS = arm64 arm64e
export SYSROOT = $(THEOS)/sdks/iPhoneOS14.4.sdk
#export PREFIX= $(THEOS)/toolchain/Xcode.xctoolchain/usr/bin/
export TARGET = iphone:clang::14.0

INSTALL_TARGET_PROCESSES = SpringBoard

SUBPROJECTS += Tweak
SUBPROJECTS += Prefs

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
