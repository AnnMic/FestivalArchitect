import UIKit
import SpriteKit

class EditorCardViewController: UIViewController {
    @IBOutlet var tileImage : UIImageView!
    var imageName : String!
    
    init(var imageName : String!) {
        super.init(nibName: "EditorCardView", bundle: NSBundle.mainBundle())
        self.imageName = imageName
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tileImage.image = UIImage(named: imageName)

    }
    
    @IBAction func buyObject(AnyObject){
        var dataDict = Dictionary<String, String>()
        dataDict["message"] = imageName
        
        NSNotificationCenter.defaultCenter().postNotificationName(AJAddTileToTileMap, object: self, userInfo: dataDict)
        
    }

}