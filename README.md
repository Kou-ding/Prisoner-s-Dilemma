# Prisoner-s-Dilemma
Notes and assignments of the university course:  "Game Theory".

### To-do List
- [ ] Make the history matrix of the players dynamic so that we don't allocate more memory than we actually need.


### Time Schedule
| Week | Assignment | Percentage |
|------|------------|------------|
|21/03/2025|Create group|10%|
|04/04/2025|4-strategy Axelrod Tournament|20%|
|11/04/2025|Implement more strategies|20%|
|09/05/2025|Genetic Axelrod tournament|30%|
|23/05/2025|Genetic WinPrisoner tournament|20%|

## Documentation
Each player has their own history matrix which has dimensions Rounds x Players. This allows us to store how a player played throughout all of their encounters with other players.