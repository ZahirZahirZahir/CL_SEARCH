function termination_dialog_showing(r,dead_num)
% 死亡节点过多，LEACH停止工作
msg = warndlg({'Too much dead nodes !';'';'LEACH terminated.'});
drawnow
waitfor(msg);
disp('Too much dead nodes!')
fprintf('current round:  %d\n', r)
fprintf('%d dead nodes\n', dead_num)