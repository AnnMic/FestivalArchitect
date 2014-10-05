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
    var confirm:CCButton!
    var cancel:CCButton!
    var editorViewController : EditorViewController!
    let winSize:CGRect!

    override init()
    {
        super.init()
        
        winSize = CCDirector.sharedDirector().view.frame

        setupButtons()
        setupEditorMenu()
        addObservers()
    }
    override func onExit()
    {
        super.onExit()
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    func addObservers(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addConformButtonsForTileMap:", name:AJAddTileToTileMap, object: nil)
    }
    
    func setupEditorMenu(){
        editorViewController = EditorViewController()
        CCDirector.sharedDirector().view.addSubview(editorViewController.view)
        //   CCDirector.sharedDirector().addChildViewController(editorViewController)
        var editorFrame : CGRect = editorViewController.view.frame
        editorViewController.view.frame = CGRect(x: -editorFrame.size.width, y: 0, width: editorFrame.size.width, height: editorFrame.size.height)

    }
    
    func setupButtons(){
        createButton("[ EDITOR ]", position: CGPointMake(50, 50),selector: "onEditorClicked:")
        
    }
    
    func createButton(title:String, position:CGPoint, selector:Selector) -> CCButton {
        let button:CCButton = CCButton(title: title, fontName: "Verdana-Bold", fontSize: 18.0)
        button.position = position
        button.setTarget(self, selector: selector)
        addChild(button)
        return button
    }
    
    func itemButton(){
        confirm = createButton("[Confirm]", position: CGPointMake(winSize.width-200, 50),selector: "onConfirmClicked:")
        cancel = createButton("[Cancel]", position: CGPointMake(winSize.width-50, 50),selector: "onCancelClicked:")
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
    
    func addConformButtonsForTileMap(sender:AnyObject){
        itemButton()
        hideEditorMenu()
    }
    
    func onEditorClicked(sender:AnyObject)
    {
        var editorFrame : CGRect = editorViewController.view.frame
        editorViewController.view.frame = CGRect(x: 0, y: 0, width: editorFrame.size.width, height: editorFrame.size.height)
    
    }
    
    func onConfirmClicked(sender:AnyObject) {
        cleanup()
        NSNotificationCenter.defaultCenter().postNotificationName(AJConfirmTileToBeAdded, object: nil)

    }
    
    func onCancelClicked(sender:AnyObject) {
        cleanup()
        NSNotificationCenter.defaultCenter().postNotificationName(AJCancelTileToBeAdded, object: nil)

    }
    
    func hideEditorMenu(){
        var editorFrame : CGRect = editorViewController.view.frame
        editorViewController.view.frame = CGRect(x: -editorFrame.size.width, y: 0, width: editorFrame.size.width, height: editorFrame.size.height)
    }
    

    
    func cleanup(){
        removeChild(confirm)
        removeChild(cancel)
    }
}
