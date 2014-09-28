import Foundation


public protocol System {
    func execute()
}


public class MacroSystem : System {
    
    private var subSystems:[System] = [System]()
    
    public func addSystem(s:System) {
        subSystems.append(s)
    }
    
    public func execute() {
        for s in subSystems {
            s.execute()
        }
    }
    
    public init() {
        
    }
}