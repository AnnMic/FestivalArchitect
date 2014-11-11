//
//  ThirstComponent.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 11/11/14.
//  Copyright (c) 2014 AnnMi. All rights reserved.
//

import Foundation

class ThirstComponent : Component {
    var thirst:Int = 0
    
    init(thirst:Int) {
        self.thirst = thirst
        
    }
    internal override class func name() -> String {
        return "ThirstComponent"
    }
    
    
}