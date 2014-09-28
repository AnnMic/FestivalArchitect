import UIKit
import SpriteKit

class EditorViewController: UIViewController {
    
    override init()
    {
        super.init()
        let editorScrollViewController : EditorScrollViewController = EditorScrollViewController(gid: 48)
        
        scrollViewContainer.addSubview(editorScrollViewController.view)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
