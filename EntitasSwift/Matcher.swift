//
//  Matcher.swift
//  EntitasSwift
//
//  Created by Arne Schroppe on 28/06/14.
//  Copyright (c) 2014 Entitas. All rights reserved.
//

import Foundation



public class Matcher {
    
    private let types:ComponentTypeSet
    
    public init(types:[Component.Type]) {
        self.types = ComponentTypeSet()
        
        for type in types {
            let name = type.name()
            self.types[name] = ()
        }
    }
    
    public func matches(e:Entity) -> Bool {
        let ei = e as EntityImpl
        return self.matchesComponentTypes( ei.components )
    }
    
    internal func matchesComponentTypes<V>(ct:[ComponentName:V]) -> Bool {
        assert(false, "Must override Matcher.matches")
        return false
    }
}



public class All : Matcher  {
    
    override public init(types:[Component.Type]) {
        super.init(types: types)
    }
    
    override public func matchesComponentTypes<V>(ct:[ComponentName:V]) -> Bool {

        //TODO we could improve the speed of this by using automatically generated bitfields for all component types
        for (compName:ComponentName, _) in types {
            if ct.indexForKey(compName) == nil {
                return false
            }
        }
        
        return true
    }
}

public class Any : Matcher {
    
    override public init(types:[Component.Type]) {
        super.init(types: types)
    }
    
    override public func matchesComponentTypes<V>(ct:[ComponentName:V]) -> Bool {

        for (compName:ComponentName, _) in types {
            if ct.indexForKey(compName) != nil {
                return true
            }
        }
        
        return false

    }
}
