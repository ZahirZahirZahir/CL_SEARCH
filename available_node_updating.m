function result = available_node_updating(available_node_set,node)
for i = 1:length(available_node_set)
    % 为符合条件的节点设置群首参数
    node(available_node_set(i)).type = 'CH';
    node(available_node_set(i)).Group_N_CH = ...
        node(available_node_set(i)).Group_N_CH - 1;
    node(available_node_set(i)).cluster_number = i;
    % 节点群首信息矩阵记录自身信息（无能耗）
    node(available_node_set(i)).CH_info(node(available_node_set(i)).info(1),:) = ...
        node(available_node_set(i)).info;
end
result = node;