### per_ccccd Class
```matlab
classdef per_ccccd < player
```
#### Attributes
```matlab
state = []; % per-opponent array of the player's current state number
```
#### Methods
- Constructor
    ```matlab
    function obj = per_ccccd(numberOfPlayers)
    ```
    Creates a Periodic Cooperate Cooperate Cooperate Cooperate Defect player.

- Move
    ```matlab
    function obj = setMove(obj, ~, opponentIndex, ~)
    ```
    Periodically plays cooperate, cooperate, cooperate, cooperate, defect.

