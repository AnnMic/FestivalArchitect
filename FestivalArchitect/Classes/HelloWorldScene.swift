
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
    
    let sprite:CCSprite?

    var tileMapNode:TileMapNode!
    let tileMap:CCTiledMap!
    let npcLayer:CCTiledMapLayer!

    let winSize:CGRect!
    var selectedSprite:CCSprite!
    var aStar:AStar!

    var hudLayer:HudLayer!
    var environment : Environment!
    let moveSystem : MoveSystem!
    let aiSystem : AISystem!

    var AStarHuman:CCSprite!
    
    override init()
    {
        super.init()
        
        // Enable touch handling on scene node
        userInteractionEnabled = true
        addGestureRecognizers()
        
        winSize = CCDirector.sharedDirector().view.frame
        tileMapNode = TileMapNode()
        addChild(tileMapNode)
        
        tileMap = tileMapNode.tileMap
        npcLayer = tileMapNode.npcLayer

        hudLayer = HudLayer()
        addChild(hudLayer, z:1)

        environment = Environment()
        moveSystem = MoveSystem(env: environment)
        aiSystem = AISystem(env: environment)

        createAIVisitor()


       //  aStar = AStar(tileMapNode: tileMapNode, hello: self)
      //  AStarHuman = CCSprite(imageNamed: "Player.png")
       // AStarHuman.position = tileMapNode.spawnPoint
       // tileMapNode.addChild(AStarHuman, z: tileMapNode.npcLayer.zOrder)

    }
    
 /*   func createInitialPeople(){
        let human = environment.createEntity()
        human.setComponent(MoveComponent(moveTarget: CGPointMake(0, 0), acc: CGPointMake(20, 20), velocity: CGPointMake(50, 50)))
        var humanSprite:CCSprite = CCSprite(imageNamed: "Player.png")
        human.setComponent(AnimateComponent(moveTarget: CGPointMake(500, 0), sprite: humanSprite))

        human.setComponent(RenderComponent(sprite: humanSprite, spawnPosition: tileMapNode.spawnPoint))
        
        human.setComponent(AIComponent(currentState: AIStateQuenchHunger()))

        
        tileMapNode.addChild(humanSprite, z: npcLayer.zOrder)
        

    }*/

   
    func createAIVisitor(){
        var sprite:CCSprite = CCSprite(imageNamed: "Player.png")
        //[_batchNode addChild:sprite];

        let entity = environment.createEntity()

        entity.setComponent(MoveComponent(moveTarget: CGPointMake(0, 0), acc: CGPointMake(20, 20), velocity: CGPointMake(50, 50)))
        entity.setComponent(AnimateComponent(moveTarget: CGPointMake(500, 0), sprite: sprite))
        entity.setComponent(RenderComponent(sprite: sprite, spawnPosition: tileMapNode.spawnPoint))
        entity.setComponent(AIComponent(currentState: AIStateQuenchHunger()))
        entity.setComponent(HungerComponent(hunger: 30))
        entity.setComponent(ThirstComponent(thirst: 30))

        tileMapNode.addChild(sprite, z: npcLayer.zOrder)
        
    }
    
    func addGestureRecognizers() {
        let panGestureRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        CCDirector.sharedDirector().view.addGestureRecognizer(panGestureRecognizer)
        
        let pitchGestureRecognizer:UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "handlePitch:")
        CCDirector.sharedDirector().view.addGestureRecognizer(pitchGestureRecognizer)
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
    
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!)
    {
     //   let touchLoc:CGPoint = touch.locationInNode(self)
       // aStar.moveToward(touchLoc)
        
        //  let touchLoc:CGPoint = touch.locationInNode(self)
        //  println("Move sprite to \(NSStringFromCGPoint(touchLoc))")
        
        hudLayer.hideEditorMenu()

        // Move our sprite to touch location
     //   let actionMove:CCActionMoveTo = CCActionMoveTo(duration: 1.0, position: touchLoc)
     //   _sprite!.runAction(actionMove)
    }
    
    func selectSpriteForTouch(touchLocation : CGPoint) {
        if tileMapNode.dragDropSprite != nil {
            var locationWithPanning = CGPointMake(touchLocation.x-tileMapNode.panningPosition.x, touchLocation.y-tileMapNode.panningPosition.y)
            if(CGRectContainsPoint(tileMapNode.dragDropSprite.boundingBox(), locationWithPanning)){
                selectedSprite = tileMapNode.dragDropSprite
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
            var curPos : CGPoint = tileMapNode.position
            var newPos : CGPoint = CGPointMake(curPos.x + translation.x, curPos.y + translation.y)
            tileMapNode.position = boundLayerPos(newPos)
            
            tileMapNode.panningPosition = newPos
        }
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

    }
    
    func boundLayerPos(newPos : CGPoint) -> CGPoint{
        var retval : CGPoint = newPos
        
        var mapSizeWidth =  (tileMap.mapSize.width * tileMap.tileSize.width)
        var mapSizeHeight =  (tileMap.mapSize.height * tileMap.tileSize.height)
        
        retval.x = min(retval.x, 0)
        retval.x = max(retval.x,-mapSizeWidth + winSize.width)
        retval.y = min(retval.y, 0)
        retval.y = max(retval.y, -mapSizeHeight + winSize.height)
        
        return retval
    }
    
    override func update(delta : CCTime){
        
        moveSystem.update(Float(delta))
        aiSystem.update(Float(delta))
    }

    


}