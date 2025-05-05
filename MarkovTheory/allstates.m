% Production of all states in the right order
% used in the transition matrix

% Total population
n = 20;

% Minimum and maximum number of a strategy's population in a generation
nmin = 0;
nmax = n;

alluniquestates = [];

for n1 = nmin:nmax
    % For each n2 from nmin to nmax-n1
    for n2 = nmin:nmax-n1
        % n3 is the rest from nmax
        n3 = nmax - n2 - n1;

        alluniquestates = [alluniquestates;[n1, n2, n3]];

    end
end

alluniquestates
