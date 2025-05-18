### soft_majo Class
```matlab
classdef soft_majo < player
```
#### Attributes
```matlab
opponentsMovecount = []; % Per opponent, number of coops and defects
```
#### Methods
- Constructor
    ```matlab
    function obj = soft_majo(numberOfPlayers)
    ```
    Creates a Soft Majority player.

- Move
    ```matlab
    function obj = setMove(obj,opponentLastMove, opponentIndex, currentRound)
    ```
    Plays the opponent's most played move, cooperates in case of equality.

