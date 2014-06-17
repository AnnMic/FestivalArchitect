import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    var glView : CCGLView?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        setupWindow()
        setupCocos()
        
        CCDirector.sharedDirector().runWithScene(HelloWorldLayer.scene());
        
        return true
    }
    
    func setupCocos(){
        var director : CCDirector = CCDirector.sharedDirector()
        director.displayStats = true
        director.view = self.glView
        
        self.window!.makeKeyAndVisible()
    }
    
    func setupWindow() {
        self.glView = CCGLView(frame: UIScreen.mainScreen().bounds)
        var controller : RootViewController = RootViewController()
        controller.view.addSubview(self.glView)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.rootViewController = controller;
    }
    
    func applicationWillResignActive(application: UIApplication) {
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        CCDirector.sharedDirector().startAnimation()
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
    }
    
    func applicationWillTerminate(application: UIApplication) {
    }
}