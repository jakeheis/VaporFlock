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

Flock.use(Flock.Deploy)
Flock.use(Flock.Vapor)
// Remove `Flock.use(Flock.Server)`
```
# Tasks
```bash
flock vapor:restart  # Hooks .after("deploy:link")
flock vapor:stop
flock vapor:start
flock vapor:status
```
`VaporFlock` hooks into the deploy process to automatically restart the server after the new release is built, so you should never have to call these tasks directly.
