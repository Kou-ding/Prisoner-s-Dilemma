function graphPlot(mc, M, alluniquestates, N)

    Mk = M^100;
    threshold=0.001;
    Mk(Mk < threshold) = 0;

    idx1 = find(ismember(alluniquestates, [N 0 0], 'rows'));
    idx2 = find(ismember(alluniquestates, [0 N 0], 'rows'));
    idx3 = find(ismember(alluniquestates, [0 0 N], 'rows'));

    S = Mk(:, [idx1,idx2,idx3]);

    G = digraph(mc.P);
    G = rmedge(G, 1:numnodes(G), 1:numnodes(G));

    figure()
    plot(G, 'XData', alluniquestates(:,2), 'YData', alluniquestates(:,3), 'NodeColor', S);

end