//
//  AISystem.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 11/11/14.
//  Copyright (c) 2014 AnnMi. All rights reserved.
//

import Foundation


class AISystem : System {
    
    let environment:Environment
    
    init (env:Environment) {
        environment = env
    }
    
    func changeStateForEntity(entity:Entity){
        var ai:AIComponent = entity.component(AIComponent)!
        ai.currentState.exit(entity)
        var toState:AIState = findMostNeeded(entity)
        ai.currentState = toState
        toState.enter(entity)
    }
    
    func findMostNeeded(entity:Entity)-> AIState {
        //TODO Redo this must be a much better and nicer way of doing this, not good if many states..
        var visitor:PhysicalNeedComponent = entity.component(PhysicalNeedComponent)!

        var smallest : Int = 100
        var nextState : AIState = AIState()
        
        if visitor.fatigue < smallest {
            smallest = visitor.fatigue
            nextState = AIStateSleepTilRested()
        }
        if visitor.hunger < smallest {
            smallest = visitor.hunger
            nextState = AIStateQuenchHunger()
        }
        if visitor.thirst < smallest {
            smallest = visitor.hunger
            nextState = AIStateQuenchThirsty()
        }
        
        return nextState
    }
    
    
    func update(dt: Float) { // update
        
        let entites:[Entity] = environment.entitiesWithComponent(AIComponent.self)
        
        if entites.count == 0 {
            return
        }
        for entity in entites {
            
            var ai:AIComponent = entity.component(AIComponent)!
            ai.currentState.execute(entity, aiSystem: self) // pop list instead
            
        }
    }
}





