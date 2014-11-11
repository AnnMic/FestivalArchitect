//
//  AnimateComponent.swift
//  Festival
//
//  Created by Ann Michelsen on 01/10/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation

class AIComponent : Component {
    var currentState:AIState


    init(currentState:AIState) {
         self.currentState = currentState
    }

    
    func stateName()->String {
        return currentState.name()
    }

   internal override class func name() -> String {
        return "AIComponent"
    }
    

}
