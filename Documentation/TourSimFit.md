# Function TourSimFit

```matlab
function TourSimFit(b , strategies , pop0 , T , J)
```
`@ b`: The bemefit parameter for the game

`@ strategies`: The array of available strategies (Seek details in *Examples/script.m*)

`@ pop0`: The initial population distribution across the strategies.

`@ T`:  The number of rounds per tournament.

`@ J`: The number of generations to simulate.


# General comment
Runs a tournament using selected strategies and populations only, tracking individual scores and computing a total. Each strategy's population is then updated proportionally to its score, reflecting dynamic interactions in populations over time.