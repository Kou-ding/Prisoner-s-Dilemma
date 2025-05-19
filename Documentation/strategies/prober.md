### prober Class
```matlab
classdef prober < player
```
#### Attributes
```matlab
state = []; % per-opponent array of the player's current state number
```
#### Methods
- Constructor
    ```matlab
    function obj = prober(numberOfPlayers)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants.

    `returns obj`: Returns the player object. 
    
    Creates a Prober player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove, opponentIndex, ~)
    ```
    '@ obj': The player object.

    `@ opponentLastMove`: The opponent's last move.

    `@ opponentIndex`: The opponent's index.

    `@ currentRound`: The current round of the Tournament. (Not utilized here)
 
    `returns obj`: Returns the player object. 

    Initially plays cooperate, defect, cooperate. One the third cooperate ascertains if the opponent retaliated. If yes then the opponent isn't exploitable, thus continue as a tit-for-tat player. Otherwise the opponent is exploitable, thus continue as defect to maximize profits.
