if(round==1)
    player.move = 1;
else
    player.move = player.opponent_history(round-1);
end