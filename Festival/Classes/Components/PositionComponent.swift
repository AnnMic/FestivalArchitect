//
//  Speed.swift
//  FestivalTycoon
//
//  Created by Ann Michelsen on 25/09/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation

class PositionComponent : Component  {
    let x : CGFloat
    let y : CGFloat

    init (x : CGFloat, y : CGFloat) {
        self.x = x
        self.y = y
    }
    init (position : CGPoint) {
        self.x = position.x
        self.y = position.y
    }
    internal override class func name() -> String {
        return "PositionComponent"
    }
}