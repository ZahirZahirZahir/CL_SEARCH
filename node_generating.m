function result = node_generating(width,height,cn_cell,P,n,a,E0,xn,advanced_node_set)
for i=1:n
    % 节点（随机生成）
    xd = rand * width;
    yd = rand * height;
    cell_location = [ floor(xd/cn_cell)*cn_cell floor(yd/cn_cell)*cn_cell ];
    cell_number = location2cellnum(width,height,cn_cell,cell_location);
    
    node(i) = struct(...
        'xd', xd,...% 横坐标
        'yd', yd,...% 纵坐标
        'energy', E0,...% 节点能量
        'type', 'N',...% 节点类型(群首 or 普通节点 or 死亡节点)
        'cluster_number', 1,...% 节点群号
        'Group_N_CH', 1,...% 非群首集合(0: 不属于非群首集合; 非0: 属于非群首集合)
        'info', xn(cell_number,:),...% 节点信息数组，第一个元素表示节点所在cell的编号
        'CH_info', [],...% 节点被选作群首的信息矩阵
        'member_amount', 1,...% 群内节点数目
        'threshold', P);
end

% 更新 advanced node 初始能量，节点类型
for i = 1:length(advanced_node_set)
    node(advanced_node_set(i)).energy = (1+a)*E0;
    node(advanced_node_set(i)).type = 'AD';
    % 各 advanced node 在 1 epoch 内将(1+a)次成为群首
    node(advanced_node_set(i)).Group_N_CH = 1+a;
end
result = node';