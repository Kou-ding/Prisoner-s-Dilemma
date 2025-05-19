### Defect Class
```matlab
classdef defect < player
```
#### Attributes
None
#### Methods
- Constructor
    ```matlab
    function obj = defect(~)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants. (Not utilized here)

    `returns obj`: Returns the player object. 
    
    Creates a **defect** player.

- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    '@ obj': The player object.

    `@ opponentLastMove`: The opponent's last move. (Not utilized here)

    `@ opponentIndex`: The opponent's index. (Not utilized here)

    `@ currentRound`: The current round of the Tournament. (Not utilized here)
 
    `returns obj`: Returns the player object. 

    Always defects.