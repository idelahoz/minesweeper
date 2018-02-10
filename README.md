* The api has 2 endpoints: a post to `games` which creates a new game and post to `games/move` which will play a move. 
* The call `games/move` will do the move on the last created game and ir receives a point params of the form `{x: 1, y: 1}`
* both calls return the game in the form: 
```
{
  "game": {
    "id": 2,
    "over": false,
    "warnings": [
      {
        "x": 1,
        "y": 1,
        "number": 2
      }
    ],
    "revealed": []
  }
}
```
* when the game is over the `games/move` call will return `over` as false and also return an array with the mines.
* all info is stored on the db which makes most of the job for the next tasks about persistence(I didn't get there).
* the app is hosted at https://minesweeperihoz.herokuapp.com/. there's no index page but the endpoints mentioned above will work:


[minesweeperihoz.herokuapp.com/games?format=json](https://minesweeperihoz.herokuapp.com/games?format=json)

and

[minesweeperihoz.herokuapp.com/games/move?format=json&point[x]=6&point[y]=6](https://minesweeperihoz.herokuapp.com/games/move?format=json&point[x]=6&point[y]=6)


for example

* For the move feature I code the PlayMove services first calling non-existent methods from game. I this is the higher level method in the feature(after the controller method) so I wanted it to be pretty simple. Then I implemented what was needed from Game.
* Game is a fat model. All logic can be extracted into a service object or maybe a decorator.
