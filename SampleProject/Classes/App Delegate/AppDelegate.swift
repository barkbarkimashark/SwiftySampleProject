//
//  AppDelegate.swift
//  <#Project Name#>
//
//  Created by <#Project Developer#> on 29/02/2016.
//  Copyright © 2016 <#Project Name#>. All rights reserved.
//
//
import UIKit
import Sentry

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
        // Override point for customization after application launch.

        let obj : MOProfile? = MOProfile.init()
        UserManager.setCurrentUser( obj)
        
        if UserManager.isLoggedIn(){
            print ("YES")
        }else {
            print ("NO")
        }
    
        UserManager.setToken(token: "sdasjkhdaskjhd")
        
        if UserManager.isLoggedIn(){
            print ("YES")
        }else {
            print ("NO")
        }
        
        UserManager.logOutCurrentUser()
        
        if UserManager.isLoggedIn(){
            print ("YES")
        }else {
            print ("NO")
        }
        
        UserManager.logOutUserAndClearToken()
        
        if UserManager.isLoggedIn(){
            print ("YES")
        }else {
            print ("NO")
        }
        
        SentrySDK.start { options in
            options.dsn = "https://d973fe200c5945e6b274a350d8622531@o1169741.ingest.sentry.io/6418874"
            options.debug = true // Enabled debug when first installing is always helpful
            options.tracesSampleRate = 1.0
        }
        
        SentrySDK.capture(message: "AppDelegate.application()")
        
        do {
            try ObjC.catchException{UtilityFunctions.createError("caught")}
        } catch let err as NSError {
            SentrySDK.capture(error: err)
        }
//        SentrySDK.crash()
//        let error = NSError(domain: "YourErrorDomain", code: 0, userInfo: nil)
//        SentrySDK.capture(error: error)
        
        
        
//        SentrySDK.capture(error: try {ObjC.catchException(UtilityFunctions.createError())})
        
//        try ObjC.catchException{
//            SentrySDK.capture(error: UtilityFunctions.createError())
//        }
        
//        do {
//            try ObjC.catchException{
//                UtilityFunctions.createError()
//            }
//        } catch {
//            SentrySDK.capture(message: "stuff")
////            SentrySDK.capture(error: <#T##Error#>)
//        }
        
        return true
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        UtilityFunctions.createError("applicationWillResignActive")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }
}
