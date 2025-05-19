# Class Player
```matlab
classdef player 
```
## Class Attributes
```matlab
index; % Player's index
score; % Player's score
history; % Empty array Strategies x Rounds
move; % Player's move
```
## Methods
- Constructor
    ```matlab
    function obj = player()
    ```
    Creates a Player.

- Set Score
    ```matlab
    function obj = setScore(obj, roundScore)
    ``` 
    `@ obj`: The player object.

    `@ roundScore`: The score attribute to the player on a specific round.

    `returns obj`: Returns the player object. 

    Sets the Score of the Player by adding a round's score to his total score.

- Get Score
    ```matlab
    function score = getScore(obj)
    ```
    `@ obj`: The player object.

    `returns score`: Returns the player's score.

    Gets the Score of the Player.
    
- Initialize History
    ```matlab
    function obj = initHistory(obj, rounds, numberPlayers)
    ```
    `@ obj`: The player object.

    `@ rounds`: The total rounds of a Tournament.

    `@ numberPlayers`: The total number of players participating in the Tournament.

    `returns obj`: Returns the player object. 

    Initialize the History matrix by establishing the correct dimensions and populating it with zeros.  

- Set History
    ```matlab
    function obj = setHistory(obj, round, opponentIndex, move)
    ```
    `@ obj`: The player object.

    `@ round`: The current round of the Tournament.

    `@ opponentIndex`: The opponents index.

    `returns obj`: Returns the player object. 

    Archive a particular move of the Player inside the History matrix.

- Get History
    ```matlab
    function history = getHistory(obj)
    ```
    `@ obj`: The player object.

    `returns history`: Returns the player's history matrix.

    Gets the Player's History matrix containing his Moves against each Opponent Player in the Tournament. Each column corresponds to the Player's moves against the Opponent whose index is equal to the column number.

- Get History Element
    ```matlab
    function historyElement = getHistoryElement(obj, round, opponentIndex)
    ```
    `@ obj`: The player object.

    `@ round`: The current round of the Tournament.

    `@ opponentIndex`: The opponents index.

    `returns historyElement`: Returns a specific element from the History matrix.
    
    Get a specific element from the Player's History matrix. The column is the opponent's index and the row is the round the move was played.

- Set Index
    ```matlab
    function obj = setIndex(obj, index)
    ```
    `@ index`: The player's index.

    `returns obj`: Returns the player object. 

    Sets the Index of the Player.

- Get Index
    ```matlab
    function index = getIndex(obj)
    ```
    `@ obj`: The player object.

    `returns index`: Returns the player's index.
    .
    Gets the Index of the Player.

- Get Move
    ```matlab
    function move = getMove(obj)
    ```
    `@ obj`: The player object.

    `returns move`: Returns the player's move.

    Gets the Move of the Player.


## Strategies
Individual Strategies are child classes of the parent class Player. They implement a, unique to each strategy, **move()** function and sometimes have additional attributes that enable the way they calculate the move. They are explained in detail inside the *Documentation/strategies/* directory.
