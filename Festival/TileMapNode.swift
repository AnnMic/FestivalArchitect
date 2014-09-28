//
//  TileMapNode.swift
//  Festival
//
//  Created by Ann Michelsen on 28/09/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation

class TileMapNode : CCNode {

    let _sprite:CCSprite?
    let _tileMap:CCTiledMap!
    let _background:CCTiledMapLayer!
    var _metaLayer:CCTiledMapLayer!
    var _terrainLayer:CCTiledMapLayer!
    let _spawnPoint:CGPoint!
    
    var panningPosition : CGPoint!

    override init()
    {
        super.init()
    
        _tileMap = CCTiledMap(file: "TileMap.tmx")
        _tileMap.position = CGPointMake(0, 0)
        _background = _tileMap.layerNamed("Background")
        addChild(_tileMap, z: -1)
        
        panningPosition = CGPointMake(0, 0)

        _metaLayer = _tileMap.layerNamed("Meta")
        _metaLayer.visible = false;
        
        _terrainLayer = _tileMap.layerNamed("Foreground")
        
        var objectGroup:CCTiledMapObjectGroup = _tileMap.objectGroupNamed("Objects")
        var spawnPointDict : NSDictionary = objectGroup.objectNamed("SpawnPoint")
        var x : CGFloat = spawnPointDict["x"] as CGFloat
        var y : CGFloat = spawnPointDict["y"] as CGFloat
        _spawnPoint = CGPointMake(x, y)
        
        _sprite = CCSprite(imageNamed: "Player.png")
        _sprite!.position = CGPoint(x: x, y: y)
        addChild(_sprite)
    }
    
    func addSpriteToTileMap(tileGid : UInt32, position : CGPoint){
        var positionInTileMap = getPositionInTileMap(position)
        var tilePosition : CGPoint = _background.tileCoordinateAt(positionInTileMap)
        _background.removeTileAt(tilePosition)
        _background.setTileGID(tileGid, at: tilePosition)
    }
    
    func getPositionInTileMap(position : CGPoint) -> CGPoint{
        var tileSize = _tileMap.tileSize
        var x = position.x - panningPosition.x
        var y = position.y - panningPosition.y
        var newPos : CGPoint = CGPointMake(x, y)
        println("newPos \(newPos)")
        return newPos
    }
}