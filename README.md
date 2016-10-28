# VaporFlock

Automated deployment of your [Vapor](https://github.com/vapor/vapor) server using [Flock](https://github.com/jakeheis/Flock).

## Installation
Add these lines to `deploy/FlockDependencies.json`:
```
"dependencies" : [
  ...
  {
    "name" : "https://github.com/jakeheis/VaporFlock",
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
## Included tasks
```
vapor:stop # Hooks .before("deploy:link")
vapor:start # Hooks .after("deploy:link")
vapor:process
```
