function [M, mcTheory] = theoryGraphs(allcurrentstates, allnextstates, allprobs, N, alluniquestates)

    % Find unique current states (unique system states)
    % allcurrentuniquestates=unique(allcurrentstates);
    % Find all unique states in string format in the right order
    for i=1:size(alluniquestates,1)
        allcurrentuniquestates(i) = "("+num2str(alluniquestates(i,1))+","+num2str(alluniquestates(i,2))+","+num2str(alluniquestates(i,3))+")";
    end

    % Initialize transition matrix
    M=zeros(size(allcurrentuniquestates,1),size(allcurrentuniquestates,1));
    
    % Add transitions found
    % allcurentstates(i)   allnextstates(i) allprobs(i)
    for i=1:size(allcurrentstates,1)
        M(find(ismember(allcurrentuniquestates,allcurrentstates(i))),...
          find(ismember(allcurrentuniquestates,allnextstates(i)))) =...
          allprobs(i);
    end
    
    % Create the Markov chain model. Specify the state names. 
    mcTheory = dtmc(M, StateNames=allcurrentuniquestates);
    
    % One step transition matrix M heatmap
    figure
    imagesc(M)
    colorbar
    axis square
    h = gca;
    h.XTick = 1:size(allcurrentuniquestates,1);
    h.YTick = 1:size(allcurrentuniquestates,1);
    title("One-step transition matrix M heatmap")
    
    % 8-step transition matrix M^8 heatmap
    figure
    imagesc(M^8)
    colorbar
    axis square
    h = gca;
    h.XTick = 1:size(allcurrentuniquestates,1);
    h.YTick = 1:size(allcurrentuniquestates,1);
    title("8-step transition matrix M^8 heatmap")
    
    % k-step transition matrix M^k heatmap (k big)
    figure
    imagesc(M^100)
    colorbar
    axis square
    h = gca;
    h.XTick = 1:size(allcurrentuniquestates,1);
    h.YTick = 1:size(allcurrentuniquestates,1);
    title("k-step (k big) transition matrix M^k heatmap")
    
    % Digraph of the Markov chain
    figure
    % h1 = graphplot(mc, ColorEdges=true);
    h2 = graphplot(mcTheory, ColorEdges=true, ColorNodes=true);
    colormap('jet');
    
    % Graph in special form
    graphPlot(mcTheory, M, alluniquestates, N);
    
    % M^k evolution
    figure
    axis square
    h = gca;
    h.XTick = 1:size(allcurrentuniquestates,1);
    h.YTick = 1:size(allcurrentuniquestates,1);
    title("k-step transition matrix evolution")
    
    for i=1:100
        colorbar
        imagesc(M^i)
        pause(0.3)
    end

end