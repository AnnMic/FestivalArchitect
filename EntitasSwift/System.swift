import Foundation


public protocol System {
    func execute(dt:Float)
}


public class MacroSystem : System {
    
    private var subSystems:[System] = [System]()
    
    public func addSystem(s:System) {
        subSystems.append(s)
    }
    
    public func execute(dt:Float) {
        for s in subSystems {
            s.execute(dt)
        }
    }
    
    public init() {
        
    }
}