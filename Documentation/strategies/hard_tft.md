### hard_tft Class
```matlab
classdef hard_tft < player
```
#### Attributes
```matlab
opponentlasttwo = []; % A per-opponent array that stores the opponent's last two moves 
```
#### Methods
- Constructor
    ```matlab
    function obj = hard_tft(numberOfPlayers)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants.

    `returns obj`: Returns the player object. 
    
    Creates a Hard Tit for Tat player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove, opponentIndex, currentRound)
    ```
    `@ obj`: The player object.

    `@ opponentLastMove`: The opponent's last move.

    `@ opponentIndex`: The opponent's index.

    `@ currentRound`: The current round of the Tournament.
 
    `returns obj`: Returns the player object. 

    Cooperates on the first two moves, defects after at least one defection in the last two rounds, cooperates otherwise.
