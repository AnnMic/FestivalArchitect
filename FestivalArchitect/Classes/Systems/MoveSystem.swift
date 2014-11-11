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
    
    func update(dt:Float) {
        let matcher = All(types:[MoveComponent.self, RenderComponent.self])
        
        let movable:[Entity] = environment.entitiesMatching(matcher)
        
        for entity in movable {
            
            let move = entity.component(MoveComponent)!
            let render = entity.component(RenderComponent)!
            
            var newPosition = ccpAdd(render.sprite.position, ccpMult(move.velocity, CGFloat(dt)))
            let winSize = CCDirector.sharedDirector().view.frame
            newPosition.x = max(min(newPosition.x, winSize.width), 0)
            newPosition.y = max(min(newPosition.y, winSize.height), 0)
            render.sprite.position = newPosition
            
            //  entity.setComponent(newPosition, overwrite: true)
            
        }
    }
    
}
