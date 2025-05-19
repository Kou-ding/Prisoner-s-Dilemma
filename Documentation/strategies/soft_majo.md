### soft_majo Class
```matlab
classdef soft_majo < player
```
#### Attributes
```matlab
opponentsMovecount = []; % Per opponent, number of coops and defects
```
#### Methods
- Constructor
    ```matlab
    function obj = soft_majo(numberOfPlayers)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants.

    `returns obj`: Returns the player object. 
    
    Creates a Soft Majority player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove, opponentIndex, currentRound)
    ```
    '@ obj': The player object.

    `@ opponentLastMove`: The opponent's last move.

    `@ opponentIndex`: The opponent's index.

    `@ currentRound`: The current round of the Tournament.
 
    `returns obj`: Returns the player object. 

    Plays the opponent's most played move, cooperates in case of equality.

