classdef  genaxel
    properties
        static_totalplayers = 0; % Total number of players in the population
               
    end
        % function TourTheFit wher b is the payoff matrix of row player
        % strategies is the array of strategies
        % pop0 is the array of population sizes for generation 0 
        % T is the time = (number of rounds) a game lasts
        % J is the number of genarations
       %%%
        % TourTheFit(obj, b , strategies , pop0 , T , J )
       %%%
    methods

        function obj = genaxel()
            % Constructor for the genaxel class
            % Initialize any properties if needed
        end

        %{      
            function TourTheFit(obj, b , strategies , pop0 , T , J ) . Σε αυτη τη συνάρτηση 
            θα επιστρεφεται καθε φορα ο πληθυσμος της γενιας n και το V που ειναι το score 
            μιας στρατηγικης με την αλλη στρατηγικη.Για τη V οριζουμε ενα πινακα με δυο διαστασεις
            τις καταλληλεσ για να παρουμε καθε αναμετρηση μιας στρατηγικης με την αλλη στρατηγικη.
            Με βαση το κωδικα που εχουμε υλοποιηση για το axelrod τρεχουμε ενα τουρνουα για καθε μια
            στρατηγικη ανα μεταξυ της και ετσι εχουμε τον πινακα V. Χρησιμοποιωντας τη φορμουλα του 
            Mathieu ενημερωνουμε τους πλυθησμους της γενιας n + 1.
        %}
        function [obj,Wn,V] = TheoreticalFitness(obj, b , strategies , pop0 , T , rounding)
            % V stores the strategies interactions with one another
            V = zeros(length(strategies),length(strategies));
            Wn = pop0; % Wn is the population of generation n
           
            %we will implement a axelrod tournament for two strategies of population 1 each time 
            %population is a matrix of size 1*2 
            
            totalplayers = sum(Wn); % Total number of players in the population
  
            oneVone = ones(1,2);
            Gn = zeros(1,length(strategies)); % Gn is the score of each strategy
            Tn = 0; % Total score of the generation
            for i = 1:length(strategies)
                for j = 1:length(strategies)
                    % Create a new axelrod tournament for each strategy
                    tempArray = [strategies(i) , strategies(j)];
                    tournament = axelrod(); % Create an axelrod tournament
                    tournament = tournament.InitPlayers(tempArray,oneVone,T);
                    % Initialize the tournament with players and payoff matrix 
                    tournament = tournament.initAxel(tournament.players,b,T); 
                    tournament = tournament.begin(); % Run the tournament
                    V(i,j) =  tournament.players{1}.getScore(); % Store the score of the first player
                    Gn(i) = Gn(i) + V(i,j)*Wn(j)  ; % Update the score of the strategy i
                end
                Gn(i) = Gn(i) - V(i,i) ;
                % Update the score of the strategy i by removing the self-play score    
                Tn = Tn + Gn(i)*Wn(i) ; % Update the total score
            end
            % Add the decimals to the population of a fixed index
            % for i = 1:length(strategies)
            %     Wn(i) = floor(totalplayers * Gn(i)*Wn(i) / Tn);
               
            % end
            % Wn(length(strategies)-2) = Wn(length(strategies)-2) + 1;

            %%%%%%%% DECIMAL REDISTRIBUTION %%%%%%%%%%%%%
            if rounding == "paper"
                for i = 1:length(strategies)
                    Wn(i) = obj.static_totalplayers * Gn(i)*Wn(i) / Tn;
                    Wn(i) = floor(Wn(i));
                end
            end
            if rounding == "pop"
                remainder = zeros(1, length(strategies));

                for i = 1:length(strategies)
                    Wn(i) = totalplayers * Gn(i)*Wn(i) / Tn;
                    remainder(i) = Wn(i) - floor(Wn(i));
                    Wn(i) = floor(Wn(i));
                end
            
                remaining = totalplayers - sum(Wn);  % How many individuals to redistribute
                [~, sortedIndices] = sort(Wn, 'descend');  % Use Wn values to pick top strategies
            
                for k = 1:remaining
                    Wn(sortedIndices(k)) = Wn(sortedIndices(k)) + 1;
                end
            end
            if rounding == "dec"
                remainder = zeros(1, length(strategies));
            
                for i = 1:length(strategies)
                    Wn(i) = totalplayers * Gn(i) * Wn(i) / Tn;
                    remainder(i) = Wn(i) - floor(Wn(i));
                    Wn(i) = floor(Wn(i));
                end
            
                remaining = totalplayers - sum(Wn);  % How many people we still need to assign
                [~, sortedIndices] = sort(remainder, 'descend');  % Sort by largest decimals
            
                for k = 1:remaining
                    Wn(sortedIndices(k)) = Wn(sortedIndices(k)) + 1;
                end
            end            
            if rounding == "off"
                for i = 1:length(strategies)
                    Wn(i) = totalplayers * Gn(i)*Wn(i) / Tn;
                end
            end
        end
        
        function [obj,Wn] = SimFitness(obj, b , strategies , pop0 , T )
            tournament = axelrod(); % Create an axelrod tournament  
            tournament = tournament.InitPlayers(strategies,pop0,T); % Initialize players
            tournament = tournament.initAxel(tournament.players,b,T); % Initialize the tournament with players and payoff matrix
            tournament = tournament.begin(); % Run the tournament
            popscore = zeros(1,length(strategies)); % Initialize the  score of each population 
            totalscore = 0; % Initialize the total score
        
            counter = 1;
            Wn = pop0; % Wn is the population of generation n
            totalplayers = sum(Wn); % Total number of players in the population
            for i = 1:length(strategies)
                for j = 1:Wn(i)
                    popscore(i) = popscore(i) + tournament.players{counter}.getScore();
                    counter = counter + 1;
                end
                totalscore = totalscore + popscore(i);
            end
            
            % new Wn populations score
            for i = 1:length(strategies)
                Wn(i) = floor(totalplayers * popscore(i) / totalscore) ;
            end
        end

        function [obj,Wn] = ImitationSim(obj, b , strategies , pop0 , K , T )
            V = zeros(length(strategies),length(strategies));
            Wn = pop0; % Wn is the population of generation n  
            oneVone = ones(1,2);
            Gn = zeros(1,length(strategies)); % Gn is the score of each strategy
            
            for i = 1:length(strategies)
                for j = 1:length(strategies)
                    % Create a new axelrod tournament for each strategy
                    tempArray = [strategies(i) , strategies(j)];
                    tournament = axelrod(); % Create an axelrod tournament
                    tournament = tournament.InitPlayers(tempArray,oneVone,T);
                    % Initialize the tournament with players and payoff matrix 
                    tournament = tournament.initAxel(tournament.players,b,T); 
                    tournament = tournament.begin(); % Run the tournament
                    V(i,j) =  tournament.players{1}.getScore(); % Store the score of the first player
                    Gn(i) = Gn(i) + V(i,j)*Wn(j)  ; % Update the score of the strategy i
                end
                Gn(i) = Gn(i) - V(i,i) ;
                   
                
            end

            popscore = Gn; % Initialize the score of each population
            playerscore = zeros(1,length(strategies)); % Initialize the score of player
            for i = 1:length(strategies)
                playerscore(i) = popscore(i) / Wn(i); % find how much a player of strategy i has scored
            end
            %{
            for i = 1:length(strategies)
                for j = 1:Wn(i)
                    popscore(i) = popscore(i) + tournament.players{counter}.getScore();
                    counter = counter + 1;
                end
            end
            %}
            
            % 1 way to calculate without normalizing the total score of each population 
            % how to find the best scores from strategies 
            maxValue = max(playerscore);
            allIndices = find(playerscore==maxValue);
            % select a random index from the array that indicates all the best strategies
            indexBest = randi(length(allIndices));% Select a random index from the array of best strategies
            Bestscore = playerscore(indexBest);

            
            newIndex = indexBest;
            for i = 1:K
                % Check if a population is zero
                zerop = find(Wn == 0);
                
                if length(zerop) < (length(strategies) - 1)
                    
                    while newIndex == indexBest  || ismember(newIndex,zerop)
                        % Select a random index from the pop array .if its same with best index, do it again
                        newIndex = randi(length(Wn)); % Select a random index from the population array                        
                    end
                    
                    Wn(newIndex) = Wn(newIndex) - 1; % Decrease the population of the selected index by 1
                    Wn(indexBest) = Wn(indexBest) + 1; % Increase the population of the best index by 1
                    newIndex = indexBest; % Reset the new index for the next iteration
                end
            end  
        end

        % Generates a plot of the population evolution for each strategy
        function obj = plotgen( obj , generations , popHistory , strategies)
            numofgenerations = generations;
            strategiesArray = strategies;
            popn = popHistory;
            totalplayers = zeros(numofgenerations,length(strategiesArray));
            % Calculate the total number of players for each generation
            for i = 1:numofgenerations
                totalplayers(i) = sum(popn(i,:));
            end
            totalstrategies = length(strategiesArray);
            
            x = linspace(0, numofgenerations , numofgenerations); % X-axis: generations
            
            colors =['r','g','b','c','m','y','k']; % Define colors for each strategy
            figure
            grid 


            for i = 1:totalstrategies
                h(i) = animatedline('Color', colors(i),'LineWidth',2); % Create animated line for each strategy
            end
            
            axis([0,numofgenerations ,  0 ,max(popHistory , [], "all")+1]);

            hxlabel= xlabel('Generation');
            set(hxlabel,'Interpreter' , 'latex');
            
            hylabel= ylabel('Population');
            set(hylabel,'Interpreter','latex');
            
            htitle= title('$Evolution$ $of$ $population$ $for$ $each$ $strategy$');
            set(htitle,'Interpreter','latex');

            namesofstrategies = containers.Map(...
                {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17}, ... % Strategy numbers
                {'Random', 'Cooperate', 'Defect', 'Grim', 'Tit for Tat', 'Hard Tit for Tat', 'Slow Tit for Tat', 'Tit for two Tat', ...
                'Soft Majority', 'Periodic Cooperate Defect', 'Periodic Kind', 'Periodic Nasty', 'Gradual', 'Pavlov', 'Mistrust', 'Periodic Ultra Kind', 'Prober' }... % Strategy names
            );

            legendstrings=cell(totalstrategies,1);
            for n=1:totalstrategies
                legendstrings{n}= namesofstrategies(strategiesArray(n)); 
            end

            hlegend = legend(h,legendstrings,'location','bestoutside', 'Orientation', 'horizontal');
            set(hlegend,'Interpreter','latex');

            a = tic;

            for k = 1:numofgenerations
                for i = 1:totalstrategies
                    addpoints(h(i), x(k) , popHistory(k,i))
                end
                b = toc(a);
                if b>(1/20000)    
                    drawnow
                    a = tic;
                end
            end
        end
    end
end