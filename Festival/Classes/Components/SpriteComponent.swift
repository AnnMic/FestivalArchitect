//
//  SpriteComponent.swift
//  FestivalTycoon
//
//  Created by Ann Michelsen on 25/09/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation

class SpriteComponent : Component {
    let sprite : CCSprite
    
    init (fileName : NSString, spawnPosition : CGPoint) {
        sprite = CCSprite(imageNamed: fileName)
        sprite.position = spawnPosition
    }
    
    init (sprite : CCSprite) {
        self.sprite = sprite
        sprite.position = CGPointMake(200, 100)
    }
    internal override class func name() -> String {
        return "SpriteComponent"
    }
}
