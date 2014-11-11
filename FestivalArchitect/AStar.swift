//
//  AStar.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 05/10/14.
//  Copyright (c) 2014 whackylabs. All rights reserved.
//

import Foundation

extension Array {
    func contains<T : Equatable>(obj: T) -> Bool {
        let filtered = self.filter {$0 as? T == obj}
        return filtered.count > 0
    }
}

class AStar {
    var pathFound:Bool = false
    
    var spOpenSteps = [ShortestPathStep]()
    var spClosedSteps = [ShortestPathStep]()
    var shortestPath = [ShortestPathStep]()

    var tileMapNode:TileMapNode!
    var hello:HelloWorldScene!

    init(tileMapNode:TileMapNode, hello:HelloWorldScene){
       self.tileMapNode = tileMapNode
        self.hello = hello
    }
    
    func insertInOpenSteps(step:ShortestPathStep){
        
        let stepFScore = step.calcFScore()
        let count = spOpenSteps.count
        var i = 0
        for ; i<count; i++ {
            if stepFScore <= spOpenSteps[i].calcFScore(){
                break;
            }
        }
        spOpenSteps .insert(step, atIndex: i)
    }
    
    func computeHScore(fromCoord:CGPoint,toCoord:CGPoint)->Int{
        //could be wrong with the cast...
        return abs(Int32(toCoord.x) - Int32(fromCoord.x)) + abs(Int32(toCoord.y) - Int32(fromCoord.y))
    }
    
    func costToMoveFromStep(fromStep:ShortestPathStep, toStep:ShortestPathStep)->Int{
        return 1
    }
    
    func moveToward(target:CGPoint){
        var fromTileCoord:CGPoint = tileMapNode.tileCoordForPosition(tileMapNode.spawnPoint)
        var toTileCoord:CGPoint = tileMapNode.tileCoordForPosition(target)
        
        if CGPointEqualToPoint(fromTileCoord, toTileCoord){
            return
        }
        if tileMapNode.isWallAtTileCoord(toTileCoord){
            println("hit wall")
            return
        }
        //STARTs the A*
        insertInOpenSteps(ShortestPathStep(position: fromTileCoord))
        
        do{
            var currentStep:ShortestPathStep = spOpenSteps.first!
            spClosedSteps.append(currentStep)
        
            spOpenSteps.removeAtIndex(0)
            //if we are there we are done..
            if CGPointEqualToPoint(currentStep.position, toTileCoord) {
                constructPathAndStartAnimation(currentStep)

              //  spOpenSteps = nil
              //  spClosedSteps = nil
                break;
            }
            var adjSteps:Array = tileMapNode.walkableAdjacentTilesCoord(currentStep.position)
            for v in adjSteps {
                var step:ShortestPathStep = ShortestPathStep(position: v.CGPointValue())
                if spClosedSteps.contains(step) {
            
                }
                var moveCost:Int = costToMoveFromStep(currentStep, toStep: step)
                var index = find(spOpenSteps, step)
                
                if index == nil{
                    step.parentStep = currentStep
                    step.gScore = currentStep.gScore + moveCost
                    step.hScore = computeHScore(step.position, toCoord: toTileCoord)
                    insertInOpenSteps(step)
                    
                    //release step?
                    
                }
                else {
                    step = spOpenSteps[index!]
                    if currentStep.gScore + moveCost < step.gScore {
                        step.gScore = currentStep.gScore + moveCost
                        spOpenSteps.removeAtIndex(index!)
                        insertInOpenSteps(step)
                    }
                }
            }
        } while spOpenSteps.count > 0
 
        if shortestPath.count == 0{
            println("noPAth")

        }
    }
    func constructPathAndStartAnimation(var step:ShortestPathStep){
        do{
            if step.parentStep != nil {
                shortestPath.insert(step, atIndex: 0)
            }
            step = step.parentStep
            
        } while step.parentStep != nil //make will miss one step vbecause im llooking at parent...
        
        for s in shortestPath {
            println("\(s)")
            
        }
        //hello.popStepAndAnimate()
    }
    
   /* func popStepAndAnimate() {
        if(shortestPath.count == 0){
            return
        }
        var humanSprite:CCSprite = CCSprite(imageNamed: "Player.png")
        humanSprite.position = tileMapNode.spawnPoint
        var step :ShortestPathStep = shortestPath[0]
        var moveAction = CCActionMoveTo(duration: 0.4, position: tileMapNode.positionForTileCoord(step.position))
        var moveCallback = CCActionCallFunc(target: self, selector: "removeDragSprite:")
        
        
        
        shortestPath.removeAtIndex(0)
        humanSprite.runAction(CCActionSequence(one: moveAction, two: moveCallback))
        tileMapNode.addChild(humanSprite, z: tileMapNode.npcLayer.zOrder)
        
    }
    func removeDragSprite(test:AnyObject){
    }*/

}


