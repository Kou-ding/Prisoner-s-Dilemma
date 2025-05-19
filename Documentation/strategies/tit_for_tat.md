### TitForTat Class
```matlab
classdef tit_for_tat < player
```
#### Attributes
None
#### Methods
- Constructor
    ```matlab
    function obj = tit_for_tat(~)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants. (Not utilized here)

    `returns obj`: Returns the player object. 
    
    Creates a TitForTat player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove, ~, currentRound)
    ```
    '@ obj': The player object.

    `@ opponentLastMove`: The opponent's last move.

    `@ opponentIndex`: The opponent's index. (Not utilized here)

    `@ currentRound`: The current round of the Tournament.
 
    `returns obj`: Returns the player object. 

    First cooperate, afterwards copy your opponent's last move.