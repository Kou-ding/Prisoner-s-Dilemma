### per_ccccd Class
```matlab
classdef per_ccccd < player
```
#### Attributes
```matlab
state = []; % per-opponent array of the player's current state number
```
#### Methods
- Constructor
    ```matlab
    function obj = per_ccccd(numberOfPlayers)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants.

    `returns obj`: Returns the player object. 
    
    Creates a Periodic Cooperate Cooperate Cooperate Cooperate Defect player.

- Move
    ```matlab
    function obj = setMove(obj, ~, opponentIndex, ~)
    ```
    `@ obj`: The player object.

    `@ opponentLastMove`: The opponent's last move. (Not utilized here)

    `@ opponentIndex`: The opponent's index.

    `@ currentRound`: The current round of the Tournament. (Not utilized here)
 
    `returns obj`: Returns the player object. 

    Periodically plays cooperate, cooperate, cooperate, cooperate, defect.

