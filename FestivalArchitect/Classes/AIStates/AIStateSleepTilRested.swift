//
//  AIStateSleepTilRested.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 11/11/14.
//  Copyright (c) 2014 AnnMi. All rights reserved.
//

import Foundation

class AIStateSleepTilRested : AIState {
    
    override func name() -> String {
        return "SleepTilRested"
    }
    
    
    override func enter(entity:Entity) {
        println("found the bed, time to sleep")
    
    }
    
    override func execute(entity:Entity, aiSystem:AISystem) {
       // println("zzZZzz zzZZ")
        
        var render:RenderComponent = entity.component(RenderComponent)!
        render.sprite.color = CCColor.whiteColor()
        
        var visitor:PhysicalNeedComponent = entity.component(PhysicalNeedComponent)!
        if visitor.fatigue < 90 {
            visitor.fatigue += 10
        }
        else{
            visitor.fatigue = 100
            aiSystem.changeStateForEntity(entity)

        }
    }
    
    override func exit(entity:Entity) {
        println("Not tired anymore time to dance")
        
    }
}



