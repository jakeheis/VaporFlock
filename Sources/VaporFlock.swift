import Foundation
import Flock

extension Flock {
    public static let Vapor = VaporCluster()
}

public class VaporCluster: Cluster {
    public let name = "vapor"
    public let tasks: [Task] = [
        Stop(),
        Start(),
        List()
    ]
}

public class Stop: ScheduledTask {
    public let name = "stop"
    public let scheduledTimes: [ScheduleTime] = [.before("deploy:build")]
    
    public func run(on server: Server) throws {
        if let pid = try findServerPid(on: server) {
            try server.execute("kill -9 \(pid)")
        } else {
            print("Vapor not running")
        }
    }
}

public class Start: ScheduledTask {
    public let name = "start"
    public let scheduledTimes: [ScheduleTime] = [.after("deploy:build")]
    
    public func run(on server: Server) throws {
        print("Starting Vapor")
        try server.execute("\(Paths.executable)")
    }
}

public class List: ScheduledTask {
    public let name = "list"
    public let scheduledTimes: [ScheduleTime] = [.after("vapor:start")]
    
    public func run(on server: Server) throws {
        
        if let pid = try findServerPid(on: server) {
            print("Vapor running on \(pid)")
        } else {
            print("Vapor not running")
        }
    }
}

private func findServerPid(on server: Server) throws -> String? {
    guard let processes = try server.capture("ps aux | grep \".build\"") else {
        return nil
    }
    
    let lines = processes.components(separatedBy: "\n")
    for line in lines where !line.contains("grep") {
        let segments = line.components(separatedBy: " ").filter { !$0.isEmpty }
        if segments.count > 1 {
            return segments[1]
        }
        return segments.count > 1 ? segments[1] : nil
    }
    return nil
}
