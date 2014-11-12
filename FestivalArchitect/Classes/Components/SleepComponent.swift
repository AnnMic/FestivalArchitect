//
//  SleepComponent.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 11/11/14.
//  Copyright (c) 2014 AnnMi. All rights reserved.
//

import Foundation

class SleepComponent : Component {
    var fatigue:Int = 0
    
    init(fatigue:Int) {
        self.fatigue = fatigue
        
    }
    internal override class func name() -> String {
        return "SleepComponent"
    }
    
    
}