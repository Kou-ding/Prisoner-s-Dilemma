### Random Class
```matlab
classdef random < player
```
#### Attributes
None
#### Methods
- Constructor
    ```matlab
    function obj = random(~)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants. (Not utilized here)

    `returns obj`: Returns the player object. 
    
    Creates a Random player.

- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    `@ obj`: The player object.

    `@ opponentLastMove`: The opponent's last move. (Not utilized here)

    `@ opponentIndex`: The opponent's index. (Not utilized here)

    `@ currentround`: The current round of the Tournament. (Not utilized here)
 
    `returns obj`: Returns the player object. 

    Makes a random move.