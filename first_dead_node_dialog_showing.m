function first_dead_node_dialog_showing(r)
msg = warndlg('Dead node emerges!');
drawnow
waitfor(msg);
fprintf('first dead node in round: %d\n',r)
fprintf('\n')