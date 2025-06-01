# Script MarkovRun.m

## Use
This is the main script to run. Calls `initialize()` for initialization, `MarkovTheory()` to run the theretical part, `multimultigen()` to run the simulation part and `simGraphs()` to draw the simulation part graphs.








# Function initialize()

```matlab
[p1, p2, p3, payoff, N, roundsth, roundssim, numofreps, alluniquestates,
 initprobs, ngens, predetermined, names, chosen] = initialize()
```

`@ p1, @p2, @p3`: Strategy probability vectors.

`@ payoff`: Payoff matrix.

`@ N`: Total number of players.

`@ roundsth, @roundssim`: Rounds per match for the theoretical and simulation parts.

`@ numofreps`: Number of repetitions per initial state.

`@ alluniquestates`: All the unique states.

`@ initprobs`: Vector with the probabilities for each strategy to choose C as  initial move.

`@ ngens`: Number of generations.

`@ predetermined`: Εquals empty string ‘’ to denote use of strategies with strategy vectors. Use ‘A’, ‘B',… to denote use of predetermined outcome meetings.

`@ names`: Map with all the strategy names.

`@ chosen`: Vector with the indices of the strategies to compete.

## Use
Initially setup parameters and choices.

## Called by
Called by the main script `MarkovRun.m`








# Function MarkovTheory()

```matlab
[Ps, allcurrentstates,allnextstates,allprobs, MTheory, mcTheory] =
MarkovTheory(p1, p2, p3, payoff, N, roundsth, predetermined, alluniquestates)
```

`@ Ps`: Match payoffs for any two-by-two combination of players.

`@ allcurrentstates, @ allnextstates, @ allprobs`: Contain the information for all state transitions. In the same row of these three matrices we have respectively the current state, the next state and the probability for a certain state transition.

`@ MTheory`: The theoretically calculated transition matrix.

`@ mcTheory`: The Markov chain model for MTheory.

`@ p1, @p2, @p3`: Strategy probability vectors.

`@ payoff`: Payoff matrix.

`@ N`: Total number of players.

`@ roundsth`: Rounds per match for the theoretical part.

`@ predetermined`: Εquals empty string ‘’ to denote use of strategies with strategy vectors. Use ‘A’, ‘B',… to denote use of predetermined outcome meetings.

`@ alluniquestates`: All the unique states.

## Use
Calls `tournamentpayoffs()`, or `determiniosticPayoffs()`, depending on whether we use strategies with strategy vectors or predetermined outcome meetings, `transitionRules()` and `theoryGraphs()` to perform theoretical calculations. 

## Called by
Called by `MarkovRun.m`.







# Function tournamentpayoffs()

```matlab
Ps = tournamentpayoffs(p1, p2, p3, R, T, S, P)
```

`@ Ps`: Match payoffs for any two-by-two combination of players.

`@ p1, @p2, @p3`: Strategy vectors.

`@ R, @T, @S, @P`: Elements of the game payoff matrix.

## Use
Calculate the total strategy payoffs during a meeting. Calls `payoff()`.

## Called by
Called by `MarkovTheory()`.







# Function payoff()

```matlab
[M, pi, payoff1, payoff2] = payoff(p, q, R, S, T, P)
```

`@ M`: The state transition matrix.

`@ pi`: The stationary distribution π.

`@ payoff1, @payoff2`: The long-run expected average payoffs per round of the two players in a match.

`@ p, @q`: The strategy vectors of the two opponent strategies in a game.

`@ R, @T, @S, @P`: Elements of the game payoff matrix.

## Use
Calculates the state transition matrix, the stationary distribution and the expected average payoffs per round. Calls `transitionMatrix()`.

## Called by
Called by `tournamentpayoffs()`.








# Function transitionMatrix()

```matlab
M = transitionMatrix(p, q)
```

`@ M`: The state transition matrix.

`@ p, @q`: The strategy vectors of the two opponent strategies in a game.

