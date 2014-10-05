//
//  MoveComponent.swift
//  Festival
//
//  Created by Ann Michelsen on 30/09/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation

class MoveComponent : Component {
    var moveTarget : CGPoint!
    var velocity : CGPoint!
    var acceleration : CGPoint!

    init(moveTarget:CGPoint, acc:CGPoint, velocity:CGPoint) {
        self.moveTarget = moveTarget
        self.acceleration = acc
        self.velocity = velocity

    }
    internal override class func name() -> String {
        return "MoveComponent"
    }
}