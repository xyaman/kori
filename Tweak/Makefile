TWEAK_NAME = Mochi

$(TWEAK_NAME)_FILES = $(shell find Sources/Mochi -name '*.swift') $(shell find Sources/MochiC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
$(TWEAK_NAME)_SWIFTFLAGS = -ISources/MochiC/include
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -ISources/MochiC/include

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk