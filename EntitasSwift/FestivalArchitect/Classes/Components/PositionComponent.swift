//
//  Speed.swift
//  FestivalTycoon
//
//  Created by Ann Michelsen on 25/09/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation

class PositionComponent : Component  {
    var x : CGFloat!
    var y : CGFloat!
    
    var moveTarget : CGPoint!

    init (x : CGFloat, y : CGFloat) {
        self.x = x
        self.y = y
    }
    
    init (position : CGPoint) {
        self.x = position.x
        self.y = position.y
    }
    init(moveTarget:CGPoint) {
        self.moveTarget = moveTarget
    }
    internal override class func name() -> String {
        return "PositionComponent"
    }
}