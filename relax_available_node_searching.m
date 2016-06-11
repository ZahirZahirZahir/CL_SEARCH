function result = relax_available_node_searching(n,n_CH,node)
available_node_set = zeros(n_CH,1);
% 群首个数计数器
j = 0;
while j < n_CH
    for i = 1:n
        if node(i).Group_N_CH > 0 && ...
                node(i).energy > 0 && ...
                ~ismember(i,available_node_set)
            available_node_set(j+1) = i;
            j = j + 1;
            % 限定群首数目
            if j == n_CH
                break
            end
        end
    end
end
result = available_node_set;