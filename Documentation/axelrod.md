# Class Axelrod

```matlab
classdef axelrod
```

## Class Attributes

```matlab
players;       % Cell array of player objects
rounds;        % Total number of rounds in the tournament
currentRound;  % Current round of the tournament
payoffMatrix;  % Payoff matrix (2x2 cell array)
```

## Methods
- Constructor
    ```matlab
    function obj = axelrod()
    ```
    `returns obj`: Returns the axelrod object.

    Creates an axelrod object.

- Initialize Axelrod
    ```matlab
    function obj = initAxel(obj, playersArray, matrix, rounds)
    ```
    `@ obj`: The axelrod object.

    `@ playersArray`: A pre-initialized array of players.

    `@ matrix`: Payoff matrix for the game.

    `@ rounds`: Total number of rounds to be played.

    `returns obj`: Returns the axelrod object.

    Initializes the axelrod tournament with specified players, payoff matrix, and rounds.

- Initialize Players
    ```matlab
    function obj = InitPlayers(obj, strategiesArray, populationsArray, rounds)
    ```
    `@ obj`: The axelrod object.

    `@ strategiesArray`: Array of strategy indices.

    `@ populationsArray`: Array representing number of players per strategy.

    `@ rounds`: Number of rounds for the tournament.

    `returns obj`: Returns the axelrod object.

    Dynamically creates player instances based on strategy indices and initializes their indices and history matrices.

- Set Players
    ```matlab
    function obj = setPlayers(obj, players)
    ```
    `@ obj`: The axelrod object.

    `@ players`: Array of player objects.

    `returns obj`: Returns the axelrod object.

    Sets the internal players array.

- Get Players
    ```matlab
    function players = getPlayers(obj)
    ```
    `@ obj`: The axelrod object.

    `returns players`: Returns the array of players.

    Retrieves the array of players in the tournament.

- Set Rounds
    ```matlab
    function obj = setRounds(obj, rounds)
    ```
    `@ obj`: The axelrod object.

    `@ rounds`: Number of rounds.

    `returns obj`: Returns the axelrod object.

    Sets the number of rounds for the tournament.

- Get Rounds
    ```matlab
    function rounds = getRounds(obj)
    ```
    `@ obj`: The axelrod object.

    `returns rounds`: Returns the total number of rounds.

    Retrieves the total rounds of the tournament.

- Set Current Round
    ```matlab
    function obj = setCurrentRound(obj, currentRound)
    ```
    `@ obj`: The axelrod object.

    `@ currentRound`: The current round number.

    `returns obj`: Returns the axelrod object.

    Sets the current round in the tournament.

- Get Current Round
    ```matlab
    function currentRound = getCurrentRound(obj)
    ```
    `@ obj`: The axelrod object.

    `returns currentRound`: Returns the current round.

    Retrieves the current round of the tournament.

- Set Payoff Matrix
    ```matlab
    function obj = setPayoffMatrix(obj, payoffMatrix)
    ```
    `@ obj`: The axelrod object.

    `@ payoffMatrix`: A 2x2 cell array of payoff values.

    `returns obj`: Returns the axelrod object.

    Sets the game's payoff matrix.

- Get Payoff Matrix Element
    ```matlab
    function payoffMatrix = getPayoffMatrixElement(obj, row, column)
    ```
    `@ obj`: The axelrod object.

    `@ row`: Row index in the payoff matrix.

    `@ column`: Column index in the payoff matrix.
    
    `returns payoffMatrix`: Returns a specific value from the payoff matrix.

    Retrieves a value from the payoff matrix using the moves of the two players that participate in the encounter. Since move can take values 0 for cooperate and 1 for defect we can utilize this to derive the payoff of each player. 

- Encounter
    ```matlab
    function [player1, player2] = encounter(obj, player1, player2, currentRound)
    ```
    `@ obj`: The axelrod object.

    `@ player1, player2`: Two player objects involved in the encounter.

    `@ currentRound`: The current round number.

    `returns player1, player2`: Updated player objects.

    Simulates an encounter between two players, updating their moves, scores, and history.

- Play Round
    ```matlab
    function obj = playRound(obj)
    ```
    `@ obj`: The axelrod object.

    `returns obj`: Returns the axelrod object.

    Plays a single round of the tournament where all players encounter each other once.

- Begin Tournament
    ```matlab
    function obj = begin(obj)
    ```
    `@ obj`: The axelrod object.

    `returns obj`: Returns the axelrod object.

    Plays all rounds of the tournament in sequence.

- Print Results
    ```matlab
    function printResults(obj, strategiesArray, populationsArray)
    ```
    `@ obj`: The axelrod object.

    `@ strategiesArray`: Array of strategy indices used.

    `@ populationsArray`: Number of players for each strategy.

    `returns void`: Prints results to console.

    Summarizes and displays the total scores for each strategy after the tournament.
