//
//  AStarStep.swift
//  FestivalArchitect
//
//  Created by Ann Michelsen on 05/10/14.
//  Copyright (c) 2014 whackylabs. All rights reserved.
//

import Foundation

class ShortestPathStep : NSObject {
    var position : CGPoint!
    var gScore: Int = 0
    var hScore: Int = 0
    var parentStep : ShortestPathStep!
    
    init(position:CGPoint) {
        super.init()
        self.position = position
        parentStep = nil
    }
    func description()->String{
        return "pos=\(position) g=\(gScore) h= \(hScore) f= \(calcFScore())"
    }
    
    func calcFScore()-> Int{
        return gScore + hScore
    }
    
    func isStepEqual(other:ShortestPathStep)->Bool{
        return CGPointEqualToPoint(self.position, other.position)
    }
    
}