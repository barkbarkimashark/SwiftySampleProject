#import "SentryCrashWrapper.h"
#import "SentryCrash.h"
#import "SentryCrashMonitor_AppState.h"
#import "SentryHook.h"
#import <Foundation/Foundation.h>
#import <SentryCrashCachedData.h>
#import <SentryCrashDebug.h>

NS_ASSUME_NONNULL_BEGIN

@implementation SentryCrashWrapper

+ (instancetype)sharedInstance
{
    static SentryCrashWrapper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ instance = [[self alloc] init]; });
    return instance;
}

- (BOOL)crashedLastLaunch
{
    return SentryCrash.sharedInstance.crashedLastLaunch;
}

- (NSTimeInterval)activeDurationSinceLastCrash
{
    return SentryCrash.sharedInstance.activeDurationSinceLastCrash;
}

- (BOOL)isBeingTraced
{
    return sentrycrashdebug_isBeingTraced();
}

- (BOOL)isApplicationInForeground
{
    return sentrycrashstate_currentState()->applicationIsInForeground;
}

- (void)installAsyncHooks
{
    sentrycrash_install_async_hooks();
}

- (void)close
{
    SentryCrash *handler = [SentryCrash sharedInstance];
    @synchronized(handler) {
        [handler setMonitoring:SentryCrashMonitorTypeNone];
        handler.onCrash = NULL;
    }

    sentrycrash_deactivate_async_hooks();
    sentrycrashccd_close();
}

@end

NS_ASSUME_NONNULL_END
