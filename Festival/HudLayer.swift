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
    var sprite :CCSprite!
    var helloScene: HelloWorldScene!
    var confirm:CCButton!
    var cancel:CCButton!
    var editorViewController : EditorViewController!

    init(scene: HelloWorldScene)
    {
        super.init()
        helloScene = scene
        
        setupButtons()
        setupEditorMenu()
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
        confirm = createButton("[Confirm]", position: CGPointMake(700, 50),selector: "onConfirmClicked:")
        cancel = createButton("[Cancel]", position: CGPointMake(850, 50),selector: "onCancelClicked:")
    }
    
    func setupButton(){
        decorationButton("bush_green.png",position: CGPointMake(200, 40), tag: "48")
        decorationButton("sign.png",position: CGPointMake(250, 40), tag: "46")
        decorationButton("stone.png",position: CGPointMake(300, 40), tag: "47")
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
        itemButton()
        selectedItem = sender.title.toInt()!
        addDragSprite()
    }
    
    func addDragSprite(){
        sprite = CCSprite(imageNamed: "bush_green.png")
        sprite.position = CGPointMake(500, 500)
        addChild(sprite)
    }
    
    func onEditorClicked(sender:AnyObject)
    {
        setupButton()
        var editorFrame : CGRect = editorViewController.view.frame
        editorViewController.view.frame = CGRect(x: 0, y: 0, width: editorFrame.size.width, height: editorFrame.size.height)
    
    }
    
    func onConfirmClicked(sender:AnyObject) {
        cleanup()
        helloScene.placeGid(selectedItem)
    }
    
    func hideEditorMenu(){
        var editorFrame : CGRect = editorViewController.view.frame
        editorViewController.view.frame = CGRect(x: -editorFrame.size.width, y: 0, width: editorFrame.size.width, height: editorFrame.size.height)
    }
    
    func onCancelClicked(sender:AnyObject) {
        cleanup()
    }
    func cleanup(){
        removeChild(sprite)
        removeChild(confirm)
        removeChild(cancel)
    }
}
