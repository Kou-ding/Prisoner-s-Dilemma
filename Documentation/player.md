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
Individual Strategies are child classes of the parent class Player. They implement a, unique to each strategy, **move()** function and sometimes have additional attributes that enable the way they calculate the move.

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
- Move
```matlab
function obj = setMove(obj, ~, ~, ~)
```
Always cooperates.

### Defect Class
```matlab
classdef defect < player
```
#### Attributes
None
#### Methods
- Constructor
    <div style="margin-left: 50px;">
    ```matlab
    function obj = cooperate(~)
    ```
    </div>
- Move
    ```matlab
    function obj = setMove(obj, ~, ~, ~)
    ```
    Always defects.

### Random Class
```matlab

```
#### Attributes
None
#### Methods
- Constructor
```matlab
```
- Move
```matlab
```
Makes a random move.
### TitForTat Class
```matlab

```
First cooperate, afterwards copy your opponent's last move.
### Grim Class
```matlab

```
Starts by cooperating, switches to permanent defection if the opponent ever defects. It tracks whether each opponent has defected using a flag array.
### hard_tft Class
```matlab

```
Cooperates on the first two moves, defects after at least one defection in the last two rounds,
cooperates otherwise.
### slow_tft Class
```matlab

```
Cooperates on the first  move, defects after two consecutive defections,
and returns to cooperation after two consecutive cooperations by the opponent.
### tf2t Class
```matlab

```
Tit for 2 tat: Cooperates on the first move, defects after two consecutive opponent defections,
cooperates otherwise.
### mistrust Class
```matlab

```
Defects on first move, then play what the opponent played on the previous move.
### pavlov Class
```matlab

```
Cooperates on the first move, then cooperates only if the two players made the same move.
### per_CD Class
```matlab

```
Periodically plays cooperate,defect.
### per_kind Class
```matlab

```
Periodically plays cooperate, cooperate, defect.
### per_nasty Class
```matlab

```
Periodically plays defect, defect, cooperate.
\subsection{gradual Class}
Cooperates on the first move, then defects n times after nth defections
and calms down its opponent with two cooperations.
### soft_majo Class
```matlab

```
Plays the opponent's most played move, cooperates in case of equality.
### per_ccccd Class
```matlab

```
Periodically plays cooperate, cooperate, cooperate, cooperate, defect.
### prober Class
```matlab

```
Initially plays cooperate, defect, cooperate. One the third cooperate ascertains if the opponent retaliated. If yes then the opponent isn't exploitable, thus continue as a tit-for-tat player. Otherwise the opponent is exploitable, thus continue as defect to maximize profits.
