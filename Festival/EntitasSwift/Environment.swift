import Foundation


public class Environment {

    private var collectors:[Collector]
    private let entities = NSMutableSet()

    public init () {
        collectors = [Collector]()
    }

    public func createEntity() -> Entity {
        let e = EntityImpl(env:self)
        entities.addObject(e)
        return e
    }

    public func containsEntity(e:Entity) -> Bool {
        return entities.containsObject(e as EntityImpl)
    }

    public func destroyEntity(e:Entity) {
        entities.removeObject(e as EntityImpl)
    }

    public func entitiesWith(ct:Component.Type) -> [Entity] {
        return entitiesWith(All(types:[ct]))
    }


    public func entitiesWith(matcher:Matcher) -> [Entity] {
        var es:[Entity] = [Entity]()
        for a:AnyObject in entities {
            let e = a as EntityImpl
            if matcher.matches(e) {
                es.append(e)
            }
        }
        return es
    }

    public func collectorForEntitiesAdding(ct:Component.Type) -> Collector {
        return self.collectorForEntitiesAdding(All(types:[ct]))
    }

    public func collectorForEntitiesAdding(m:Matcher) -> Collector {
        let collector = CollectorImpl(matcher: m);
        collectors.append(collector)
        return collector
    }


    public func collectorForEntitiesRemoving(ct:Component.Type) -> Collector {
        let collector = CollectorImpl(matcher:All(types:[ct]), observeRemoval: true);
        collectors.append(collector)
        return collector
    }

    internal func entityDidAddComponent(e:Entity, type:String) {
        for collector:Collector in collectors {
            let col = collector as CollectorImpl
            col.entityDidAddComponent(e, type:type)
        }
    }
    
    internal func entityWillRemoveComponent(e:Entity, type:String) {
        for collector:Collector in collectors {
            let col = collector as CollectorImpl
            col.entityWillRemoveComponent(e, type:type)
        }
    }

}
