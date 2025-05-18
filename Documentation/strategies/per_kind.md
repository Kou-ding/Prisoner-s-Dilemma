### per_kind Class
```matlab
classdef per_kind < player
```
#### Attributes
```matlab
state = []; % States: 1 -> C, 2 -> C, 3 -> D
```
#### Methods
- Constructor
    ```matlab
    function obj = per_kind(numberOfPlayers)
    ```
    Creates a Periodic Kind player.

- Move
    ```matlab
    function obj = setMove(obj, ~, opponentIndex, ~)
    ```
    Periodically plays cooperate, cooperate, defect.



