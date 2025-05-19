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
    `@ numberOfPlayers`: The Tournament's total number of participants.
    
    `returns obj`: Returns the player object. 
    
    Creates a Pavlov player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove, opponentIndex, currentRound)
    ```
    '@ obj': The player object.

    `@ opponentLastMove`: The opponent's last move.

    `@ opponentIndex`: The opponent's index.

    `@ currentRound`: The current round of the Tournament.
 
    `returns obj`: Returns the player object. 

    Cooperates on the first move, then cooperates only if the two players made the same move.
