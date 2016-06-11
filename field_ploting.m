% 构建场地，划分单位cell
function field_ploting(width,height,cn_cell)
% 设置坐标轴范围
axis([0 width 0 height]);

% 设置坐标轴刻度
label_scale = cn_cell:cn_cell:width;
set(gca,'xtick',[0 label_scale])
set(gca,'ytick',label_scale)

box on
grid on

% 设置背景色为白色
% set(gcf,'color',[1 1 1])