# Function TourSimFit

```matlab
TourTheFit(obj, b , strategies , pop0 , T , J , rounding)
```

`@ b`: The payoff parameter(s) for the game.

`@ strategies`: The array populated by the strategy definitions.

`@ pop0`: The initial population distribution across the strategies.

`@ T`:  The number of rounds per tournament.

`@ J`: Number of generations to simulate.

`@ rounding`: Controls how fractional population values are rounded.


# Comment
Runs a round-robin tournament to compute payoffs, then updates the population using fitness-proportional rules based on Mathieu's formula. Scores are weighted by opponent populations, normalized, and rounded to determine the next generation's distribution. 