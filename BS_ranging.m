% 各节点到BS距离
function result = BS_ranging(n,location,sink)
dist_BS = zeros(n,1);
for i = 1:n
    dist_BS(i) = ...
        sqrt( (location(i,1) - sink.xd)^2 + (location(i,2) - sink.yd)^2 );
end
result = dist_BS;