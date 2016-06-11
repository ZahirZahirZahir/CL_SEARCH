function result = threshold_recording(n,node)
threshold_vector = zeros(n,1);
for i = 1:n
    threshold_vector(i) = node(i).threshold;
end
result = threshold_vector;