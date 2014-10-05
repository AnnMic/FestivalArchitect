//
//  TileMapNode.swift
//  Festival
//
//  Created by Ann Michelsen on 28/09/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation

class TileMapNode : CCNode {
    var dragDropSprite :CCSprite!
    var dragDropFileName :String!

    let tileMap:CCTiledMap!
    let background:CCTiledMapLayer!
    var metaLayer:CCTiledMapLayer!
    var foregroundLayer:CCTiledMapLayer!
    var npcLayer:CCTiledMapLayer!

    var panningPosition : CGPoint!
    let spawnPoint:CGPoint!
    let winSize:CGRect!

    override init()
    {
        super.init()
    
        tileMap = CCTiledMap(file: "TileMap.tmx")
        tileMap.position = CGPointMake(0, 0)
        addChild(tileMap, z: -1)

        winSize = CCDirector.sharedDirector().view.frame

        panningPosition = CGPointMake(0, 0)

        metaLayer = tileMap.layerNamed("Meta")
        metaLayer.visible = false;
        
        background = tileMap.layerNamed("Background")
        foregroundLayer = tileMap.layerNamed("Foreground")
        
        npcLayer = tileMap.layerNamed("npc")

        
        var objectGroup:CCTiledMapObjectGroup = tileMap.objectGroupNamed("Objects")
        var spawnPointDict : NSDictionary = objectGroup.objectNamed("SpawnPoint")
        var x : CGFloat = spawnPointDict["x"] as CGFloat
        var y : CGFloat = spawnPointDict["y"] as CGFloat
        spawnPoint = CGPointMake(x, y)
        
        addObservers()
    }
    
    func addObservers(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addDragSprite:", name:AJAddTileToTileMap, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addSpriteToTileMap:", name:AJConfirmTileToBeAdded, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "removeDragSprite:", name:AJCancelTileToBeAdded, object: nil)

    }
    
    override func onExit()
    {
        super.onExit()
        NSNotificationCenter.defaultCenter().removeObserver(self)

    }
    
    func addDragSprite(notification:NSNotification){
        let userInfo = notification.userInfo as Dictionary<String,String!>
        let messageString:String = userInfo["message"]!
        dragDropFileName = messageString + ".png"
        dragDropSprite = CCSprite(imageNamed: dragDropFileName)
        dragDropSprite.position = CGPointMake(winSize.width/2-panningPosition.x, winSize.height/2-panningPosition.y)
        addChild(dragDropSprite)
    }
    
    func removeDragSprite(sender:AnyObject){
        removeChild(dragDropSprite)
    }
    
    func addSpriteToTileMap(sender:AnyObject){
        var sprite:CCSprite = CCSprite(imageNamed: dragDropFileName)
        sprite.position = dragDropSprite.position
        removeChild(dragDropSprite)

        addChild(sprite)
    }

    /*  
    code to add the sprite to the actual tilemap
    var panningPos = getPositionInTileMap(sprite.position)
    var positionInTileMap = tileCoordForPosition(panningPos)
    background.removeTileAt(positionInTileMap)
    background.setTileGID(150, at: positionInTileMap)
    removeChild(sprite)*/
    
    func getPositionInTileMap(position : CGPoint) -> CGPoint{
        var x = position.x - panningPosition.x
        var y = position.y - panningPosition.y
        var newPos : CGPoint = CGPointMake(x, y)
        return newPos
    }
    
    func tileCoordForPosition(position:CGPoint) -> CGPoint{
        var x: Int = Int(position.x) / Int(tileMap.tileSize.width)
        var y: Int = Int((tileMap.mapSize.height * tileMap.tileSize.height) - position.y) / Int(tileMap.tileSize.height);

        return CGPointMake(CGFloat(x), CGFloat(y))
    }
    
    func positionForTileCoord(tileCoord:CGPoint) -> CGPoint{
        var x:CGFloat = (tileCoord.x * tileMap.tileSize.width) + tileMap.tileSize.width;
        var y:CGFloat = (tileMap.mapSize.height * tileMap.tileSize.height) - (tileCoord.y * tileMap.tileSize.height) - tileMap.tileSize.height;
        return CGPointMake(x, y)
    }
    
}