//
//  UpdateNeedSystem.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 12/11/14.
//  Copyright (c) 2014 AnnMi. All rights reserved.
//

import Foundation




class PhysicalNeedSystem : System { //TODO rename to something better
    
    let environment:Environment
    
    init (env:Environment) {
        environment = env
    }
    
    func update(dt: Float) {
        
        let entites:[Entity] = environment.entitiesWithComponent(AIComponent.self)
        
        if entites.count == 0 {
            return
        }
        for entity in entites {
            
            decreaseVisitorNeeds(entity)
        }
    }
    func decreaseVisitorNeeds(entity:Entity){
        var visitor:PhysicalNeedComponent = entity.component(PhysicalNeedComponent)!
        if visitor.hunger > -100 {
            visitor.hunger--
        }
        if visitor.fatigue > -100 {
            visitor.fatigue--
        }
        if visitor.thirst > -100 {
            visitor.thirst--
        }
        
        println("hunger \(visitor.hunger) thirst \(visitor.thirst) fatigue \(visitor.fatigue)")

    }
}





