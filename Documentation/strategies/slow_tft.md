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
    Creates a Slow Tit for Tat player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove,opponenIndex, currentRound)
    ```
    Cooperates on the first  move, defects after two consecutive defections, and returns to cooperation after two consecutive cooperations by the opponent.