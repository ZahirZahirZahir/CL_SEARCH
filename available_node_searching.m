function result = available_node_searching(n,n_CH,node,dist_node_matrix,dist_BS_vector,aleph,beta)
available_node_set = zeros(n_CH,1);
% 群首个数计数器
j = 0;
% 各节点选作群首阈值
threshold_vector = threshold_recording(n,node);
% 可选节点名单
whitelist = whitelisting(n,node);
mean_BS = mean(dist_BS_vector(whitelist,1));
% 根据节点与BS距离初次更新阈值
threshold_vector = threshold_vector .* (mean_BS ./ dist_BS_vector).^beta;

while j < n_CH
    for i = 1:n
        % 分配一个(0,1)之间的随机数并与阈值比较
        random_num = rand;
        
        if threshold_vector(i) > random_num && ...
                node(i).Group_N_CH > 0 && ...
                node(i).energy > 0 && ...
                ~ismember(i,available_node_set)
            available_node_set(j+1) = i;
            j = j + 1;
            % 限定群首数目
            if j == n_CH
                break
            end
            
            % 根据节点--群首距离，节点--BS距离适当调整阈值
            if j > 1
                candidate_set = available_node_set(available_node_set ~= 0);
                threshold_vector = fittest_threshold_adjusting(n,node,candidate_set,dist_node_matrix,dist_BS_vector,aleph,beta);
            end
        end
    end
end
result = available_node_set;