% Some opponent pairs
% 1: Random vs Random
% 2: ALL-C vs ALL-D
% 3: Random vs Tit-for-Tat
% 4: ALL-C vs Tit-for-Tat
% 5: Grim vs Tit-for-Tat
% 6: GTFT vs Random
% 7: Testing
choice = 7;

% Maximum iterations
maxiter=1500;

% Pay-off matrix
R = 3;
T = 5;
S = 0;
P = 1;

% Colors
colors=["#FFD900", 'r', 'b', 'k'];

switch(choice)
    case 1
        % Random vs Random
        %%%%%%%%%%%%%%%%%%
        u0=[0.25 0.25 0.25 0.25];
        % Conditional probabilities for first player
        p = [0.5 0.5 0.5 0.5];
        % Conditional probabilities for second player
        q = [0.5 0.5 0.5 0.5];
    case 2
        % ALL-C vs ALL-D
        %%%%%%%%%%%%%%%%
        u0=[0 1 0 0];
        % Conditional probabilities for first player
        p = [1 1 1 1];
        % Conditional probabilities for second player
        q = [0 0 0 0];
    case 3
        % Random vs Tit-for-Tat
        %%%%%%%%%%%%%%%%%%%%%%%
        u0=[0.5 0 0.5 0];
        % Conditional probabilities for first player
        p = [0.5 0.5 0.5 0.5];
        % Conditional probabilities for second player
        q = [1 0 1 0];
    case 4
        % ALL-C vs Tit-for-Tat
        %%%%%%%%%%%%%%%%%%%%%%
        u0=[1 0 0 0];
        % Conditional probabilities for first player
        p = [1 1 1 1];
        % Conditional probabilities for second player
        q = [1 0 1 0];
    case 5
        % Grim vs Tit-for-Tat
        %%%%%%%%%%%%%%%%%%%%%
        u0=[1 0 0 0];
        % Conditional probabilities for first player
        p = [1 0 0 0];
        % Conditional probabilities for second player
        q = [1 0 1 0];
    case 6
        % GTFT vs Random
        %%%%%%%%%%%%%%%%%%%%
        u0=[0.5 0.5 0 0];
        % Conditional probabilities for first player
        p = [1 0.2 1 0.2];
        % Conditional probabilities for second player
        q = [0.5 0.5 0.5 0.5];
    case 7
        % Testing
        %%%%%%%%%
        u0=[0.25 0.25 0.25 0.25];
        % Conditional probabilities for first player
%         p = [0.75 0.25 0.5 0.25]; % SET-2
%         p = [0.9 0.5 0.5 0.3]; % SET-2.5
        p = [1 0.9 0.15 0.1]; % SET-3
%         p = [0.875 0.4375 0.375 0]; % EXT-2
%         p = [0.68 0.16 0.36 0]; % EXT-5
%         p = [1 0 1 0];
%         p = [0 0 0.5 0.5]; %DDC

        % Conditional probabilities for second player
%         q = [0.75 0.25 0.5 0.25]; % SET-2
        q = [0.9 0.5 0.5 0.3]; % SET-2.5
%         q = [1 0.9 0.15 0.1]; % SET-3
%         q = [0.875 0.4375 0.375 0]; % EXT-2
%         q = [0.68 0.16 0.36 0]; % EXT-5
%         q = [1 0 1 0];
%         q = [0 0 0.5 0.5]; %DDC

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% One-step Transition matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = [p(1)*q(1) p(1)*(1-q(1)) (1-p(1))*q(1) (1-p(1))*(1-q(1));
     p(2)*q(3) p(2)*(1-q(3)) (1-p(2))*q(3) (1-p(2))*(1-q(3));
     p(3)*q(2) p(3)*(1-q(2)) (1-p(3))*q(2) (1-p(3))*(1-q(2));
     p(4)*q(4) p(4)*(1-q(4)) (1-p(4))*q(4) (1-p(4))*(1-q(4))];
disp("The transition matrix M is:")
disp(M)

%%%%%%%%%%%%%%%%%%%%%%%%%%
% k-step Transition matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%
Mlimit = M^(maxiter-1);
disp("Long run value of M^m is:")
disp(Mlimit)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate π from the limit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate π from the limit for large n
% Initialization
pie = [0 0 0 0];
% Histoty vector
allpies = [];

for i = 0:maxiter-1
    % Calculate π
    pie = pie + (u0 * M^i);
    % Memory of π changes in time
    allpies=[allpies; pie/(i+1)];
end

% Final π value
pie=pie/(maxiter+1);
disp("Stationary distribution π (long run value of non conditional probabilities):");
disp(pie);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate π by solving πM=π, Σπi=1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alternative calculation of pie (to be adopted)
syms x y z t;
[solx, soly, solz, solt] = solve([x y z t]*M(:,1) == x, [x y z t]*M(:,2) == y,...
                                 [x y z t]*M(:,3) == z, [x y z t]*M(:,4) == t,...
                                  x + y + z + t == 1, [x y z t]);
piealt = [solx, soly, solz, solt];

disp("Alternative calculation of stationary distribution π (long run value of non conditional probabilities):");
disp(double(piealt));

%%%%%%%%%%%%%%%%%%%%
% Calculate pay-offs
%%%%%%%%%%%%%%%%%%%%
% Mean expected pay-off of first player
pay_off1 = double(piealt*[R;S;T;P]);
disp("Mean expected pay-off of first player:");
disp(pay_off1);

% Mean expected pay-off of second player
pay_off2 = double(piealt*[R;T;S;P]);
disp("Mean expected pay-off of second player:");
disp(pay_off2);

%%%%%%%%%%
% Plotting
%%%%%%%%%%
% x-axis vector
is = 1:maxiter;

figure
% Plot evolution of π w.r.t. number of terms
for i=1:4
    h(i)=plot(is,allpies(:,i),'Color',colors(i),'LineWidth',2);
    hold on;
end
grid;
legendstrings{1}='π(1)'; legendstrings{2}='π(2)'; legendstrings{3}='π(3)'; legendstrings{4}='π(4)';
hlegend =legend(h,legendstrings,'location','bestoutside', 'Orientation', 'horizontal');
