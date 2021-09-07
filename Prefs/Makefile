BUNDLE_NAME = MochiPreferences

$(BUNDLE_NAME)_FILES = $(shell find Sources/MochiPreferences -name '*.swift') $(shell find Sources/MochiPreferencesC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
$(BUNDLE_NAME)_INSTALL_PATH = /Library/PreferenceBundles
$(BUNDLE_NAME)_SWIFTFLAGS = -ISources/MochiPreferencesC/include
$(BUNDLE_NAME)_CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/bundle.mk
