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
    Creates a Hard Tit for Tat player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove, opponentIndex, currentRound)
    ```
    Cooperates on the first two moves, defects after at least one defection in the last two rounds, cooperates otherwise.
