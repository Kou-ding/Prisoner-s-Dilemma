### hard_tft Class
```matlab
classdef hard_tft < player
```
#### Attributes
```matlab
opponentlasttwo = [];
```
#### Methods
- Constructor
    ```matlab

    ```
    Creates a Hard Tit for Tat player.

- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    Cooperates on the first two moves, defects after at least one defection in the last two rounds,
cooperates otherwise.
