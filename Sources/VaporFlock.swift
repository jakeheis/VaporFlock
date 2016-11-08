import Flock

public extension Flock {
    static let Vapor: [Task] = SystemdTasks(provider: VaporSystemd()).createTasks()
}

class VaporSystemd: SystemdProvider {
    let name = "vapor"
    let serviceName = "vapor"
}
