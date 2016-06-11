function cluster_head_partitioning(available_node_set,node)
if size(available_node_set,1) > 2
    % 初始化群首坐标矩阵
    CH_x = zeros(size(available_node_set));
    CH_y = zeros(size(available_node_set));
    for i = 1:size(available_node_set,1)
        CH_x(i) = node(available_node_set(i)).xd;
        CH_y(i) = node(available_node_set(i)).yd;
    end
    voronoi(CH_x,CH_y);
end