# `genaxel` Class

## Class Definition

```matlab
classdef genaxel
```

## Class Attributes

```matlab
static_totalplayers = 0; % Total number of players in the population
```

## Methods

### Constructor

```matlab
function obj = genaxel()
```

* **Returns**: `obj` — A new `genaxel` object.

Creates a new `genaxel` object.

---

### `TheoreticalFitness`

```matlab
function [obj, Wn, V] = TheoreticalFitness(obj, b, strategies, pop0, T, rounding)
```

#### Parameters:

* `obj`: The `genaxel` object
* `b`: The payoff matrix
* `strategies`: Array of strategies
* `pop0`: Initial population for generation 0
* `T`: Number of rounds per game
* `rounding`: Method for rounding population updates

#### Returns:

* `Wn`: Population of the next generation
* `V`: Matrix of scores for each strategy against others

Runs a theoretical tournament to evaluate strategy fitness and updates populations accordingly.

---

### `SimFitness`

```matlab
function [obj, Wn] = SimFitness(obj, b, strategies, pop0, T)
```

#### Parameters:

* `obj`: The `genaxel` object
* `b`: The payoff matrix
* `strategies`: Array of strategies
* `pop0`: Population at generation n
* `T`: Number of rounds

#### Returns:

* `Wn`: Updated population

Simulates a tournament and returns updated population sizes based on scores.

---

### `ImitationSim`

```matlab
function [obj, Wn] = ImitationSim(obj, b, strategies, pop0, K, T)
```

#### Parameters:

* `obj`: The `genaxel` object
* `b`: The payoff matrix
* `strategies`: Array of strategies
* `pop0`: Population of generation n
* `K`: Number of imitation steps
* `T`: Number of rounds

#### Returns:

* `Wn`: Updated population

Applies an imitation rule where agents adopt successful strategies based on scores.

---

### `plotgen`

```matlab
function obj = plotgen(obj, generations, popHistory, strategies)
```

#### Parameters:

* `obj`: The `genaxel` object
* `generations`: Total number of generations
* `popHistory`: Matrix tracking population evolution
* `strategies`: Array of strategy indices

#### Returns:

* `obj`

Generates a plot showing how each strategy's population evolves across generations.

