% 记录被选作CH的节点总数
function result = group_counting(n,node)
count = 0;
for i = 1:n
    if node(i).Group_N_CH > 0 && node(i).threshold > 0
        count = count + 1;
    end
end
result = count;