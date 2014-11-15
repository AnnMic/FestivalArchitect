//
//  AnimateComponent.swift
//  Festival
//
//  Created by Ann Michelsen on 01/10/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation

enum States {
    case QuenchThirst, QuenchHunger, SleepTilRested
}

class AIState : NSObject {
    
    func name() -> String  {
        return "Unknown"
    }
    
    func enter(entity:Entity){ //entity!!!

    }
    func execute(entity:Entity, aiSystem:AISystem){

    }
    func exit(entity:Entity){

    }
}

