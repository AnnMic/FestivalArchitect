//
//  MapLayer.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 28/06/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation
class HudLayer : CCLayer{
    var tileString : NSString = ""
    var isInEditorMode : Bool = false

   init(){
        super.init()
        
        if(self != nil){
            CCDirector.sharedDirector().touchDispatcher.addTargetedDelegate(self, priority: 0, swallowsTouches: false)
            
         //   createLabel()
            createMenu()
            
        }
    }
   
    func createLabel(){
        var label : CCLabelTTF = CCLabelTTF(string: "HudLayer", fontName: "Chalkduster", fontSize: 36.0)
        label.position = CGPointMake(label.contentSize.width ,label.contentSize.height)
        self.addChild(label)
        
    }
    
    override func ccTouchBegan(touch: UITouch!, withEvent event: UIEvent!) -> Bool {
        return true
    }

    func createMenu(){
        var label : CCLabelTTF = CCLabelTTF(string: "Editor", fontName: "Chalkduster", fontSize: 36.0)
        var editorButton : CCMenuItemLabel = CCMenuItemLabel(label: label, target: self, selector: "editorButtonTapped:")
        editorButton.position = ccp(50,50)
        
        var menu : CCMenu = CCMenu(array: [editorButton])
        menu.position = CGPointZero
        self.addChild(menu)
        
    }
    
    func editorButtonTapped(sender : AnyObject){
        isInEditorMode = true
        var water : CCSprite = CCSprite(file: "water_tile.png")
        water.position = ccp(10,10)
        self.addChild(water)
        tileString = "water_tile.png"
    }
}