//
//  AnimateComponent.swift
//  Festival
//
//  Created by Ann Michelsen on 01/10/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation

class AIStateQuenchHunger : AIState {

    
    
    override func name() -> String {
        return "QuenchHunger"
    }
    
    override func enter(entity:Entity) {
        println("Buying a Döööner")
    }
    
    override func execute(entity:Entity, aiSystem:AISystem) {
        println("Eating someting")

        var hunger:HungerComponent = entity.component(HungerComponent)!
        hunger.hungry--
        
        if(hunger.hungry <= 0){
            aiSystem.changeStateForEntity(entity, toState:AIStateQuenchThirsty())
        }
    }
    
    override func exit(entity:Entity) {
        println("Not hungry anymore! :)")
 
    }
    
}
