### mistrust Class
```matlab
classdef mistrust < player
```
#### Attributes
None
#### Methods
- Constructor
    ```matlab
    function obj = mistrust(~)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants. (Not utilized here)

    `returns obj`: Returns the player object. 
    
    Creates a Mistrust player.

- Move
    ```matlab
    function obj = setMove(obj, opponentsLastMove, ~, currentRound)
    ```
    '@ obj': The player object.

    `@ opponentLastMove`: The opponent's last move.

    `@ opponentIndex`: The opponent's index. (Not utilized here)

    `@ currentRound`: The current round of the Tournament.
 
    `returns obj`: Returns the player object. 

    Defects on first move, then play what the opponent played on the previous move.

