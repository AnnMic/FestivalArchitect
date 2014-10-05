//
//  Speed.swift
//  FestivalTycoon
//
//  Created by Ann Michelsen on 25/09/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation

class SpeedComponent : Component {
    let velocityX : CGFloat
    let velocityY : CGFloat

    init (velocityX : CGFloat, velocityY : CGFloat) {
        self.velocityX = velocityX
        self.velocityY = velocityY

    }
    internal override class func name() -> String {
        return "SpeedComponent"
    }
   
}