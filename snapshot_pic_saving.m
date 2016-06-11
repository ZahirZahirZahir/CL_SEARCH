function snapshot_pic_saving(r)
%% 获取图像
% 获取整个窗口内容的图像
% gcf: get current figure
% F_window=getframe(gcf);

%% 以指令保存
file_name = ...
    sprintf('round %d',r);
% imwrite(F_window.cdata,strcat(eval('file_name'),'.fig'))
saveas(gcf,strcat(eval('file_name'),'.fig'))