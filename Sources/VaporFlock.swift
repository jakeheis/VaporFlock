import Flock
import Foundation

public extension Flock {
    static let Vapor: [Task] = [
        StopTask(),
        StartTask(),
        PsTask()
    ]
}

public extension Config {
    static var outputLog = "/dev/null"
    static var errorLog = "/dev/null"
}

let vapor = "vapor"

public class StopTask: Task {
    public let name = "stop"
    public let namespace = vapor
    public let hookTimes: [HookTime] = [.before("deploy:link")]
    
    public func run(on server: Server) throws {
        if let pid = try findServerPid(on: server) {
            try server.execute("kill -9 \(pid)")
        } else {
            print("Vapor not running")
        }
    }
}

public class StartTask: Task {
    public let name = "start"
    public let namespace = vapor
    public let hookTimes: [HookTime] = [.after("deploy:link")]
    
    public func run(on server: Server) throws {
        print("Starting Vapor")
        try server.execute("nohup \(Paths.executable) >> \(Config.outputLog) 2>> \(Config.errorLog) &")
        try invoke("vapor:ps")
    }
}

public class PsTask: Task {
    public let name = "ps"
    public let namespace = vapor
    
    public func run(on server: Server) throws {
        if let pid = try findServerPid(on: server) {
            print("Vapor running as process \(pid)")
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
