function result = ...
    node_operating(n,available_node_set,d0_square,signal_bit,Eelec,Efs,Emp,node)
for i = 1:n
    if (node(i).energy > 0) && ~ismember(i,available_node_set)
        % 节点入群
        node = ...
            node_clustering(i,available_node_set,d0_square,signal_bit,Eelec,Efs,Emp,node);
        
        % 标注节点
        node_ploting(i,node)
        
    elseif (node(i).energy <= 0) && ~ismember(i,available_node_set)
        % 节点能量已耗尽，仅标注
        node_ploting(i,node)
    else
        % 标注群首
        cluster_head_ploting(i,node)
    end
end
result = node;