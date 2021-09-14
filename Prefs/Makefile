BUNDLE_NAME = KoriPreferences

$(BUNDLE_NAME)_FILES = $(shell find Sources/KoriPreferences -name '*.swift') $(shell find Sources/KoriPreferencesC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
$(BUNDLE_NAME)_INSTALL_PATH = /Library/PreferenceBundles
$(BUNDLE_NAME)_SWIFTFLAGS = -ISources/KoriPreferencesC/include
$(BUNDLE_NAME)_CFLAGS = -fobjc-arc
$(BUNDLE_NAME)_EXTRA_FRAMEWORKS = Cephei

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/bundle.mk
