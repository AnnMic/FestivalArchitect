//
//  HealthComponent.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 11/11/14.
//  Copyright (c) 2014 AnnMi. All rights reserved.
//

import Foundation

class HungerComponent : Component {
    var hungry:Int = 0
    
    init(hunger:Int) {
        self.hungry = hunger
        
    }
    internal override class func name() -> String {
        return "HungerComponent"
    }
    
    
}