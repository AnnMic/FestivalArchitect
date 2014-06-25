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
    var meta : CCTMXLayer?
    var foreground : CCTMXLayer?

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
        foreground = tileMap!.layerNamed("Foreground")
        meta = tileMap!.layerNamed("Meta")
        meta!.visible = false;
        
        var objectGroup :CCTMXObjectGroup = tileMap!.objectGroupNamed("Objects")
        
        var spawnPoint : NSDictionary = objectGroup.objectNamed("SpawnPoint")
        var x = spawnPoint["x"].floatValue
        var y = spawnPoint["y"].floatValue

        player = CCSprite(file: "Player.png")
        player!.position = ccp(x, y)
        
    
        var spawnPointPerson : NSDictionary = objectGroup.objectNamed("PeopleSpawn1")
        var xPerson = spawnPointPerson["x"].floatValue
        var yPerson = spawnPointPerson["y"].floatValue
        addPersonAtX(ccp(xPerson,yPerson))
        
        self.addChild(player)
        self.setViewPointCenter(player!.position)
        
        self.addChild(tileMap, z: -1)
        
        addSpriteToTileMap()
        
    }
    func addSpriteToTileMap(){
        var tileAddPosition :CGPoint = player!.position
        var test = CCSprite(file: "enemy1.png")
     
        test.anchorPoint = CGPointZero
        test.position = tileAddPosition
        tileMap!.addChild(test, z: 10)

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
    
    override func ccTouchEnded(touch: UITouch!, withEvent event: UIEvent!) {
        var touchLocation : CGPoint = touch.locationInView(touch.view)
        touchLocation = CCDirector.sharedDirector().convertToGL(touchLocation)
        touchLocation = self.convertToNodeSpace(touchLocation)
        
        var playerPos : CGPoint = player!.position
        var diff : CGPoint = ccpSub(touchLocation, playerPos)
        
        if(abs(diff.x) > abs(diff.y)){
            if(diff.x > 0){
                playerPos.x += tileMap!.tileSize.width
            }
            else{
                playerPos.x -= tileMap!.tileSize.width

            }
        }
        else{
            if(diff.y > 0){
                playerPos.y += tileMap!.tileSize.height
            }
            else{
                playerPos.y -= tileMap!.tileSize.height
                
            }
        }
        setPlayerPosition(playerPos)
        
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
    
    func tileCoordForPosition(position : CGPoint) -> CGPoint{
        var x = position.x / tileMap!.tileSize.width
        var y = ((tileMap!.mapSize.height * tileMap!.tileSize.height) - position.y) / tileMap!.tileSize.height
        return ccp(x,y)
        
    }
    
    func setPlayerPosition(position : CGPoint){
        var tileCoord : CGPoint = tileCoordForPosition(position)
        var tileGid = meta!.tileGIDAt(tileCoord)
        
        if(tileGid != nil){
            var properties = tileMap!.propertiesForGID(tileGid)

            if(properties != nil){
                var collision : NSString = properties.objectForKey("Collidable") as NSString
                if(collision != nil && collision.isEqualToString("True") ){
                    return
                }
                var collectable : NSString = properties.objectForKey("Collectable") as NSString
                if(collectable != nil && collectable.isEqualToString("True") ){
                    meta!.removeTileAt(tileCoord)
                    foreground!.removeTileAt(tileCoord)
                }
                
            }
            
        }
        
        player!.position = position
    }


    func addPersonAtX(position :CGPoint){
        var person: CCSprite = CCSprite(file: "Player.png")
        person.position = position
        self.addChild(person)

        animatePerson(person)
    }
    
    func personMoveFinished(sender : AnyObject){

    }
    
    func animatePerson(person : CCSprite){
        var actualDuration :ccTime = 3.0
        var actionMove : CCAction = CCMoveTo.actionWithDuration(actualDuration, position: CGPointMake(player!.position.x, player!.position.y)) as CCAction
        var actionMoveDone = CCCallFunc.actionWithTarget(self, selector: "personMoveFinished:")
       // CCSequence.actions(actionMove,actionMoveDone)
        var arrayActions = [actionMove, actionMoveDone]
        person.runAction(CCSequence.actionWithArray(arrayActions) as CCAction)
    }

}