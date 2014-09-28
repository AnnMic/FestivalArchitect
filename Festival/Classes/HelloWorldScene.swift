
//
//  HelloWorldScene.swift
//  TapSoccer
//
//  Created by Sid on 24/06/14.
//  Copyright (c) 2014 whackylabs. All rights reserved.
//

import Foundation

/**
*  The main scene
*/
class HelloWorldScene : CCScene {
    
    let _sprite:CCSprite?
    let _tileMap:CCTiledMap!
    let _background:CCTiledMapLayer!
    var _metaLayer:CCTiledMapLayer!
    var _terrainLayer:CCTiledMapLayer!
    let _spawnPoint:CGPoint!
    
    var _gameLayer:CCNode!
    
    let winSize:CGRect!
    var panningPosition : CGPoint!

    var environment : Environment!
    let moveSystem : MoveSystem!
    
    var hudLayer:HudLayer!
    
    override init()
    {
        super.init()
        
        // Enable touch handling on scene node
        userInteractionEnabled = true
        winSize = CCDirector.sharedDirector().view.frame
        panningPosition = CGPointMake(0, 0)

        addGestureRecognizers()
        _tileMap = CCTiledMap(file: "TileMap.tmx")
        _tileMap.position = CGPointMake(0, 0)
        _background = _tileMap.layerNamed("Background")
        addChild(_tileMap, z: -1)
        
        
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
        
        hudLayer = HudLayer()
        addChild(hudLayer, z:1)


        environment = Environment()
        moveSystem = MoveSystem(env: environment)
        createInitialPeople()
        
    }
    
    deinit
    {
        // clean up code goes here
    }
    
    override func onEnter()
    {
        // always call super onEnter first
        super.onEnter()
        
        // In pre-v3, touch enable and scheduleUpdate was called here
        // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
        // Per frame update is automatically enabled, if update is overridden
    }
    
    override func onExit()
    {
        // always call super onExit last
        super.onExit()
    }
    
    
    func createInitialPeople(){
        let human = environment.createEntity()
        human.setComponent(PositionComponent(x: 200, y: 200))
        human.setComponent(SpeedComponent(velocityX: 2.6, velocityY: 2.0))
        var humanSprite:CCSprite = CCSprite(imageNamed: "Player.png")
        
        human.setComponent(SpriteComponent(sprite: humanSprite))
        
        _tileMap.addChild(humanSprite)
    }
    
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!)
    {
        let touchLoc:CGPoint = touch.locationInNode(self)
        selectNodeForTouch(touchLoc)
    }
    
    func selectNodeForTouch(touchLocation : CGPoint) {
        var selectedItem:UInt32 = UInt32(hudLayer.selectedItem)
        var gid : UInt32 = selectedItem
        addSpriteToTileMap(gid, position: touchLocation)
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
    
    func onBackClicked(sender:AnyObject)
    {
        // back to intro scene with transition
        CCDirector.sharedDirector().replaceScene(IntroScene(), withTransition: CCTransition(pushWithDirection: CCTransitionDirection.Right, duration: 1.0))
    }
    
    func addGestureRecognizers() {
        let panGestureRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        CCDirector.sharedDirector().view.addGestureRecognizer(panGestureRecognizer)
    
        let pitchGestureRecognizer:UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "handlePitch:")
        CCDirector.sharedDirector().view.addGestureRecognizer(pitchGestureRecognizer)
    }
    
    func handlePan(sender : UIPanGestureRecognizer) {
        if(sender.state == UIGestureRecognizerState.Began){
            
        }
        else if(sender.state == UIGestureRecognizerState.Changed){
            var translation : CGPoint = sender.translationInView(sender.view!)
            translation = CGPointMake(translation.x, -translation.y)
            var curPos : CGPoint = _tileMap.position
            
            var newPos : CGPoint = CGPointMake(curPos.x + translation.x, curPos.y + translation.y)
            _tileMap.position = boundLayerPos(newPos)
            sender.setTranslation(CGPointZero, inView: sender.view)
            
            self.panningPosition = newPos
        }
        else if(sender.state == UIGestureRecognizerState.Ended){
            
        }
    }
    
    func handlePitch(sender : UIPinchGestureRecognizer) {

    }
    
    func boundLayerPos(newPos : CGPoint) -> CGPoint{
        var retval : CGPoint = newPos
        
        var mapSizeWidth =  (_tileMap.mapSize.width * _tileMap.tileSize.width)
        var mapSizeHeight =  (_tileMap.mapSize.height * _tileMap.tileSize.height)
        
        retval.x = min(retval.x, 0)
        retval.x = max(retval.x,-mapSizeWidth + winSize.width)
        retval.y = min(retval.y, 0)
        retval.y = max(retval.y, -mapSizeHeight + winSize.height)
        
        return retval
    }
}