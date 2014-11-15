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

        //remove money?
        
        var render:RenderComponent = entity.component(RenderComponent)!
        render.sprite.color = CCColor.yellowColor()
        
        
        var visitor:PhysicalNeedComponent = entity.component(PhysicalNeedComponent)!
        if visitor.hunger < 70 {
            visitor.hunger += 30
        }
        else{
            visitor.hunger = 100
        }
        
        aiSystem.changeStateForEntity(entity)
    }
    
    override func exit(entity:Entity) {
        println("Not hungry anymore! :)")
 
    }
    
}
