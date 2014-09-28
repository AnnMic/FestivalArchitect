//
//  HudLayer.swift
//  Festival
//
//  Created by Ann Michelsen on 27/09/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation


class HudLayer : CCNode {
    var selectedItem:Int = 0

    
    override init()
    {
        super.init()
        
        createEditorButton()
    }
    
    func createEditorButton(){
        // Create a back button
        let editorButton:CCButton = CCButton(title: "[ Editor ]", fontName: "Verdana-Bold", fontSize: 18.0)
        editorButton.position = CGPoint(x: 50, y: 50) // Top Right of screen
        editorButton.setTarget(self, selector: "onEditorClicked:")
        addChild(editorButton)
    }
    
    func onEditorClicked(sender:AnyObject)
    {
    //    var editorPopup:EditorPopupNode = EditorPopupNode()
    //    editorPopup.contentSize = CGSizeMake(50, 50)
     //   addChild(editorPopup)
        
      /*  let editorViewController:EditorPopupViewController = EditorPopupViewController()
        var editorFrame : CGRect = editorViewController.view.frame
        editorViewController.view.frame = CGRect(x: 0, y: 0, width: editorFrame.size.width, height: editorFrame.size.height)

        CCDirector.sharedDirector().addChildViewController(editorViewController)
        CCDirector.sharedDirector().view.addS*/
        
    }
    

}
