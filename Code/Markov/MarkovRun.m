%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% README FIRST %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% You can change parameter values in initialize.m in the present directory.

evalin('base','clear');
clc;

%%%%%%%%%%%%%%%%%%%%
%% INITIALIZATION %%
%%%%%%%%%%%%%%%%%%%%

% Call initialize() for initialization
[p1, p2, p3, payoff, N, roundsth, roundssim, numofreps, alluniquestates, initprobs, ngens, predetermined, names, chosen] = initialize();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONTINUE WITH THE THEORETICAL PART %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Run the theoretical part
[Ps, allcurrentstates,allnextstates,allprobs, MTheory, mcTheory] = MarkovTheory(p1, p2, p3, payoff, N, roundsth, predetermined, alluniquestates);

prompt = "\nIf a predetermined outcome meeting was chosen, simulation is not an option. \n" + ... 
         "Do you want to continue with the simulation part in the case of non predetermined outcome meeting? Y/N [Y]: ";
% Read user input
textInput = input(prompt,"s");

% Default is 'YES'
if isempty(textInput)
    textInput = 'Y';
end

if textInput == 'N'
    fprintf('End of theoretical calculations. Simulation was not chosen.\n\n');
end

% Except in predetermined outcome meetings
if ~isempty(predetermined)
    textInput = 'N';
    % Info message
    fprintf('End of theoretical calculations. Simulation is not an option for predetermined outcome meetings.\n\n');
end

if textInput =='Y'

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% CONTINUE WITH THE SIMULATION PART %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % The one-step transition matrix resulting from simulation. Initialized 
    % to a zero matrix here, it is a global, changed only by the functions 
    % transferfromXtoY() and remaintosamestate() in function transitionRules(), 
    % whenever a state transition from a 'currentstate' to a 'nextstate' is 
    % performed 
    global Msim;
    
    fprintf('Markov simulation calculations...\n');
    
    % Start stopwatch timer
    start = tic;
    
    % Approximate time needed by my computer
    time = round(roundssim*ngens*(0.5*N*(N-1))*numofreps*2.05/1000);
    fprintf('Needs approximately %d seconds to execute with my computer\n', time);
    
    % Find all  names of the unique states AS STRINGS (i.e. (4,3,2)), needed
    % for the Markov chain model hereafter
    for i = 1:size(alluniquestates,1)
        statenames(i,1) = "("+num2str(alluniquestates(i,1))+","+num2str(alluniquestates(i,2))+","+num2str(alluniquestates(i,3))+")";
    end
    

    % Initialization of the one-step transition matrix
    Msim = zeros(size(alluniquestates,1), size(alluniquestates,1));

    % Initialization of the k-step (k big) transition matrix
    Mk = zeros(size(alluniquestates,1), size(alluniquestates,1));
    
    % Minimum and maximum number of a strategy's population in a generation
    nmin = 0;
    nmax = N;
    
    % Print a message
    fprintf('Starting processing. Start from each of the %d states as initial state and repeat %d times for every state. Be patient...\n', (N+1)*(N+2)/2, numofreps);
    
    % This is the 3-D matrix with all the history of population evolution
    % for plotting purposes. See here and in multimultigen.m and multigen.m for its
    % construction. In each submatrix of dimensions (3*numofreps x ngens+1)
    % we have evolutions starting from the same initial state. Each of
    % these evolutions corresponds to a (3 x ngens+1) matrix and we have
    % numofreps such evolutions. We have in total size(alluniquestates,1)
    % such submatrices.
    % Polulation evolution history
    allstatesrepgenNumOfPlayersHistory = zeros(3*numofreps, ngens+1, size(alluniquestates,1));
    % State sequential number
    stateno = 1;
    
    % Repeat for every different state
    for n1 = nmin:nmax
        % For each n2 from nmin to nmax-n1
        for n2 = nmin:nmax-n1
            % n3 is the rest from nmax
            n3 = nmax - n2 - n1;
    
            % This is the starting state 
            state = [n1, n2, n3];
            
            % Call multimultigen.m to do a simulation, for 'numofreps' repetitions, 
            % starting from the same state 'state'. Each time, a vector m is returned 
            % with the 'times' a final state was reached, when starting from 'state',
            % transformed to probabilities. This is row 'row' of Mk. The vector 
            % m and 'row' is built in multimultigen.m Repeat for all states.
            [row, m, repgenNumOfPlayersHistory] = multimultigen(p1, p2, p3, state, roundssim, payoff, initprobs, numofreps, alluniquestates, ngens);
            
            % Add the submatrix of dimensions (3*numofreps x ngens+1),
            % which corresponds to the specific initial state, returned by
            % multimultigen.m
            allstatesrepgenNumOfPlayersHistory(:,:, stateno) = repgenNumOfPlayersHistory;
            % Next state sequential number
            stateno = stateno + 1;
    
            % Put row vector m in the appropriate row of Mk 
            Mk(row,:) = m;
            
            % Print a message and time elapsed until now
            fprintf('Processed state %d of %d\n', row, size(alluniquestates,1));
            toc(start)
        end
    end
    
    % The global matrix Msim (one-step transition matrix has taken values in
    % transitionRules(). Here the values are normalized to probabilities per row, summing
    % to 1 per row.
    for i=1:size(alluniquestates,1)
        Msim(i,:) = Msim(i,:)/sum(Msim(i,:));
    end
    
    % Print the time elapsed until the end of simulation
    totaltime = toc(start);
    timeperround = totaltime * 1000  / (roundssim * ngens * (0.5 * N * (N - 1)) * numofreps);
    fprintf('Needed in reality %.2f msec per round', timeperround);
    
    % Prepare all theoretical graphs
    simGraphs(Msim, Mk, MTheory, statenames, alluniquestates, ngens, N);

    fprintf('End of theoretical and simulation calculations.\n');

end

