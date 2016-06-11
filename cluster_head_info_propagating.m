function result = cluster_head_info_propagating(i,available_node_set,node,sink)
for j = 1:size(node(available_node_set(i)).CH_info,1)
    sink.info_matrix(node(available_node_set(i)).CH_info(j,1),:) = ...
        node(available_node_set(i)).CH_info(j,:);
end
result = sink;