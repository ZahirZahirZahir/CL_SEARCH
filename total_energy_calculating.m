function result = total_energy_calculating(n,node)
% 计算当前round所有节点剩余总能量
remained_total_energy = 0;
for i = 1:n
    if node(i).energy > 0
        remained_total_energy = remained_total_energy + node(i).energy;
    end
end
result = remained_total_energy;