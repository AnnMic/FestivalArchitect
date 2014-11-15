//
//  AIStateThirsty.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 11/11/14.
//  Copyright (c) 2014 AnnMi. All rights reserved.
//

import Foundation


class AIStateQuenchThirsty : AIState {

    override func name() -> String {
        return "QuenchThirst"
    }
    
    override func enter(entity:Entity) {
        //   if(visitor.location.x != 20) { // TODO FIX THIS
        println("Buying a drink")
        
        //  }
        //  miner.changeLocation()
        
        
    }
    
    override func execute(entity:Entity, aiSystem:AISystem) {
        println("Drinking someting")
        
        var render:RenderComponent = entity.component(RenderComponent)!
        render.sprite.color = CCColor.purpleColor()
        
        
        var visitor:PhysicalNeedComponent = entity.component(PhysicalNeedComponent)!
        if visitor.thirst < 50 {
            visitor.thirst += 50
        }
        else{
            visitor.thirst = 100
        }
        
        aiSystem.changeStateForEntity(entity)
    }
    
    override func exit(entity:Entity) {
        println("Not thirsty anymore! :)")
        
    }

    
}