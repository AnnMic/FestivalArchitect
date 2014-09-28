//
//  EditorPopupViewController.swift
//  Festival
//
//  Created by Ann Michelsen on 28/09/14.
//  Copyright (c) 2014 Ann Michelsen. All rights reserved.
//

import Foundation

class EditorPopupNode : CCNode {
    
    override init()
    {
        super.init()
        let winSize:CGRect = CCDirector.sharedDirector().view.frame
        contentSize = CGSizeMake(50, 50)
        
        // Create a colored background (Dark Grey)
        let background:CCNodeColor = CCNodeColor(color: CCColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0))
        background.contentSize = CGSizeMake(500, 300)
        background.position = CGPoint(x: winSize.width/2-background.contentSize.width/2, y: winSize.height/2-background.contentSize.height/2)
        addChild(background)
        
        createCloseButton()

    }
    func createCloseButton(){
        let close:CCButton = CCButton(title: "X")
        close.position = CGPointMake(500, 300)
        close.setTarget(self, selector: "onCloseClicked:")
        addChild(close)
    }
    func onCloseClicked(sender:CCButton){
        
        
    }
    

}