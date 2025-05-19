### Cooperate Class
```matlab
classdef cooperate < player
```
#### Attributes
None
#### Methods
- Constructor
    ```matlab
    function obj = cooperate(~)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants. (Not utilized here)

    `returns obj`: Returns the player object. 

    Creates a **cooperate** player.

- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    `@ obj`: The player object.

    `@ opponentLastMove`: The opponent's last move.

    `@ opponentIndex`: The opponent's index.

    `@ currentRound`: The current round of the Tournament.
 
    `returns obj`: Returns the player object. 

    Always cooperates.