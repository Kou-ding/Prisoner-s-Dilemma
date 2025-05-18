### TitForTat Class
```matlab
classdef tit_for_tat < player
```
#### Attributes
None
#### Methods
- Constructor
    ```matlab
    function obj = tit_for_tat(~)
    ```
    Creates a TitForTat player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove, ~, currentRound)
    ```
    First cooperate, afterwards copy your opponent's last move.