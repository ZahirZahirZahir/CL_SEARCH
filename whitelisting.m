function result = whitelisting(n,node)
whitelist = zeros(n,1);
for i = 1:n
    if node(i).Group_N_CH > 0
        whitelist(i) = i;
    end
end
whitelist(whitelist == 0) = [];
result = whitelist;