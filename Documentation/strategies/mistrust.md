### mistrust Class
```matlab
classdef mistrust < player
```
#### Attributes
None
#### Methods
- Constructor
    ```matlab
    function obj = mistrust(~)
    ```
    Creates a Mistrust player.

- Move
    ```matlab
    function obj = setMove(obj, opponentsLastMove, ~, currentRound)
    ```
    Defects on first move, then play what the opponent played on the previous move.

