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
