# TourTheFit
```matlab
function TourTheFit(matrix, strategiesArray, populationsArray, rounds, generations, rounding)
```
`@ matrix`: The payoff matrix of the tournament.

`@ strategiesArray`: The array populated by the strategies involved in the Tournament. Each number corresponds to a specific strategy. (Seek details in *Examples/script.m*)

`@ populationsArray`: The array which consists of the populations of each strategy mention in the strategiesArray above.

`@ rounds`: The number of rounds each individual Axelrod Tournament will last.

`@ generations`: The number of times the Axelrod Tournament goes through all its rounds, updating the strategies' populations based on their accumulated points.

`@ rounding`: The rounding method used in the Tournament.

The Theoretical Fitness tournament