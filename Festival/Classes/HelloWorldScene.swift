
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
        
        addChild(humanSprite)
    }
    
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!)
    {
        let touchLoc:CGPoint = touch.locationInNode(self)
        selectNodeForTouch(touchLoc)
    }
    
    func selectNodeForTouch(touchLocation : CGPoint) {
        var selectedItem:UInt32 = UInt32(hudLayer.selectedItem)
        var gid : UInt32 = selectedItem
        tileMapNode.addSpriteToTileMap(gid, position: touchLocation)
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
            
            tileMapNode.panningPosition = newPos
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