function instruction_showing(snapshot_period)
msg = msgbox({['Every ' num2str(snapshot_period) ' rounds'];...
    'SEP network pauses.';'';...
    'Press';'keyboard button to continue,';...
    'mouse button to snapshot.'});
% msg_handle = findobj(msg,'Type','text');
% set(msg_handle,'FontSize',10,'Unit','normal')
drawnow
waitfor(msg);
end