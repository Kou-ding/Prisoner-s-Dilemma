# Class Player
```matlab
classdef player 
```
## Class Attributes
```matlab
index; % Player's index
score; % Player's score
history; % Empty array Strategies x Rounds
move; % Player's move
```
## Methods

## Strategies
Individual Strategies are child classes of the parent class Player. They implement a, unique to each strategy, **move()** function and sometimes have additional attributes that enable the way they calculate the move. They are explained in detail inside the *Documentation/strategies/* directory.


### slow_tft Class
```matlab

```
#### Attributes
None
#### Methods
- Constructor
    ```matlab

    ```
    Creates a  player.

- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    Cooperates on the first  move, defects after two consecutive defections, and returns to cooperation after two consecutive cooperations by the opponent.

### tf2t Class
```matlab

```
#### Attributes
None
#### Methods
- Constructor
    ```matlab

    ```
    Creates a  player.

- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    Tit for 2 tat: Cooperates on the first move, defects after two consecutive opponent defections, cooperates otherwise.

### mistrust Class
```matlab

```
#### Attributes
None
#### Methods
- Constructor
    ```matlab

    ```
    Creates a  player.

- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    Defects on first move, then play what the opponent played on the previous move.

### pavlov Class
```matlab

```
#### Attributes
None
#### Methods
- Constructor
    ```matlab

    ```
    Creates a  player.

- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    Cooperates on the first move, then cooperates only if the two players made the same move.

### per_CD Class
```matlab

```
#### Attributes
None
#### Methods
- Constructor
    ```matlab

    ```
    Creates a  player.

- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    Periodically plays cooperate,defect.

### per_kind Class
```matlab

```
#### Attributes
None
#### Methods
- Constructor
    ```matlab

    ```
    Creates a  player.

- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    Periodically plays cooperate, cooperate, defect.

### per_nasty Class
```matlab

```
#### Attributes
None
#### Methods
- Constructor
    ```matlab

    ```
    Creates a  player.

- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    Periodically plays defect, defect, cooperate.


### soft_majo Class
```matlab

```
#### Attributes
None
#### Methods
- Constructor
    ```matlab

    ```
    Creates a  player.

- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    Plays the opponent's most played move, cooperates in case of equality.

### per_ccccd Class
```matlab

```
#### Attributes
None
#### Methods
- Constructor
    ```matlab

    ```
    Creates a  player.

- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    Periodically plays cooperate, cooperate, cooperate, cooperate, defect.

### prober Class
```matlab

```
#### Attributes
None
#### Methods
- Constructor
    ```matlab

    ```
    Creates a  player.

- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    Initially plays cooperate, defect, cooperate. One the third cooperate ascertains if the opponent retaliated. If yes then the opponent isn't exploitable, thus continue as a tit-for-tat player. Otherwise the opponent is exploitable, thus continue as defect to maximize profits.
