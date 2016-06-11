% 返回当前节点群号，与其最近群首的距离^2
function result = min_distance_cluster_tracing(i,available_node_set,node)
    % 最小距离初值
    min_distance_square = ...
        ( node(i).xd - node(available_node_set(1)).xd )^2 + ( node(i).yd - node(available_node_set(1)).yd )^2;
    min_distance_cluster_number = 1;
    % 比较该节点到各群首距离，记录最小距离、群号
    for j = 2:size(available_node_set,1)
        temp = min( min_distance_square,...
            ( node(i).xd - node(available_node_set(j)).xd )^2 + ( node(i).yd - node(available_node_set(j)).yd )^2 );
        if (temp < min_distance_square)
            min_distance_square = temp;
            min_distance_cluster_number = j;
        end
    end
    result = [min_distance_cluster_number min_distance_square];