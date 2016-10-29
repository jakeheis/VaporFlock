# VaporFlock

Automated deployment of your [Vapor](https://github.com/vapor/vapor) server using [Flock](https://github.com/jakeheis/Flock).

# Installation
Add these lines to `config/deploy/FlockDependencies.json`:
```
"dependencies" : [
       ...
       {
           "url" : "https://github.com/jakeheis/VaporFlock",
           "version": "0.0.1"
       }
]
```
In your `Flockfile` add:
```swift
import Flock
import VaporFlock

...

Flock.use(Flock.Vapor)
```
# Config
These fields are open for customization in your `config/deploy/Always.swift` and related configuration files:
```swift
public extension Config {
    static var outputLog = "/dev/null"
    static var errorLog = "/dev/null"
}
```
If you set these variable to anything other than `/dev/null`, you'll likely want to turn off stdout bufferring to ensure log files are properly written to:
```swift
// Sources/App/main.swift

#if os(Linux)
import Glibc
#else
import Darwin
#endif
import Vapor

setbuf(stdout, nil)

let drop = Droplet()
...
```
# Tasks
```bash
flock vapor:stop     # Hooks .before("deploy:link")
flock vapor:start    # Hooks .after("deploy:link")
flock vapor:ps
```
`VaporFlock` hooks into the deploy process to automatically restart the server after the new release is built, so you should never have to call these tasks directly.
