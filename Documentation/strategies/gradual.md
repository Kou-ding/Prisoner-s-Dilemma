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
    Creates a Gradual player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove, opponentIndex, currentround)
    ```
    Cooperates on the first move, then defects n times after nth defections
    and calms down its opponent with two cooperations.
