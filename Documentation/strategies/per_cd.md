### per_CD Class
```matlab
classdef per_cd < player
```
#### Attributes
```matlab
state = []; % States: 0 -> at start or after D, 1 -> after C
```
#### Methods
- Constructor
    ```matlab
    function obj = per_cd(numberOfPlayers)
    ```
    Creates a Periodic Cooperate Defect player.

- Move
    ```matlab
    function obj = setMove(obj, ~, opponentIndex, ~)
    ```
    Periodically plays cooperate, defect.