## Use
Calculates the state transition matrix.

## Called by
Called by `payoff()`.







# Function deterministicPayoffs()

```matlab
Ps = deterministicPayoffs(R, T, S, P, roundsth, deterministic)
```

`@ Ps`: Match payoffs for any two-by-two combination of players.

`@ R, @T, @S, @P`: Elements of the game payoff matrix.

`@ roundsth`: Rounds per match for the theoretical part.

`@ deterministic`: Εquals empty string ‘’ to denote use of strategies with strategy vectors. Use ‘A’, ‘B',… to denote use of predetermined outcome meetings.

## Use
Calculates the match payoffs for any two-by-two combination of players in the case of predetermined outcome meetings.

## Called by
Called by `MarkovTheory()`.







# Function transitionRules()

```matlab
[allcurrentstates, allnextstates, allprobs] = transitionRules(Ps, N, roundsth)
```

`@ allcurrentstates, @ allnextstates, @ allprobs`: Contain the information for all state transitions. In the same row of these three matrices we have respectively the current state, the next state and the probability for a certain state transition.

`@ Ps`: Match payoffs for any two-by-two combination of players.

`@ N`: Total number of players.

`@ roundsth`: Rounds per match for the theoretical part.

## Use
Find all possible state transitions, given strategy populations and payoffs. Calls `strategyPayoffs()` to calculate the total strategy payoffs during a meeting, `remaintosamestate()` and `transferfromXtoY()`.

## Called by
Called by `MarkovTheory()`.







# Function strategyPayoffs()

```matlab
[SA, SB, SC] = strategyPayoffs(Ps, n, roundsth)
```

`@ SA, @ SB, @ SC`: The total payoffs, per generation, for the three strategies.

`@ Ps`: Match payoffs for any two-by-two combination of players.

`@ n`: n = [n1, n2, n3] is the vector of strategy populations.

`@ roundsth`: Rounds per match for the theoretical part.

## Use
Returns the  total expected average payoff for each one of the three strategies, for the current generation.

## Called by
Called by `transitionRules()`.








# Function remaintosamestate()

```matlab
[allcurrentstates, allnextstates, allprobs] = remaintosamestate(probability, n, allcurrentstates,allnextstates,allprobs)
```

`@ allcurrentstates, @ allnextstates, @ allprobs`: Contain the information for all state transitions. In the same row of these three matrices we have respectively the current state, the next state and the probability for a certain state transition.

`@ probability`: The probability to remain to the same state.

`@ n`: n = [n1, n2, n3] is the current  vector of strategy populations.

## Use
Add a new row in `@ allcurrentstates`, `@ allnextstates`, `@ allprobs`, when we remain to the same state `@ n` with `@ probability`.

## Called by
Called by `transitionRules()`.








# Function transferfromXtoY()

```matlab
[allcurrentstates, allnextstates, allprobs] = transferfromXtoY(strategyX, strategyY, probability, n, idx,
 allcurrentstates, allnextstates, allprobs)
```

`@ allcurrentstates, @ allnextstates, @ allprobs`: Contain the information for all state transitions. In the same row of these three matrices we have respectively the current state, the next state and the probability for a certain state transition.

`@ strategyX`: Index of the strategy to transfer the player from.

`@ strategyY`: Index of the strategy to transfer the player to.

`@ probability`: The probability for the transition to occur.

`@ n`: n = [n1, n2, n3] is the current vector of strategy populations.

`@ idx`: Vector of indices of the three strategies when sorted in descending order, with respect to their total expected average payoff in the current generation. 

## Use
Add a row in `@ allcurrentstates`, `@ allnextstates`, `@ allprobs`, with a new state transition, in the case we substract a player from `@ strategyX` and add it to `@ strategyY`.

## Called by
Called by `transitionRules()`.







# Function theoryGraphs()

