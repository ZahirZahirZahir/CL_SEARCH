function result = snapshot_period_changing(snapshot_period)
% Construct a questdlg with three options
choice = questdlg('Reset snapshot period:', ...
	'period changing', ...
	'1 round','5 rounds','10 rounds','10 rounds');
% Handle response
switch choice
    case '1 round'
        result = 1;
    case '5 rounds'
        result = 5;
    case '10 rounds'
        result = 10;
    otherwise
        % µã»÷¹Ø±Õ°´Å¥
        result = snapshot_period;
end