include theos/makefiles/common.mk

TWEAK_NAME = SafariFullUrl

SafariFullUrl_FILES = Tweak.xm
SafariFullUrl_FRAMEWORKS = CydiaSubstrate UIKit
SafariFullUrl_CFLAGS = -fobjc-arc
SafariFullUrl_LDFLAGS = -Wl,-segalign,4000

export ARCHS = armv7 arm64
SafariFullUrl_ARCHS = armv7 arm64

include $(THEOS_MAKE_PATH)/tweak.mk
	
all::
	@echo "[+] Copying Files..."
	@cp -rf ./obj/obj/debug/SafariFullUrl.dylib //Library/MobileSubstrate/DynamicLibraries/SafariFullUrl.dylib
	@cp -rf ./SafariFullUrl.plist //Library/MobileSubstrate/DynamicLibraries/SafariFullUrl.plist
	@/usr/bin/ldid -S //Library/MobileSubstrate/DynamicLibraries/SafariFullUrl.dylib
	@echo "DONE"
	
