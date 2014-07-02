import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    var glView : CCGLView?
    var viewController : RootViewController?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        setupWindow()
        setupCocos()
        
        
        var scene : CCScene = GameLayer.scene()
        var layer : GameLayer = scene.children.objectAtIndex(0) as GameLayer
        var gestureRecognizer : UIPanGestureRecognizer = UIPanGestureRecognizer(target: layer, action: "handlePan:")
        var gestureRecognizerPinch : UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: layer, action: "handlePinch:")
        
        viewController!.view.addGestureRecognizer(gestureRecognizer)
        viewController!.view.addGestureRecognizer(gestureRecognizerPinch)


        CCDirector.sharedDirector().runWithScene(scene)

        
        return true
    }
    
    func setupCocos(){
        var director : CCDirector = CCDirector.sharedDirector()
        //director.displayStats = true
        director.view = self.glView
        
        self.window!.makeKeyAndVisible()
    }
    
    func setupWindow() {
        self.glView = CCGLView(frame: UIScreen.mainScreen().bounds)
        self.viewController = RootViewController()
        self.viewController!.view.addSubview(self.glView)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.rootViewController = viewController;
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