//
//  Move.swift
//  FestivalTycoon
//
//  Created by Ann Michelsen on 25/09/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation

class MoveSystem : System {
    
    let environment:Environment
    init (env:Environment) {
        environment = env
    }
    
    func execute() {
        //      var set = NSSet(objects: SpeedComponent.self, PositionComponent.self)
        //let matcher = ESMatcher.allOfSet(set)

        let matcher = All(types:[SpeedComponent.self, PositionComponent.self, SpriteComponent.self])

        let movable:[Entity] = environment.entitiesWith(matcher)
        
        for entity in movable {
            let oldPosition = entity.component(PositionComponent)!
            let speed = entity.component(SpeedComponent)!
            let newPosition = PositionComponent(x: oldPosition.x + speed.velocityX, y: oldPosition.y)
            entity.setComponent(newPosition, overwrite: true)
            
            let spriteComponent = entity.component(SpriteComponent)!
            spriteComponent.sprite.position = CGPointMake(newPosition.x, newPosition.y)
            
        }
    }
}