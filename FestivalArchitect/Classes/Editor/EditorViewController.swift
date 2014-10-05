//
//  EditorViewController.swift
//  Festival
//
//  Created by Ann Michelsen on 28/09/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation

class EditorViewController : UIViewController {
    @IBOutlet var scrollView : UIScrollView!

    override init()
    {
        super.init(nibName: "EditorView", bundle: NSBundle.mainBundle())
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        populateScrollView()
        
    }
    
    func populateScrollView(){
        var cardViewController : EditorCardViewController!
        
        for i in 0...5 {
            
            var spriteName: String = "shop\(i)"
            
            cardViewController = EditorCardViewController(imageName: spriteName)
            
            var gap : CGFloat = i == 0 ? 0 : 20
            var newPosition : CGFloat = cardViewController.view.frame.height * CGFloat(i) + gap * CGFloat(i)
            
            cardViewController.view.frame = CGRectMake(0, newPosition, cardViewController.view.frame.width, cardViewController.view.frame.height)
            self.addChildViewController(cardViewController)
            scrollView.addSubview(cardViewController.view)
            cardViewController.didMoveToParentViewController(self)
        }
        var contentHeight:CGFloat = cardViewController.view.frame.origin.y + cardViewController.view.frame.height + 20
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, contentHeight)
        
    }
}
