function result = snapshot_operating(snapshot_period,xn_dim,r,r_max,dead_num,n,node,xn,sink)
keydown = waitforbuttonpress;
% 点击鼠标
if (keydown == 0)
    % 提示信息
    msg = msgbox('Mouse button was pressed for snapshot shooting.');
    drawnow
    waitfor(msg);
    
    % 截图
    snapshot_pic_saving(r)
    
    % 保存数据
    snapshot_data_saving(xn_dim,r,n,node,xn,sink);
    
    % simulation report
    fprintf('round:  %d\n', r)
    fprintf('%d dead nodes\n', dead_num)
    sink.info_matrix; % dummy line
    eval('sink_info = sink.info_matrix')
    disp('--------------------------------')
    
    % 更改snapshot_period，方便观测
    if (r < r_max) && (snapshot_period ~= 1)
        result = question_dialog_showing(snapshot_period);
    else
        result = snapshot_period;
    end
else
    % 按键盘任意键
    % 更改snapshot_period，方便观测
    if r < r_max
        result = question_dialog_showing(snapshot_period);
    else
        result = snapshot_period;
    end
end