#import "SentryDefines.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** A wrapper around SentryCrash for testability.
 */
@interface SentryCrashWrapper : NSObject
SENTRY_NO_INIT

+ (instancetype)sharedInstance;

- (BOOL)crashedLastLaunch;

- (NSTimeInterval)activeDurationSinceLastCrash;

- (BOOL)isBeingTraced;

- (BOOL)isApplicationInForeground;

- (void)installAsyncHooks;

/**
 * It's not really possible to close SentryCrash. Best we can do is to deactivate all the monitors,
 * clear the `onCrash` callback installed on the global handler, and a few more minor things.
 */
- (void)close;

@end

NS_ASSUME_NONNULL_END
