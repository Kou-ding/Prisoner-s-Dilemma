```matlab
function TourTheFit(matrix, strategiesArray, populationsArray, rounds, generations, rounding)
```
`@ matrix`: The payoff matrix of the tournament.

`@ strategiesArray`: The array populated by the strategies involved in the Tournament. Each number corresponds to a specific strategy. (Seek details in *Examples/script.m*)

`@ populationsArray`: The array which consists of the populations of each strategy mention in the strategiesArray above.

`@ rounds`: The number of rounds each individual Axelrod Tournament will last.

`@ generations`: The number of times the Axelrod Tournament goes through all its rounds, updating the strategies' populations based on their accumulated points.

`@ rounding`: The rounding method used in the Tournament.

# Comment
Conducts a round-robin tournament between all strategies to calculate the payoff matrix, V. These results are then used to compute fitness-based population updates for the next generation, using the Mathieu's formula.
The total number of players for the next generation is redistributed across strategies proportionally to their performance scores. Each strategy's score is calculated based on its success against others, weighted by their population. The total score across all strategies is used to normalize these values.A rounding method finalizes the allocation.