```matlab
[M, mcTheory] = theoryGraphs(allcurrentstates, allnextstates, allprobs, N, alluniquestates)
```
`@ M`: The theoretically calculated transition matrix.

`@ mcTheory`: The Markov chain model for `@ M`.

`@ allcurrentstates, @ allnextstates, @ allprobs`: Contain the information for all state transitions. In the same row of these three matrices we have respectively the current state, the next state and the probability for a certain state transition.

`@ N`: Total number of players.

`@ alluniquestates`: All the unique states.

## Use
Draws all the graphs for the theoretical part. Returns the theoretically calculated transition matrix `@ M` and its Markov chain model.

## Called by
Called by `MarkovTheory()`.








# Function graphPlot()

```matlab
graphPlot(mc, M, alluniquestates, N)
```

`@ mc`: The Markov chain model for the theoretically calculated transition matrix `@ M`.

`@ M`: The theoretically calculated transition matrix.

`@ alluniquestates`: All the unique states.

`@ N`: Total number of players.

## Use 
Draws the state transition graph, based on `M`.

## Called by
Called by `theoryGraphs()`.








# Function multimultigen()

```matlab
[row, m, repgenNumOfPlayersHistory] = multimultigen(p1, p2, p3, initialstate, rounds, payoff, initprobs,
 numofreps, alluniquestates, ngens)
```

`@ row`: The index of the row of the k-step (k big) transition matrix `@ M` when considering the `@ numofreps` repetitions, all starting from the same `@ initialstate`. 

`@ m`: The row of the k-step (k big) transition matrix `@ M` when considering the `@ numofreps` repetitions, all starting from the same `@ initialstate`.

`@ repgenNumOfPlayersHistory`: Holds all the history of the evolution in time of the population of each strategy for all the repetitions starting from the same `@ initialstate`.

`@ p1, @ p2, @p3`: The strategy vectors of the three competing strategies.

`@ initialstate`: The initial state for all the `@ numofreps` repetitions.

`@ rounds`: Rounds per match for the simulation part.

`@ payoff`: Holds the game payoff matrix elements `@ R`, `@ S`, `@ T`, `@ P`. 

`@ initprobs`: Vector with the probabilities for each strategy to choose C as  initial move.

`@ numofreps`: Number of repetitions per initial state.

`@ alluniquestates`: All the unique states.

`@ ngens`: Number of generations.

## Use 
Performs the many repetitions of the generation evolution, all starting from the same `@ initialstate`. Calls, `multigen()`.

## Called by
Called by `MarkovRun.m`.








# Function multigen()

```matlab
[finalstate, genNumOfPlayersHistory] = multigen(p1, p2, p3, initialstate, rounds, payoff, initprobs, alluniquestates, ngens)
```

`@ finalstate`: The final state reached, starting the generation evolution from `@ initialstate`.

`@ genNumOfPlayersHistory`: Holds the evolution in time of the population of each strategy for a specific repetition starting from the state `@ initialstate`.

`@ p1, @ p2, @p3`: The strategy vectors of the three competing strategies.

`@ initialstate`: The initial state for all the `@ numofreps` repetitions.

`@ rounds`: Rounds per match for the simulation part.

`@ payoff`: Holds the game payoff matrix elements `@ R`, `@ S`, `@ T`, `@ P`. 

`@ initprobs`: Vector with the probabilities for each strategy to choose C as  initial move.

`@ alluniquestates`: All the unique states.

`@ ngens`: Number of generations.

## Use 
Performs one of the repetitions of the generation evolution, starting from the `@ initialstate`. Calls `gentournament()`.

## Called by
Called by `multimultigen()`.








# Function gentournament()

```matlab
[nextstate, tournamentscores] = gentournament(p1, p2, p3, currentstate, rounds, payoff, initprobs, alluniquestates)
```

`@ nextstate`: The next state in the generation evolution.

 `@ tournamentscores`: Vector with the total expected average payoffs of the competing strategies.

