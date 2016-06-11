% 根据节点--群首距离，节点--BS距离适当调整阈值
function result = fittest_threshold_adjusting(n,node,candidate_set,dist_node_matrix,dist_BS_vector,aleph,beta)
threshold_vector = zeros(n,1);
% 节点到各群首距离
node_CH = dist_node_matrix(:,candidate_set);
% 节点到某群首最短距离
min_node_CH = min(node_CH,[],2);
% 可选节点名单
whitelist = whitelisting(n,node);

mean_node = mean(min_node_CH(whitelist,1));

mean_BS = mean(dist_BS_vector(whitelist,1));

for i = 1:n
    threshold_vector(i) = node(i).threshold * ...
        (min_node_CH(i)/mean_node)^aleph * ...
        (mean_BS/dist_BS_vector(i))^beta;
end
result = threshold_vector;