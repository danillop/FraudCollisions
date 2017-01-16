# FraudCollisions
Solution that detects network collisions.

The solution is composed by:

  * CollisionDetecter(apps/collision_detecter) - An Elixir application that detect network collisions.
  * Api(apps/api) - An Phoenix application that uses the CollisionDetecter and provides endpoints to detect network collisions.

## Getting started
  * Install dependencies with `mix deps.get`
  * Go to apps/api and start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### API

GET http://localhost:4000/api/networkcollisions
Get the result of the collisions detection in the collisions.txt file.
```r
curl -i -H "Accept: application/json" -H "Content-Type: Application/json" -X GET http://localhost:4000/api/networkcollisions

{"collision_result":{"message":"Collisions detected","count":2,"collisions":[["1","2","3","4"],["5","6","7"]]}}%
```

POST http://localhost:4000/api/networkcollisions
Add a new collision between two nodes.
Params: node_a, node_b
```r
curl -i --data "node_a=90&node_b=100"  http://localhost:4000/api/networkcollisions

{"message":"Collision added: 90 100"}%
```

GET http://localhost:4000/api/networkcollisions/:node_a/:node_b
Answer if two nodes belong to the same collision network.
```r
curl -i -H "Accept: application/json" -H "Content-Type: Application/json" -X GET http://localhost:4000/api/networkcollisions/1/4

{"inSameCollisionNetwork":true}%
```
