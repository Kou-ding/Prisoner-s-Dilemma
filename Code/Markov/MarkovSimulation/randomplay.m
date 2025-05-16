%% randomplay.m
% Creates a matrix with vector rows, in which 'C' appears with probabilities 
% equal to the conditional probabilities p(C|CC), p(C|CD), p(C|DC), p(C|DD).
%
%% Inputs:
%
%   rounds      : Number of columns of Cprobs, rounds in a match.
%   vectorp     : Vector with the conditional probabilities
%                 p(C|CC), p(C|CD), p(C|DC), p(C|DD).
%
%% Outputs:
%
%   Cprobs      : Matrix, 4 x rounds, where in each row, 'C' appears with the 
%                 respective conditional probability.
%                 Use '0' to denote 'C' and '1' to denote 'D'.
%
%% Example:
%
%
function Cprobs = randomplay(rounds, vectorp)
    
    % First line of 'Cprobs' is a vector of 'rounds' elements 
    % (random 0's or 1's) with probability vectorp(1) for '0' (i.e. p(C/CC)).
    % In an analogous way for the other lines of Cprobs.

    % Use a > 1 to get more than rounds elements in each row
    a = 1;
    rounds = a * rounds;

    % Initialization of CProbs
    Cprobs = zeros(size(vectorp,2),rounds);
    
    % For each row of Cprobs
    for i = 1:size(vectorp,2)
        
        % Number of Cs and Ds in 'rounds' elements 
        nCs = round(rounds*vectorp(i)); % # of Cs
        nDs = rounds - nCs;             % # of Ds
        % Random permutation of the 'rounds' integers in the region [1, rounds]
        order = randperm(rounds);
        % Ordered output, '0' for Cs, '1' for Ds
        temp = [zeros(1,nCs),ones(1,nDs)];
        % Randomly reorder the vector of 0's and 1's
        Cprobs(i,:) = temp(:,order);
    end

    % Cprobs   
    % checkrandom(vectorp, Cprobs(:,1:round(rounds/2)));
    % checkrandom(vectorp, Cprobs(:,1:round(rounds/2)));
end