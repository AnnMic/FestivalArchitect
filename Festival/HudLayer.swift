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
    
    func setupButton(){
        decorationButton("bush_green.png",position: CGPointMake(200, 40), tag: "48")
        decorationButton("sign.png",position: CGPointMake(250, 40), tag: "47")
        decorationButton("stone.png",position: CGPointMake(300, 40), tag: "46")
    }
    func decorationButton(spriteName : String, position: CGPoint, tag : String){
        let spriteFrame:CCSpriteFrame = CCSpriteFrame.frameWithImageNamed(spriteName) as CCSpriteFrame
        let spriteFrameSelected:CCSpriteFrame = CCSpriteFrame.frameWithImageNamed("selected.png") as CCSpriteFrame
        
        let button:CCButton = CCButton(title: tag, spriteFrame: spriteFrame, highlightedSpriteFrame: spriteFrameSelected, disabledSpriteFrame: spriteFrameSelected)
        button.position = position
        button.scale = 1.5
        button.setTarget(self, selector: "onDecorationClicked:")
        
        addChild(button)
    }
    
    func onDecorationClicked(sender:CCButton){
        sender.selected = true
        selectedItem = sender.title.toInt()!
        addDragSprite()
    }
    func addDragSprite(){
        let sprite :CCSprite = CCSprite(imageNamed: "bush_green.png")
        sprite.position = CGPointMake(500, 500)
        addChild(sprite)
    }
    
    func onEditorClicked(sender:AnyObject)
    {
        setupButton()
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
