### per_CD Class
```matlab
classdef per_cd < player
```
#### Attributes
```matlab
state = []; % States: 0 -> at start or after D, 1 -> after C
```
#### Methods
- Constructor
    ```matlab
    function obj = per_cd(numberOfPlayers)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants.

    `returns obj`: Returns the player object. 
    
    Creates a Periodic Cooperate Defect player.

- Move
    ```matlab
    function obj = setMove(obj, ~, opponentIndex, ~)
    ```
    `@ obj`: The player object.

    `@ opponentLastMove`: The opponent's last move. (Not utilized here)

    `@ opponentIndex`: The opponent's index.

    `@ currentRound`: The current round of the Tournament. (Not utilized here)
 
    `returns obj`: Returns the player object. 

    Periodically plays cooperate, defect.
