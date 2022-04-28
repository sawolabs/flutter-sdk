#import "SawoSdkPlugin.h"
#if __has_include(<sawo_sdk/sawo_sdk-Swift.h>)
#import <sawo_sdk/sawo_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "sawo_sdk-Swift.h"
#endif

@implementation SawoSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSawoSdkPlugin registerWithRegistrar:registrar];
}
@end
