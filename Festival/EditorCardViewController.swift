import UIKit
import SpriteKit

class EditorCardViewController: UIViewController {
    @IBOutlet var tileImage : UIImageView!
    var tile : UIImage!
    
    init(var image : UIImage!) {
        super.init(nibName: "EditorCardView", bundle: NSBundle.mainBundle())
        tile = image
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tileImage.image = tile

    }
    
    @IBAction func buyObject(AnyObject){
        println("buy something");
    }
}
