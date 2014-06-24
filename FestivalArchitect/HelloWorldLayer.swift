//
//  HelloWorldLayer.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 16/06/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation



class HelloWorldLayer : CCLayer{
    var tileMap : CCTMXTiledMap?
    var player : CCSprite?
    
    class func scene() -> CCScene{
        
        var scene : CCScene = CCScene.node() as CCScene
        
        var layer : HelloWorldLayer = HelloWorldLayer.node() as HelloWorldLayer
        
        scene.addChild(layer)
        
        return scene
    }
    
    init(){
        super.init()
        
        
        CCDirector.sharedDirector().touchDispatcher.addTargetedDelegate(self, priority: 0, swallowsTouches: true)
        
        var label : CCLabelTTF = CCLabelTTF(string: "Hello World", fontName: "Chalkduster", fontSize: 36.0)
        label.position = CGPointMake(label.contentSize.width ,label.contentSize.height)
        self.addChild(label)
            
        
        tileMap = CCTMXTiledMap.tiledMapWithTMXFile("TileMap.tmx") as CCTMXTiledMap
        var background : CCTMXLayer = tileMap!.layerNamed("Background")
        var objectGroup :CCTMXObjectGroup = tileMap!.objectGroupNamed("Objects")
        
        var spawnPoint : NSDictionary = objectGroup.objectNamed("SpawnPoint")
        var x = spawnPoint["x"].floatValue
        var y = spawnPoint["y"].floatValue

        player = CCSprite(file: "Player.png")
        player!.position = ccp(x, y)
        
        self.addChild(player)
        self.setViewPointCenter(player!.position)
        
        self.addChild(tileMap, z: -1)
        
    }
    
    func setViewPointCenter(position : CGPoint){
        
        var winSize : CGSize = CCDirector.sharedDirector().winSize()
        
        var x = max(position.x, winSize.width/2)
        var y = max(position.y, winSize.height/2)
        x = min(x, (tileMap!.mapSize.width * tileMap!.tileSize.width) - winSize.width/2)
        y = min(y, (tileMap!.mapSize.height * tileMap!.tileSize.height) - winSize.height/2)
        var actualPosition = ccp(x, y)
        
        
        var centerOfView = ccp(winSize.width/2, winSize.height/2)
        var viewPoint = ccpSub(centerOfView, actualPosition)
        self.position = viewPoint
    }
    override func ccTouchBegan(touch: UITouch!, withEvent event: UIEvent!) -> Bool {
        return true
    }
    

    override func ccTouchMoved(touch: UITouch!, withEvent event: UIEvent!){
        var touchLocation : CGPoint = self.convertTouchToNodeSpace(touch)
        var oldTouchLocation = touch.previousLocationInView(touch.view)
        oldTouchLocation = CCDirector.sharedDirector().convertToGL(oldTouchLocation)
        oldTouchLocation = self.convertToNodeSpace(oldTouchLocation)
        
        var translation = ccpSub(touchLocation, oldTouchLocation)
        panForTranslation(translation)
        
    }
  
    func panForTranslation(translation : CGPoint) {
        var newPoint : CGPoint = ccpAdd(self.position, translation)
        self.position = boundLayerPos(newPoint)
    }
    
    func boundLayerPos(newPos : CGPoint) -> CGPoint{
        var winSize : CGSize = CCDirector.sharedDirector().winSize()
        var retval : CGPoint = newPos
        retval.x = min(retval.x,0)
        retval.x = max(retval.x,-tileMap!.contentSize.width + winSize.width)
        
        retval.y = min(retval.y,0)
        retval.y = max(retval.y,-tileMap!.contentSize.height + winSize.height)
        
        return retval
    }
    
    
    func setPlayerPosition(position : CGPoint){
        player!.position = position
    }

}