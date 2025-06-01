function simGraphs(Msim, Mk, MTheory, statenames, alluniquestates, ngens, N)

    % Create Markov chain models for the one-step transition matrix M and for the 
    % k-step (k big) final transition matrix Mk. Specify the state names. 
    mc1 = dtmc(Msim, StateNames=statenames);
    mc2 = dtmc(Mk, StateNames=statenames);
    
    % % Load from directory '../MarkovTheory/' TheoryOutput.mat putting one-step 
    % % transition matrix MTheory in workspace 
    % load ../MarkovTheory/TheoryOutput.mat;
    
    % Simulated one-step transition matrix Msim heatmap
    figure
    imagesc(Msim)
    colorbar
    axis square
    h = gca;
    h.XTick = 1:size(alluniquestates,1);
    h.YTick = 1:size(alluniquestates,1);
    title("Simulated one-step transition matrix (Msim) heatmap");
    
    % Theoretical one-step transition matrix MTheory heatmap
    figure
    imagesc(MTheory)
    colorbar
    axis square
    h = gca;
    h.XTick = 1:size(alluniquestates,1);
    h.YTick = 1:size(alluniquestates,1);
    title("Theoretical one-step transition matrix (MTheory) heatmap");
    
    clims = [0 1];
    % Heatmap of |Msim-Mtheory|
    figure
    imagesc(abs(Msim-MTheory), clims)
    colorbar
    axis square
    h = gca;
    h.XTick = 1:size(alluniquestates,1);
    h.YTick = 1:size(alluniquestates,1);
    title("Simulated vs theoretical difference |Msim-Mtheory| heatmap");
    
    % Theoretical k-step transition matrix (k big) Mtheory^k
    MTheoryk = MTheory^ngens;
    
    % Simulated k-step (k big) transition matrix Mk heatmap
    figure
    imagesc(Mk)
    colorbar
    axis square
    h = gca;
    h.XTick = 1:size(alluniquestates,1);
    h.YTick = 1:size(alluniquestates,1);
    title("Simulated k-step transition matrix Mk (k big) heatmap");
    
    % Theoretical k-step (k big) transition matrix Mtheory^k heatmap
    figure
    imagesc(MTheoryk)
    colorbar
    axis square
    h = gca;
    h.XTick = 1:size(alluniquestates,1);
    h.YTick = 1:size(alluniquestates,1);
    title("Theoretical k-step transition matrix Mtheory^k (k big) heatmap");
    
    % Heatmap of |Mk-Mtheory^100|
    figure
    imagesc(abs(Mk-MTheoryk), clims)
    colorbar
    axis square
    h = gca;
    h.XTick = 1:size(alluniquestates,1);
    h.YTick = 1:size(alluniquestates,1);
    title("Simulated vs theoretical difference |Mk-Mtheory^k| heatmap");
    
    % Digraph of the Markov chain for Msim
    figure
    h1 = graphplot(mc1, ColorEdges=true, ColorNodes=true);
    colormap('jet');
    
    % Digraph of the Markov chain for Mk
    figure
    h1 = graphplot(mc2, ColorEdges=true, ColorNodes=true);
    colormap('jet');

    % Graph in special form
    graphPlot(mc1, Msim, alluniquestates, N);
    
    % Differences per row
    difference1 = zeros(size(alluniquestates,1),1);
    difference2 = zeros(size(alluniquestates,1),1);
    for i=1:size(alluniquestates,1) 
        difference1(i) = sum(abs(Msim(i,:)-MTheory(i,:)), 'all');
        difference2(i) = sum(abs(Mk(i,:)-MTheoryk(i,:)), 'all');
    end
    
    figure
    scatter(1:size(alluniquestates,1),difference1);
    hold on;
    scatter(1:size(alluniquestates,1),difference2);
    legend
    grid;
    
    difference1all = sum(difference1(:));
    difference2all = sum(difference1(:));
    
    fprintf('Metric for Σ|Msim-Mtheory|: %.2f \n',difference1all);
    fprintf('Metric for Σ|Mk-Mtheory^k|: %.2f \n',difference2all);

end