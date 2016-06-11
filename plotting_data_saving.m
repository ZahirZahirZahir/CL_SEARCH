function plotting_data_saving(saving_path,var_name,var)
% Construct a questdlg with two options
choice = questdlg(['Save ' eval('var_name') ' to .xls file ?'], ...
    'Data saving', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        xlswrite(strcat(eval('saving_path'),eval('var_name'),'.xls'),var)
        msg = msgbox('Data saved !','Eureka');
        drawnow
        waitfor(msg);
    otherwise
        % dummy line
end