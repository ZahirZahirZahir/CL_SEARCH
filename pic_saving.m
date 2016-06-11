function pic_saving(var_name)
% Construct a questdlg with two options
choice = questdlg(['Save ' eval('var_name') ' ?'], ...
    'Pic saving', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        % 获取整个窗口内容的图像
        % gcf: get current figure
        % F_window = getframe(gcf);
        % imwrite(F_window.cdata,strcat(eval('var_name'),'.jpg'))
        saveas(gcf,strcat(eval('var_name'),'.fig'))
        msg = msgbox('Pic saved !','Eureka');
        drawnow
        waitfor(msg);
    otherwise
        % dummy line
end