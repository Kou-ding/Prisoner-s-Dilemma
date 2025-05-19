### Gradual Class
```matlab
classdef gradual < player
```
#### Attributes
```matlab
punishCount = []; % per-opponent counter array for the player punishing moves 
calmCount = []; % per-opponent counter array for the calming moves
totalDefections = []; % per-opponent counter array for the opponent defections
```
#### Methods
- Constructor
    ```matlab
    function obj = gradual(numberOfPlayers)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants.
    
    `returns obj`: Returns the player object. 
    
    Creates a Gradual player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove, opponentIndex, currentround)
    ```
    '@ obj': The player object.

    `@ opponentLastMove`: The opponent's last move.

    `@ opponentIndex`: The opponent's index.

    `@ currentRound`: The current round of the Tournament.
 
    `returns obj`: Returns the player object. 

    Cooperates on the first move, then defects n times after nth defections
    and calms down its opponent with two cooperations.
