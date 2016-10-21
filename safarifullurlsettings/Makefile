include theos/makefiles/common.mk

BUNDLE_NAME = SafariFullUrlSettings
SafariFullUrlSettings_FILES = SafariFullUrlController.mm
SafariFullUrlSettings_INSTALL_PATH = /Library/PreferenceBundles
SafariFullUrlSettings_FRAMEWORKS = UIKit QuartzCore CoreGraphics MessageUI Social Twitter
SafariFullUrlSettings_PRIVATE_FRAMEWORKS = Preferences
SafariFullUrlSettings_CFLAGS = -fobjc-arc
SafariFullUrlSettings_LDFLAGS = -Wl,-segalign,4000
SafariFullUrlSettings_ARCHS = armv7 arm64
export ARCHS = armv7 arm64

include $(THEOS_MAKE_PATH)/bundle.mk

all::
	@echo "[+] Copying Files..."
	@cp ./obj/SafariFullUrlSettings.bundle/SafariFullUrlSettings //Library/PreferenceBundles/SafariFullUrlSettings.bundle/SafariFullUrlSettings
	@/usr/bin/ldid -S //Library/PreferenceBundles/SafariFullUrlSettings.bundle/SafariFullUrlSettings
	@echo "DONE"
	
	