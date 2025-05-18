### prober Class
```matlab
classdef prober < player
```
#### Attributes
```matlab
state = []; % per-opponent array of the player's current state number
```
#### Methods
- Constructor
    ```matlab
    function obj = prober(numberOfPlayers)
    ```
    Creates a Prober player.

- Move
    ```matlab
    function obj = setMove(obj, opponentLastMove, opponentIndex, ~)
    ```
    Initially plays cooperate, defect, cooperate. One the third cooperate ascertains if the opponent retaliated. If yes then the opponent isn't exploitable, thus continue as a tit-for-tat player. Otherwise the opponent is exploitable, thus continue as defect to maximize profits.
