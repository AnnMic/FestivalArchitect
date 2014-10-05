//
//  SpriteComponent.swift
//  FestivalTycoon
//
//  Created by Ann Michelsen on 25/09/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation

class RenderComponent : Component {
    let sprite : CCSprite
    
    init (fileName : NSString, spawnPosition : CGPoint) {
        sprite = CCSprite(imageNamed: fileName)
        sprite.position = spawnPosition
    }
    
    init (sprite : CCSprite, spawnPosition : CGPoint) {
        self.sprite = sprite
        sprite.position = spawnPosition
    }
    internal override class func name() -> String {
        return "SpriteComponent"
    }
}
