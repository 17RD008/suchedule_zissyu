//
//  AppDelegate.swift
//  Schedule001
//
//  Created by 田村大樹 on 2019/04/24.
//  Copyright © 2019 Tamura Daiki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var NumToDate =
        [1:"月曜1限",2:"月曜2限",3:"月曜3限",4:"月曜4限",5:"月曜5限",
         6:"火曜1限",7:"火曜2限",8:"火曜3限",9:"火曜4限",10:"火曜5限",
         11:"水曜1限",12:"水曜2限",13:"水曜3限",14:"水曜4限",15:"水曜5限",
         16:"木曜1限",17:"木曜2限",18:"木曜3限",19:"木曜4限",20:"木曜5限",
         21:"金曜1限",22:"金曜2限",23:"金曜3限",24:"金曜4限",25:"金曜5限"]


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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


}

