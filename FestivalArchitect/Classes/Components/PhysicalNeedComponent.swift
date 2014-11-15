//
//  VisitorComponent.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 12/11/14.
//  Copyright (c) 2014 AnnMi. All rights reserved.
//

import Foundation


class PhysicalNeedComponent : Component {
    var fatigue:Int = 0
    var thirst:Int = 0
    var hunger:Int = 0

    //hygiene
    
    //mental stuff
        //fun
        //social
    
    //personality 
        //shy
        //sloppy
        //active
    
    init(fatigue:Int, thirst:Int, hunger:Int) {
        self.fatigue = fatigue
        self.thirst = thirst
        self.hunger = hunger
    }
    
    internal override class func name() -> String {
        return "PhysicalNeedComponent"
    }
}