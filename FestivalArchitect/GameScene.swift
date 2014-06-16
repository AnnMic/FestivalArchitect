//
//  GameScene.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 08/06/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

class GameScene: CCScene {
    
    //var scene : CCScene
    
    class func scene() -> GameScene{
  
        return GameScene()
    }
    
    init() {

        super.init()
        
        var background : CCNodeColor = CCNodeColor(color: CCColor.whiteColor())
        self.addChild(background)
        
        var label : CCLabelTTF = CCLabelTTF(string: "Hello World", fontName: "Chalkduster", fontSize: 36.0)
        label.color = CCColor.redColor()
        label.position = CGPointMake(label.contentSize.width ,label.contentSize.height)
        self.addChild(label)
        
        
        
        
    }
   
}
