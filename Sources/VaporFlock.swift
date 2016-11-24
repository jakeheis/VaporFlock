import Flock

public extension Flock {
    static let Vapor: [Task] = SupervisordTasks(provider: VaporSupervisord()).createTasks()
}

class VaporSupervisord: SupervisordProvider {
    let name = "vapor"
    let programName = "vapor"
}
