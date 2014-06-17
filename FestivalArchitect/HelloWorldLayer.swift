//
//  HelloWorldLayer.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 16/06/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation


class HelloWorldLayer : CCNode{
    
    
    class func scene() -> CCScene{
        
        var scene : CCScene = CCScene.node() as CCScene
        
        var layer : HelloWorldLayer = HelloWorldLayer.node() as HelloWorldLayer
        
        scene.addChild(layer)
        
        return scene
    }
    
    init(){
        super.init()
        
        
      //  var background : CCNodeColor = CCNodeColor(color: CCColor.whiteColor())
        //self.addChild(background)
        
        var label : CCLabelTTF = CCLabelTTF(string: "Hello World", fontName: "Chalkduster", fontSize: 36.0)
       // label.color = ccc3(<#r: GLubyte#>, <#g: GLubyte#>, <#b: GLubyte#>).redColor()
        label.position = CGPointMake(label.contentSize.width ,label.contentSize.height)
        self.addChild(label)
            
        
        var tileMap : CCTMXTiledMap = CCTMXTiledMap.tiledMapWithTMXFile("sample.tmx") as CCTMXTiledMap
        var background : CCTMXLayer = tileMap.layerNamed("Layer1")
        print(tileMap.boundingBox())
        print(background.boundingBox())
        

        self.addChild(tileMap, z: -1)
    }
    
    
}