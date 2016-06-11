function result = cluster_head_info_assembling(i,available_node_set,node)
% 标记群首信息矩阵中的全0行
zero_index = sum(node(available_node_set(i)).CH_info,2) == 0;
% 删除全0行
node(available_node_set(i)).CH_info(zero_index,:) = [];
result = node;