//
//  AppDelegate.swift
//  isDogHereApp
//
//  Created by Sina Yeganeh on 27/11/2015.
//  Copyright © 2015 Sina Yeganeh. All rights reserved.
//

import UIKit
import Tune
import AdSupport

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // MARK - Push Notifications
        let settings = UIUserNotificationSettings(forTypes: .Alert, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        // MARK: Tune Init Code
        Tune.initializeWithTuneAdvertiserId("190479", tuneConversionKey: "0f85edd57ece8c5e51d14e5f630ee607")
        Tune.automateIapEventMeasurement(true)
        
        return true
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("Device token: \(deviceToken)")
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Failed to register remote notification: \(error)")
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        // pass the url to the handle deep link call
        // if handleDeepLink returns true, and you registered a callback in initSessionAndRegisterDeepLinkHandler, the callback will be called with the data associated with the deep link
        
        Tune.applicationDidOpenURL(url.absoluteString, sourceApplication: sourceApplication)
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        Tune.measureSession()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

