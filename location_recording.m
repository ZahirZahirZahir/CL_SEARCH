function result = location_recording(n,node)
location = zeros(n,2);
for i = 1:n
    location(i,1) = node(i).xd;
    location(i,2) = node(i).yd;
end
result = location;