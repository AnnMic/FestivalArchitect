import Foundation

public typealias ComponentName = String
public typealias ComponentTypeSet = Dictionary<ComponentName, Void>



public class Component {
    public class func name() -> String {
        assert(false, "Must override `class func name()`")
        return ""
    }
    
    public init() {
        
    }
}



public protocol Entity {
    func setComponent<C: Component>(c:C)
    func setComponent<C: Component>(c:C, overwrite:Bool)
    func component<C: Component>(ct:C.Type) -> C?
    func removeComponent<C: Component>(ct:C.Type)
}



internal class EntityImpl : Entity {
    
    private let environment:Environment
    
    private var _components:[String:Component]
    internal var components:[String:Component]
    {
        get {
            return _components
        }
    }
    
    internal init (env:Environment) {
        environment = env
        _components = [:]
    }
    
 
    
    internal func setComponent<C: Component>(c:C) {
        self.setComponent(c, overwrite:false)
    }
    
    internal func setComponent<C: Component>(c:C, overwrite:Bool) {
        let componentName = c.dynamicType.name()
        
        if components[componentName] === c {
            return
        }
        
        if self.component(c.dynamicType) != nil && !overwrite {
            let exp = NSException(name: NSInvalidArgumentException, reason: "Illegal overwrite error", userInfo: nil)
            exp.raise()
        }
        
        if overwrite {
            self.removeComponent(c.dynamicType)
        }
        
        _components[componentName] = c;
        environment.entityDidAddComponent(self, type:componentName)
    }
    
    internal func component<C: Component>(ct:C.Type) -> C? {
        if let c = components[ct.name()] {
            return c as? C
        }
        return nil
    }
    
    internal func removeComponent<C: Component>(ct:C.Type) {
        let componentName = ct.name()
        if components.indexForKey(componentName) == nil {
            return
        }
        
        environment.entityWillRemoveComponent(self, type:componentName)
        _components.removeValueForKey(componentName)
    }
    
}

public func isIdentical(a:Entity, b:Entity) -> Bool
{
    return (a as EntityImpl) === (b as EntityImpl)
}
