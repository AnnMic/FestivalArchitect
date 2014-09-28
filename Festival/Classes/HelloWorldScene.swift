
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
    

    let _tileMap:CCTiledMap!
    var _gameLayer:CCNode!
    
    let winSize:CGRect!

    var environment : Environment!
    let moveSystem : MoveSystem!
    
    var hudLayer:HudLayer!
    var tileMapNode:TileMapNode!
    var selectedSprite:CCSprite!

    override init()
    {
        super.init()
        
        // Enable touch handling on scene node
        userInteractionEnabled = true
        winSize = CCDirector.sharedDirector().view.frame

        addGestureRecognizers()
        
        tileMapNode = TileMapNode()
        addChild(tileMapNode)

        _tileMap = tileMapNode._tileMap
        
        hudLayer = HudLayer(scene:self)
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
    func addGestureRecognizers() {
        let panGestureRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        CCDirector.sharedDirector().view.addGestureRecognizer(panGestureRecognizer)
        
        let pitchGestureRecognizer:UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "handlePitch:")
        CCDirector.sharedDirector().view.addGestureRecognizer(pitchGestureRecognizer)
    }
    
    func createInitialPeople(){
        let human = environment.createEntity()
        human.setComponent(PositionComponent(x: 200, y: 200))
        human.setComponent(SpeedComponent(velocityX: 2.6, velocityY: 2.0))
        var humanSprite:CCSprite = CCSprite(imageNamed: "Player.png")
        
        human.setComponent(SpriteComponent(sprite: humanSprite))
        
        addChild(humanSprite)
    }
    
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!)
    {
        let touchLoc:CGPoint = touch.locationInNode(self)
        hudLayer.hideEditorMenu()
    }
    
    func selectSpriteForTouch(touchLocation : CGPoint) {
        if hudLayer.sprite != nil {
            if(CGRectContainsPoint(hudLayer.sprite.boundingBox(), touchLocation)){
                selectedSprite = hudLayer.sprite
            }
            else{
                selectedSprite = nil
            }
        }
    }
    
    func panForTranslation(translation : CGPoint){
        if (selectedSprite != nil) {
            let newPos:CGPoint = CGPointMake(selectedSprite.position.x+translation.x, selectedSprite.position.y+translation.y)
            selectedSprite.position = newPos
        }
        else{
            var curPos : CGPoint = _tileMap.position
            var newPos : CGPoint = CGPointMake(curPos.x + translation.x, curPos.y + translation.y)
            _tileMap.position = boundLayerPos(newPos)
            
            tileMapNode.panningPosition = newPos
        }
    }
    func placeGid(gid:Int){
          var selectedItem:UInt32 = UInt32(gid)
          var gid : UInt32 = selectedItem
          tileMapNode.addSpriteToTileMap(gid, position: hudLayer.sprite.position)
    }
    
    func handlePan(sender : UIPanGestureRecognizer) {
        if(sender.state == UIGestureRecognizerState.Began){
            var touchLocation:CGPoint = sender.locationInView(sender.view)
            touchLocation = CCDirector.sharedDirector().convertToGL(touchLocation)
            touchLocation = convertToNodeSpace(touchLocation)
            selectSpriteForTouch(touchLocation)
        }
        else if(sender.state == UIGestureRecognizerState.Changed){
            var translation : CGPoint = sender.translationInView(sender.view!)
            translation = CGPointMake(translation.x, -translation.y)
            
            panForTranslation(translation)
            sender.setTranslation(CGPointZero, inView: sender.view)
            

        }
        else if(sender.state == UIGestureRecognizerState.Ended){
            
        }
    }
    
    func handlePitch(sender : UIPinchGestureRecognizer ) {
        var startScale:Float = 1
        if(sender.state == UIGestureRecognizerState.Began){
            startScale = scene.scaleX
        }
        var newScale:Float = startScale * Float(sender.scale)
        tileMapNode.scaleX = min(2.0, max(newScale, 0.05))
        tileMapNode.scaleY = scene.scaleX
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