`@ p1, @ p2, @p3`: The strategy vectors of the three competing strategies.

`@ currentstate`: The current state.

`@ rounds`: Rounds per match for the simulation part.

`@ payoff`: Holds the game payoff matrix elements `@ R`, `@ S`, `@ T`, `@ P`. 

`@ initprobs`: Vector with the probabilities for each strategy to choose C as  initial move.

`@ alluniquestates`: All the unique states.

## Use 
Performs a meeting (generation) among three competing strategies. Returns the next state in the generation evolution and the total expected average payoff for each strategy, at the end of the meeting. Calls `randomplay()`, `playmatch()` and `nxt()`. 

## Called by
Called by `multigen()`.








# Function randomplay()

```matlab
Cprobs = randomplay(rounds, vectorp)
```

`@ Cprobs`: A 4 x `@ rounds` matrix with the premade choices, according to the conditional probabilities given in `@ vectorp`. 

`@ rounds`: Rounds per match for the simulation part.

`@ vectorp`: The strategy vector of the specific strategy.

## Use 
Creates the matrix `@ Cprobs` with the premade choices with the conditional probabilities given in `@ vectorp`.

## Called by
Called by `gentournament()`.








# Function playmatch()

```matlab
[XYchoices, matchscores] = playmatch(rounds, firstX, CprobsX, firstY, CprobsY, payoff)
```

`@ XYchoices`: A 2 x `@ rounds` matrix, with the choices of the two players during the match.

`@ matchscores`: Contains the scores the two players gained after the match.

`@ rounds`: Rounds per match for the simulation part.

`@ firstX`: First move of the first player.

`@ CprobsX`: A 4 x `@ rounds` matrix with the premade choices for the first player, according to the conditional probabilities of his strategy. 

`@ firstY`: First move of the second player.

`@ CprobsY`: A 4 x `@ rounds` matrix with the premade choices for the second player, according to the conditional probabilities of his strategy.

`@ payoff`: Holds the game payoff matrix elements `@ R`, `@ S`, `@ T`, `@ P`. 

## Use 
Plays a match between two players, returning their choices and scores. 

## Called by
Called by `gentournament()`. 








# Function nxt()

```matlab
nextstate = nxt(S, n, alluniquestates)
```

`@ nextstate`: Next state in the generation evolution.

`@ S`: Vector of the total expected average payoffs of the strategies during this generation.

`@ n`: n = [n1, n2, n3] is the current vector of strategy populations.

`@ alluniquestates`: All the unique states.

## Use 
Finds the next state of the generation evolution, given the current state `@ n` and the vector `@ S` of the total expected average payoffs of the strategies during this generation. Calls its own realizations of `remaintosamestate()` and `transferfromXtoY()`.

## Called by
Called by `gentournament()`.








# Function simGraphs()

```matlab
simGraphs(Msim, Mk, MTheory, statenames, alluniquestates, ngens, N)
```

`@ Msim`: The simulated one-step state transition matrix.

`@ Mk`: The simulated k-step (k big) state transition matrix.

`@ MTheory`: The theoretically calculated one-step state transition matrix.

`@ statenames`: Vector containing all the unique state names as strings.

`@ alluniquestates`: All the unique states.

`@ ngens`: Number of generations.

`@ N`: Total number of players.

## Use
Draws all the graphs for the simulation part. Calls `graphPlot()`.

## Called by
Called by `MarkovRun.m`.








# Function populationAnimation()

```matlab
populationAnimation(W, strategiesArray, namesofStrategies)
```

`@ W`: Matrix of dimensions 3 x (`@ ngens`+1), with the population evolution history to be animated.

`@ strategiesArray`: Vector containing the indices of the strategies to compete.

`@ namesofStrategies`: Map with the indices and names of all the strategies.

## Use
Animation of the time evolution of the strategy populations.

## Called by
Called from MATLAB's Command Window.


