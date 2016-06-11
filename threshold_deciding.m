function result = threshold_deciding(r,P,n,m,a,E0,node,advanced_node_set,remained_total_energy_array,dead_num)
for i = 1:n
    if r == 1
        E_avg = E0*(1 + a*m);
    else
        E_avg = remained_total_energy_array(r-1)/(n-dead_num);
    end
    if ~ismember(i,advanced_node_set)
        % normal node
        Pnrm = node(i).energy*P/((1 + a*m)*E_avg);
        node(i).threshold = Pnrm/(1 - Pnrm*(mod(r-1,round(1/Pnrm))));
    else
        % advanced node
        Padv = node(i).energy*(1 + a)*P/((1 + a*m)*E_avg);
        node(i).threshold = Padv/(1 - Padv*(mod(r-1,round(1/Padv))));
    end
end
result = node;