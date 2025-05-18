### pavlov Class
```matlab
classdef pavlov < player
```
#### Attributes
```matlab
previousMove = []; % Store the previous move of the player  
```
#### Methods
- Constructor
    ```matlab
    function obj = pavlov(numberOfPlayers)
    ```
    Creates a Pavlov player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove, opponentIndex, currentRound)
    ```
    Cooperates on the first move, then cooperates only if the two players made the same move.
