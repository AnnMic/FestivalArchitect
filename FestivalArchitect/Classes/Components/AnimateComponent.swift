//
//  AnimateComponent.swift
//  Festival
//
//  Created by Ann Michelsen on 01/10/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation

class AnimateComponent : Component {
    
    init(moveTarget:CGPoint, sprite:CCSprite) {
        //var moveAction:CCAction = CCActionMoveTo(duration: 10, position: moveTarget)

      //  sprite.runAction(moveAction)
        
    }
    
   internal override class func name() -> String {
        return "AnimateComponent"
    }
    

}
