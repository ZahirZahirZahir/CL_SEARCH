function result = ...
    node_energy_dissipating(i,min_distance_square,d0_square,signal_bit,Eelec,Efs,Emp,node)
% ½ÚµãÄÜºÄ
if min_distance_square <= d0_square
    node(i).energy = ...
        node(i).energy - signal_bit * (Eelec + Efs * min_distance_square);
else
    node(i).energy = ...
        node(i).energy - signal_bit * (Eelec + Emp * (min_distance_square)^2);
end
result = node;