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
        println("zzZZzz zzZZ")
        
        var sleep:SleepComponent = entity.component(SleepComponent)!
        sleep.fatigue--
        
        if(sleep.fatigue <= 0){
          //  aiSystem.changeStateForEntity(entity, toState:AIStateSleepTilRested())
        }
    }
    
    override func exit(entity:Entity) {
        println("Not tired anymore time to dance")
        
    }

    
    
}