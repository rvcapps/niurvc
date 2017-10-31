//
//  AppDelegate.swift
//  test
//
//  Created by Charles Konkol on 10/17/17.
//  Copyright © 2017 RockValleyCollege. All rights reserved.
//

import UIKit
import Parse
import Bolts
import UserNotifications
import SafariServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, SFSafariViewControllerDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let configuration = ParseClientConfiguration {
            $0.applicationId = "TjbPmFEBIj7C9wiIqnfp2wqe0zYss2M9ZPGFA3Nu"
            $0.clientKey = "QMLMAF4cDTQoPUWRwSRQCtwUO5DYf04NhvXcFrV7"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: configuration)
        print("initializeFCM")
        //-------------------------------------------------------------------------//
        if #available(iOS 10.0, *) // enable new way for notifications on iOS 10
        {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.badge, .alert , .sound]) { (accepted, error) in
                if !accepted
                {
                    print("Notification access denied.")
                }
                else
                {
                    print("Notification access accepted.")
                    UIApplication.shared.registerForRemoteNotifications();
                }
            }
        }
        else
        {
            
            let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
            let notificationSettings: UIUserNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
            // Register app for receive notifications
            UIApplication.shared.registerUserNotificationSettings(notificationSettings)
            UIApplication.shared.registerForRemoteNotifications()
        }
        // We want to register the installation in the back4app channel.
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.badge = 0 // your badge count
        } else {
            // Fallback on earlier versions
            application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge], categories: nil))
            application.applicationIconBadgeNumber = 0
        }
        
        return true
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
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let otherVC = sb.instantiateViewController(withIdentifier: "notif") as! NotificationsViewController
        window?.rootViewController = otherVC;
        
    }
    
    @objc(application:didRegisterForRemoteNotificationsWithDeviceToken:) func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
          let username = UIDevice.current.name
          let installation = PFInstallation.current()
        installation?.setDeviceTokenFrom(deviceToken)
        installation?.setObject(username, forKey: "username")
        installation?.saveInBackground()
        PFPush.subscribeToChannel(inBackground: "niurvc")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        PFPush.handle(userInfo)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let otherVC = sb.instantiateViewController(withIdentifier: "notif") as! NotificationsViewController
        window?.rootViewController = otherVC;
        
        
        application.applicationIconBadgeNumber = 0
        switch application.applicationState {
        case .active:
            //app is currently active, can update badges count here
            //app is transitioning from background to foreground (user taps notification), do what you need when user taps here
            
            
            break
        case .inactive:
            
            break
        case .background:
            //app is in background, if content-available key of your notification is set to 1, poll to your backend to retrieve data and update your interface here
            break
        default:
            break
        }
    }
    
}

