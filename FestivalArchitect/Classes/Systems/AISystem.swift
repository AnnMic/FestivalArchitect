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
    
    func changeStateForEntity(entity:Entity, toState:AIState){
        var ai:AIComponent = entity.component(AIComponent)!
        ai.currentState.exit(entity)
        ai.currentState = toState
        toState.enter(entity)
    
        
    }
    
    func update(dt: Float) { // update

        let entites:[Entity] = environment.entitiesWithComponent(AIComponent.self)
        
        if entites.count == 0 {
            return
        }
        for entity in entites {

            var ai:AIComponent = entity.component(AIComponent)!
            
            ai.currentState.execute(entity, aiSystem: self)
            
        }
    }
    
    
    
    
  /*  func update(dt: Float) { // update
        
        let entites:[Entity] = environment.entitiesWithComponent(AIComponent.self)

        if entites.count == 0 {
            return
        }
        
        var aiEntity:Entity = entites[0]
       // var aiComponent:AIComponent = aiEntity.ai
        
    }
    func changeStateForEntity(entity:Entity, toState:AIState){
        
        
    }*/
    
}