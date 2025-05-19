### slow_tft Class
```matlab
classdef slow_tft < player
```
#### Attributes
```matlab
opponentsLasttwo = []; % A per-opponent array that stores the opponent's last two moves 
```
#### Methods
- Constructor
    ```matlab
    function obj = slow_tft(numberOfPlayers)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants.

    `returns obj`: Returns the player object. 
    
    Creates a Slow Tit for Tat player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove,opponentIndex, currentRound)
    ```
    '@ obj': The player object.

    `@ opponentLastMove`: The opponent's last move.

    `@ opponentIndex`: The opponent's index.

    `@ currentRound`: The current round of the Tournament.
 
    `returns obj`: Returns the player object. 

    Cooperates on the first  move, defects after two consecutive defections, and returns to cooperation after two consecutive cooperations by the opponent.