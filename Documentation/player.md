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
    Sets the Score of the Player.

- Get Score
    ```matlab
    function score = getScore(obj)
    ```
    Gets the Score of the Player.
    
- Initialize History
    ```matlab
    function obj = initHistory(obj, rounds, numberPlayers)
    ```
    Initialize the History matrix by establishing the correct dimensions and populating it with zeros.  

- Set History
    ```matlab
    function obj = setHistory(obj, round, opponentIndex, move)
    ```
    Archive a particular move of the Player inside the History matrix.

- Get History
    ```matlab
    function history = getHistory(obj)
    ```
    Gets the Player's History matrix containing his Moves against each Opponent Player in the Tournament. Each column corresponds to the Player's moves against the Opponent whose index is equal to the column number.

- Get History Element
    ```matlab
    function history = getHistoryElement(obj, round, opponentIndex)
    ```
    Get a specific element from the Player's History matrix. The column is the opponent's index and the row is the round the move was played.

- Set Index
    ```matlab
    function obj = setIndex(obj, index)
    ```
    Sets the Index of the Player.

- Get Index
    ```matlab
    function index = getIndex(obj)
    ```
    Gets the Index of the Player.

- Get Move
    ```matlab
    function move = getMove(obj)
    ```
    Gets the Move of the Player.


## Strategies
Individual Strategies are child classes of the parent class Player. They implement a, unique to each strategy, **move()** function and sometimes have additional attributes that enable the way they calculate the move. They are explained in detail inside the *Documentation/strategies/* directory.
