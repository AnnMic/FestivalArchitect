import Foundation


public protocol System {
    func update(dt:Float)
}


public class MacroSystem : System {
    
    private var subSystems:[System] = [System]()
    
    public func addSystem(s:System) {
        subSystems.append(s)
    }
    
    public func update(dt:Float) {
        for s in subSystems {
            s.update(dt)
        }
    }
    
    public init() {
        
    }
}