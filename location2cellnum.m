% input : cell坐标，如(0,0)；场地宽、高；cell边长
% output: cell编号，如 1
% cell编号从1开始
function result = location2cellnum(width,height,cn_cell,cell_location)
% cell坐标起点位置
cell_xd = 0;
cell_yd = 0;
% horizontal cell 计数器
k = 1;
% 最大cell编号
max_cell_number = width*height/(cn_cell^2);

for i = 1:max_cell_number
    
    if isequal(cell_location,[cell_xd cell_yd]) == 1
        % 匹配到当前location编号，返回编号值
        result = i;
        break
    end
    
    if k < width/cn_cell
        if cell_xd < width
            % 更新横坐标位置，匹配for循环中i编号的增长
            cell_xd = cell_xd + cn_cell;
            k = k + 1;
        else
            disp('Invalid cell_xd!')
            return
        end
    else
        % 已到horizontal end,cell编号从上一行最左端重新开始
        k = 1;
        if cell_yd < height
            cell_yd = cell_yd + cn_cell;
            cell_xd = 0;
        else
            disp('Invalid cell_yd!')
            return
        end
    end
end
end