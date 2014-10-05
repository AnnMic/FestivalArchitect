import Foundation


public protocol Collector {
    func drain() -> [Entity]
}


internal class CollectorImpl : Collector {
    
    private var entities:[Entity]
    private let matcher:Matcher
    private let observeRemoval:Bool;
    
    init(matcher:Matcher, observeRemoval:Bool = false) {
        self.matcher = matcher
        self.observeRemoval = observeRemoval
        self.entities = [Entity]()
    }
    
    
    internal func entityDidAddComponent(e:Entity, type:String) {
        if observeRemoval || containsEntity(e) {
            return
        }
        
        let ei = e as EntityImpl
        var oldComponents = ei.components
        oldComponents.removeValueForKey(type)

        
        if !matcher.matchesComponentTypes(oldComponents) && matcher.matches(e) {
            entities.append(e)
        }
    }
    
    internal func entityWillRemoveComponent(e:Entity, type:String) {
        if !observeRemoval || containsEntity(e) {
            return
        }
        
        let ei = e as EntityImpl
        var newComponents = ei.components
        newComponents.removeValueForKey(type)
        
        if matcher.matches(e) && !matcher.matchesComponentTypes(newComponents) {
            entities.append(e)
        }
    }
    
    internal func containsEntity(e:Entity) -> Bool {
        return contains(entities,
            { ($0 as EntityImpl) === (e as EntityImpl) })
    }


    internal func drain() -> [Entity] {
        let entitiesForNow = self.entities
        self.entities = [Entity]()
        return entitiesForNow
    }
    
}