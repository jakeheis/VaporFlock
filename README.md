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

## Included tasks
```
vapor:stop
vapor:start
vapor:list
```
