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
    Creates a Grim player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove, opponentIndex, currentRound)
    ```
    Starts by cooperating, switches to permanent defection if the opponent ever defects. It tracks whether each opponent has defected using a flag array.