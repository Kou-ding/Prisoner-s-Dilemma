### Grim Class
```matlab
classdef grim < player
```
#### Attributes
```matlab
opponentHasDefected = []; % Flag that indicates if the opponent has defected
```
#### Methods
- Constructor
    ```matlab
    function obj = grim(numberOfPlayers)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants.

    `returns obj`: Returns the player object. 
    
    Creates a Grim player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove, opponentIndex, currentRound)
    ```
    `@ obj`: The player object.

    `@ opponentLastMove`: The opponent's last move.

    `@ opponentIndex`: The opponent's index.

    `@ currentRound`: The current round of the Tournament.
 
    `returns obj`: Returns the player object. 

    Starts by cooperating, switches to permanent defection if the opponent ever defects. It tracks whether each opponent has defected using a flag array.