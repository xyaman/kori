TWEAK_NAME = Kori

$(TWEAK_NAME)_FILES = $(shell find Sources/Kori -name '*.swift') $(shell find Sources/KoriC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
$(TWEAK_NAME)_SWIFTFLAGS = -ISources/KoriC/include
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -ISources/MochiC/include
$(TWEAK_NAME)_FRAMEWORKS = CoverSheet
$(TWEAK_NAME)_EXTRA_FRAMEWORKS = Cephei

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
