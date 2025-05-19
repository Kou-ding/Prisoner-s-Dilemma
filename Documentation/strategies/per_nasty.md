### per_nasty Class
```matlab

```
#### Attributes
```matlab
state = []; % 0: Start by defecting, 1: Second defection, 2: Finally, cooperate
```
#### Methods
- Constructor
    ```matlab
    function obj = per_nasty(numberOfPlayers)
    ```
    `@ numberOfPlayers`: The Tournament's total number of participants.

    `returns obj`: Returns the player object. 
    
    Creates a Periodic Nasty player.

- Move
    ```matlab
    function obj = setMove(obj, ~, opponentIndex, ~)
    ```
    `@ obj`: The player object.

    `@ opponentLastMove`: The opponent's last move. (Not utilized here)

    `@ opponentIndex`: The opponent's index.

    `@ currentRound`: The current round of the Tournament. (Not utilized here)
 
    `returns obj`: Returns the player object. 

    Periodically plays defect, defect, cooperate.
