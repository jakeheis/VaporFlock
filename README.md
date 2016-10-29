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
extension Config {
    public static var outputLog = "/dev/null"
    public static var errorLog = "/dev/null"
}
```
# Tasks
```bash
flock vapor:stop     # Hooks .before("deploy:link")
flock vapor:start    # Hooks .after("deploy:link")
flock vapor:ps
```
`VaporFlock` hooks into the deploy process to automatically restart the server after the new release is built, so you should never have to call these tasks directly.
