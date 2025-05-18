### per_nasty Class
```matlab

```
#### Attributes
```matlab
state = []; % 0: Start by defecting, 1: Second defection, 2: Finally, cooperate
```
#### Methods
- Constructor
    ```matlab
    function obj = per_nasty(numberOfPlayers)
    ```
    Creates a Periodic Nasty player.

- Move
    ```matlab
    function obj = setMove(obj, ~, opponentIndex, ~)
    ```
    Periodically plays defect, defect, cooperate.
