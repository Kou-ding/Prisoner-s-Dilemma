# HOW TO RUN
All the files required are inside the Markov directory. In function `initialize()` we can choose the total population `N`, the payoff matrix (`R`, `S`, `T`, `P`), the rounds per match for the theoretical (`roundsth`) and the simulation (`roundssim`) part, the number of repetitions per initial state `numofrep`, the number of generations `ngens` needed for the simulation part and the vector `chosen` of the three strategies to compete. If the calculations are to be based on the expected average payoff per round, the value of the variable `predetermined` should be set to the empty string ' '. If exact calculations based on the evaluation of the score as a deterministic function of the game history, are to be used, we can choose the competitors by setting an appropriate string value for `predetermined` (see `initialize()` for details). After the theoretical calculations are performed and the respective graphs drawn, the user is asked if he wishes to continue with the simulation part (may be time demanding). There is no simulation part if predetermined outcome meetings are used.

Run the script `MarkovRun.m`
 
# HOW TO ADD A NEW STRATEGY WITH ITS STRATEGY VECTOR $\mathbf{p}$
 
In `initialize()`, add the strategy's index and name in the map `names`, its name and strategy vector in map `ps` and its name and probability for the initial move to be C, in the map `pinitC`.
 
# HOW TO ADD A NEW PREDETERMINED OUTCOME MEETING
 
Use a new letter as a possible value of `predetermined` and add a new information message in the appropriate `switch-case` in `initialize()`. Describe the calculation of the payoffs in a match between any two players, in the `switch-case` of the function `deterministicPayoffs()`.
 