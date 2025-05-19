# Axel
``` matlab
function Axel(strategiesArray, populationsArray, matrix, rounds)
```
`@ strategiesArray`: Array that include's all the participating strategies. 

`@ populationsArray`: Array that specifies the populations of each strategie in the strategiesArray.

`@ matrix`: Tournament's payoff matrix.

`@ rounds`: Tournament's rounds.

The **Axel** function starts a Tournament after creating an axelrod object and initializing the players and the tournament itself. It prints the results in the console.