//
//  AppDelegate.swift
//  KiiPushTest
//
//  Created by 木村大輝 on 2017/02/21.
//  Copyright © 2017年 木村大輝. All rights reserved.
//

import UIKit
import KiiSDK
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var test: String?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        test = "aiueo"
        
        Kii.begin(withID: "73da6ddb", andKey: "685e5dfcde4526a24c7dd13716f0a340", andSite: KiiSite.JP)
        // Register the device to APNs.
        if #available(iOS 10, *) {
            // For iOS 10
            UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .sound, .badge]) { (granted: Bool, error: Error?) in
                if (error != nil) {
                    print("Failed to request authorization")
                    return
                }
                if granted {
                    application.registerForRemoteNotifications()
                } else {
                    print("The user refused the push notification")
                }
            }
        } else {
            // For iOS 8/iOS 9
            let notificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(notificationSettings)
            application.registerForRemoteNotifications()
        }
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let username = "user1"
        let password = "123ABC"
        KiiUser.authenticate(username, withPassword: password) { (user: KiiUser?, error: Error?) -> Void in
            if (error != nil) {
                print("Failed to authenticate: \((error! as NSError).userInfo["description"])")
                return
            }
            KiiPushInstallation.install(withDeviceToken: deviceToken, andDevelopmentMode: true) { (installation: KiiPushInstallation?, error: Error?) -> Void in
                if (error != nil) {
                    print("Failed to install the device token: \((error! as NSError).userInfo["description"])")
                    return
                }
                print("Push installed!")
            }
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register to APNs: \(error)")
    }
    
//    func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
//        print("Notify")
//    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("Notify")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
//        var addressBookController = AddressBookController()
//        addressBookController.addToAddressBook()
        print("---Push通知を受け取りました---")
        print("Received the push notification: \(userInfo)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("---Push通知を受け取りました in Background??---")
        
        test = "kakikukeko"
        
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
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


}
