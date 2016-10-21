#import <objc/runtime.h>
#import <substrate.h>

#define PLIST_PATH_Settings "/var/mobile/Library/Preferences/com.julioverne.safarifullurl.plist"

static BOOL Enabled;
static BOOL RemovePrefix;
static NSString* fullUrl;

%group SafFullURL
%hook TabDocument
- (id)URLString
{
	id ret = %orig;
	if(ret) {
		fullUrl = (NSString *)[ret copy];
		if(RemovePrefix) {
			if([fullUrl hasPrefix:@"https://"]) {
				fullUrl = [fullUrl substringFromIndex:8];
			}
			if([fullUrl hasPrefix:@"http://"]) {
				fullUrl = [fullUrl substringFromIndex:7];
			}
			if([fullUrl hasPrefix:@"ftp://"]) {
				fullUrl = [fullUrl substringFromIndex:6];
			}
		}
	}
	return ret;
}
%end
%hook NavigationBarItemClassGet
- (void)setText:(id)fp8 textWhenExpanded:(id)fp12 startIndex:(unsigned int)fp16
{
	if (Enabled && fp8 && fullUrl) {
		if(([fullUrl rangeOfString:@"/search?"].location == NSNotFound)) {
			fp8 = fullUrl;
			fp12 = fullUrl;
		}
	}
	%orig;
}
%end
%end

static void settingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{	
	@autoreleasepool {		
		NSDictionary *WidPlayerPrefs = [[[NSDictionary alloc] initWithContentsOfFile:@PLIST_PATH_Settings]?:[NSDictionary dictionary] copy];
		Enabled = (BOOL)[[WidPlayerPrefs objectForKey:@"Enabled"]?:@YES boolValue];
		RemovePrefix = (BOOL)[[WidPlayerPrefs objectForKey:@"RemovePrefix"]?:@NO boolValue];
	}
}

%ctor
{
	@autoreleasepool {
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, settingsChanged, CFSTR("com.julioverne.safarifullurl/Settings"), NULL, CFNotificationSuspensionBehaviorCoalesce);
		settingsChanged(NULL, NULL, NULL, NULL, NULL);
		%init(SafFullURL, NavigationBarItemClassGet = objc_getClass("_SFNavigationBarItem")?:objc_getClass("NavigationBarItem"));
	}
}
