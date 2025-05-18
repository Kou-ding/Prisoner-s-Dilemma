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
    Creates a Tit for 2 Tat player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove, opponentIndex, currentRound)
    ```
    Tit for 2 tat: Cooperates on the first move, defects after two consecutive opponent defections, cooperates otherwise.