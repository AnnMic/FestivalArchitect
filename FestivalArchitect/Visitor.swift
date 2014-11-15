//
//  Visitor.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 11/11/14.
//  Copyright (c) 2014 AnnMi. All rights reserved.
//

import Foundation


class Visitor : NSObject {
    var currentState:AIState
    var coins:Int = 0
    var thirsty:Int = 0
    var hungry:Int = 0
    var fatigue:Int = 0
    var location:CGPoint!
    
  
    init(currentState:AIState) {
        self.currentState = currentState
    }
  /*
    func changeState(newState:AIState){
        currentState.exit(self)
        currentState = newState
        newState.enter(self)
        
    }
    
    func update(dt: Float) { // update
        thirsty++
        
        currentState.execute(self)
    }
    */
}
