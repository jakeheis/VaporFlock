import Flock

public extension Flock {
    static let Vapor: [Task] = SupervisordTasks(provider: VaporSupervisord()).createTasks()
}

class VaporSupervisord: SupervisordProvider {
    let taskNamespace = "vapor"
    let supervisordName = Config.supervisordName ?? "vapor"
    
    func confFile(for server: Server) -> SupervisordConfFile {
        var file = SupervisordConfFile(programName: supervisorCtlName)
        file.command += " --env=\(Config.environment)"
        return file
    }
    
}
