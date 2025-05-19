### tf2t Class
```matlab
classdef tf2t < player
```
#### Attributes
```matlab
opponentlasttwo = []; % Store the last two moves of the opponent
```
#### Methods
- Constructor
    ```matlab
    function obj = tf2t(numberOfPlayers)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants.

    `returns obj`: Returns the player object. 
    
    Creates a Tit for 2 Tat player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove, opponentIndex, currentRound)
    ```
    '@ obj': The player object.

    `@ opponentLastMove`: The opponent's last move.

    `@ opponentIndex`: The opponent's index.

    `@ currentRound`: The current round of the Tournament.
 
    `returns obj`: Returns the player object. 

    Tit for 2 tat: Cooperates on the first move, defects after two consecutive opponent defections, cooperates otherwise.