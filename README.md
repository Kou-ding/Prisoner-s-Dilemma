# Prisoner-s-Dilemma
Notes and assignments of the university course: "Game Theory".

## Documentation
### Run
In order to run the code:
1. Tweak the parameter values inside the script.m file
2. Run the main.m file

### Code's Structure
This is a Game Theory Sandbox which allows the user to simulate games between different Players that encapsulate different Strategies. It is written in Object-oriented Matlab featuring two main Classes:
- The Axelrod Class
- The Player Class

Each Strategy is a child Class of the Player Class and differentiates itself from the rest through one function, setMove(), and some extra attributes that help implement the strategy's logic, if needed.

### Implementsd strategies index
#### Cooperate:
Always cooperates.
#### Defect:
Always defects.
#### Random:
Makes a random move.
#### Grim:
Cooperate until the opponent defects, then always defect.
#### Tit for tat:
First cooperate, afterwards copy your opponent's last move.
#### Hard tit for tat:
Cooperates on the first two moves, defects after at least one defection in the last two rounds,
cooperates otherwise.
#### Slow tit for tat:
Cooperates on the first  move, defects after two consecutive defections,
and returns to cooperation after two consecutive cooperations by the opponent.
#### Tit for 2 tat:
Cooperates on the first move, defects after two consecutive opponent defections,
cooperates otherwises.
#### Mistrust:
Defects on first move, then play what the opponent played on the previous move.
#### Pavlov: 
Cooperates on the first move, then cooperates only if the two players made the same move.
#### Periodic C-D:
Periodically plays cooperate,defect.
#### Periodic Kind:
Periodically plays cooperate, cooperate, defect.
#### Periodic Nasty:
Periodically plays defect, defect, cooperate.
#### Gradual:
Cooperates on the first move, then defects n times after nth defections
and calms down its opponent with two cooperations.
#### Soft majority:
Plays the opponent's most played move, cooperates in case of equality.

### numberOfplayers, opponentIndex
- In most of the strategies implemented, numberOfPlayers represents the total number of opponents in the tournament, and is used to initialize structures that track behavior for each opponent individually. This allows the player to store and update information separately for every opponent. 
- The variable opponentIndex identifies the specific opponent that the player is currently engaging with during a particular round. It is used to access or modify that opponent's corresponding row in these structures, ensuring that the player's decisions are tailored to each opponent's unique behavior history.


### Time Schedule
| Week | Assignment | Percentage |
|------|------------|------------|
|21/03/2025|Create group|10%|
|04/04/2025|4-strategy Axelrod Tournament|20%|
|11/04/2025|Implement more strategies|20%|
|09/05/2025|Genetic Axelrod tournament|30%|
|23/05/2025|Genetic WinPrisoner tournament|20%|

### To-do List
- [ ] Fill to do list