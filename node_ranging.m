% 各节点之间距离
function result = node_ranging(n,location)
dist_node = zeros(n,n);
for i = 1:n-1
    for j = i+1:n
        dist_node(i,j) = ...
            sqrt( (location(i,1) - location(j,1))^2 + (location(i,2) - location(j,2))^2 );
    end
    % dist_2to1 = dist_1to2
    dist_node(i+1,1:i) = dist_node(1:i,i+1);
end
result = dist_node;