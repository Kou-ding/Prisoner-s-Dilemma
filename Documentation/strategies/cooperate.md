### Cooperate Class
```matlab
classdef cooperate < player
```
#### Attributes
None
#### Methods
- Constructor
    ```matlab
    function obj = cooperate(~)
    ```
    Creates a **cooperate** player.

- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    Always cooperates.