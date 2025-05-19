### per_kind Class
```matlab
classdef per_kind < player
```
#### Attributes
```matlab
state = []; % States: 1 -> C, 2 -> C, 3 -> D
```
#### Methods
- Constructor
    ```matlab
    function obj = per_kind(numberOfPlayers)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants.

    `returns obj`: Returns the player object. 
    
    Creates a Periodic Kind player.

- Move
    ```matlab
    function obj = setMove(obj, ~, opponentIndex, ~)
    ```
    `@ obj`: The player object.

    `@ opponentLastMove`: The opponent's last move. (Not utilized here)

    `@ opponentIndex`: The opponent's index.

    `@ currentRound`: The current round of the Tournament. (Not utilized here)
 
    `returns obj`: Returns the player object. 

    Periodically plays cooperate, cooperate, defect.



