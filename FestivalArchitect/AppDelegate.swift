//
//  AppDelegate.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 08/06/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

/*@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        // Override point for customization after application launch.
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
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}*/

class AppDelegate : CCAppDelegate{
    
    override func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        // This is the only app delegate method you need to implement when inheriting from CCAppDelegate.
        // This method is a good place to add one time setup code that only runs when your app is first launched.
        
        // Setup Cocos2D with reasonable defaults for everything.
        // There are a number of simple options you can change.
        // If you want more flexibility, you can configure Cocos2D yourself instead of calling setupCocos2dWithOptions:.
        setupCocos2dWithOptions([CCSetupShowDebugStats: (true)])
        
              return true;
    }
    
    override func startScene() -> CCScene! {
        
        return GameScene.scene()
    }
    
}

