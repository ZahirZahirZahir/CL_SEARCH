function result = ...
    node_clustering(i,available_node_set,d0_square,signal_bit,Eelec,Efs,Emp,node)
% 返回当前节点群号，与其最近群首的距离
min_distance_cluster_block = ...
    min_distance_cluster_tracing(i,available_node_set,node);

min_distance_cluster_number = min_distance_cluster_block(1);
min_distance_square = min_distance_cluster_block(2);

% 节点更新自身群号，向群首传递信息
node(i).cluster_number = min_distance_cluster_number;
node(available_node_set(min_distance_cluster_number)).CH_info(node(i).info(1),:) = ...
    node(i).info;
% 群首统计群成员数目
node(available_node_set(min_distance_cluster_number)).member_amount = ...
    node(available_node_set(min_distance_cluster_number)).member_amount + 1;

% 节点能耗
node = ...
    node_energy_dissipating(i,min_distance_square,d0_square,signal_bit,Eelec,Efs,Emp,node);
result = node;