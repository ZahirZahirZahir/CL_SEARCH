% 1275 lines
%% notation
% SEARCH protocol
% normal node:   o
% advanced node: +
% number of CHs changes according to alive node amount:
% n_CH = ceil((n - dead_num) * P)
% update whole Group_N_CH set to 1
% iff.
% 1.all alive normal nodes have become CH one time in current epoch
% 2.all alive advanced nodes have become CH (1+a) times in current epoch

% 每轮以前一轮剩余总能量计算当前轮节点平均剩余能量
% E_avg = remained_total_energy_array(r-1)/(n-dead_num)
% 首轮时
% E_avg = E0*(1+a*m)
% WSN可运作至全部节点死亡

% 逐个选择群首阈值修正准则
% 节点至群首距离修正
% (min_node_CH(i)/mean_node)^aleph
% 节点至BS距离修正
% (mean_BS/dist_BS_vector(i))^beta
% 每轮选择首个群首时，仅作节点至BS距离修正

%% thorough cleanup
close all
clear
clc

%% 参数设置
% 界面录入
prompt = {'field width(height) length:','cell length:'...
    'Cluster Head percent:','number of nodes:','advanced node ratio',...
    'additional energy factor','max number of rounds:'...
    'dimensions of unknown signal:','message bits:','sink.xd:','sink.yd:',...
    'snapshot period(rounds):','Node energy E0:'};
dlg_title = 'Field constructing';
blank_lines_size = [1 38];
def = {'100','50','0.05','100','0.2','3','8000','2','2000','50','175','1000','0.25'};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
answer = inputdlg(prompt,dlg_title,blank_lines_size,def,options);

if sum(size(answer)) == 0
    msg = msgbox('No data input!',...
        'Oops~');
    drawnow
    waitfor(msg);

    % 清除中间变量
    clear
    return
end

width  = str2double(answer{1,1});
height = width;

% 每个cell 边长
cn_cell = str2double(answer{2,1});

% 群首占节点总数的百分比；节点被选为群首的最佳概率
P = str2double(answer{3,1});

% 节点个数
n = str2double(answer{4,1});

% advanced node ratio
m = str2double(answer{5,1});

% additional energy factor
a = str2double(answer{6,1});

% 最大回合数
r_max = str2double(answer{7,1});

% 未知信号维度
xn_dim = str2double(answer{8,1});

% 未知信号比特数
signal_bit = str2double(answer{9,1});

% 信宿位置信息
sink = struct(...
    'xd', 0,...
    'yd', 0,...
    'info_matrix', zeros((width/cn_cell)^2,xn_dim + 1));

% 信宿横坐标
sink.xd = str2double(answer{10,1});

% 信宿纵坐标
sink.yd = str2double(answer{11,1});

% snapshot 周期
snapshot_period = str2double(answer{12,1});

% 初始能量
E0 = str2double(answer{13,1});

%% 其他衍生参数
% 死亡节点个数
dead_num = 0;

% Eelec = Etx = Erx
% 单个节点传输(radio expends不计算在内)或接收1 bit信号耗费的能量
Eelec = 50*0.000000001;

% d < d0, free space model
% Etx = signal_bit * (Eelec + Efs * d^2)
Efs = 10*0.000000000001;

% d > d0, multipath model
% Etx = signal_bit * (Eelec + Emp * d^4)
Emp = 0.0031*0.000000000001;

% 单个群首融合1 bit信号耗费的能量
EDA = 5*0.000000001;

% 计算d0^2,能耗模型参照参数
d0_square = Efs/Emp;

% 未知信号，各行第一个元素标识cell编号
xn = [(1:(width/cn_cell)^2)' rand((width/cn_cell)^2,xn_dim)];

% network life time
x_round_array = (1:r_max)';
y_alive_node_array = zeros(r_max,1);

% throughput
y_packets_BS_array = zeros(r_max,1);

% total energy dissipated
initial_total_energy = n*E0*(1+a*m);
remained_total_energy_array = zeros(r_max,1);

% cluster head amount
n_CH_array = zeros(r_max,1);

%%
rng(0)

% 节点至群首距离指数
aleph = 1.4;

% 节点至BS距离指数
beta  = 2.6;

%% 提示信息
instruction_showing(snapshot_period)
disp('SEARCH protocol')
fprintf('m = %1.1f\n',m)
fprintf('aleph = %1.1f\n',aleph)
fprintf('beta  = %1.1f\n',beta)
fprintf('\n')

%% 生成LEACH网络
% 随机抛撒节点
% advanced node set
advanced_node_set = randperm(n,floor(m*n))';
node = node_generating(width,height,cn_cell,P,n,a,E0,xn,advanced_node_set);

% 各节点位置
location_matrix = location_recording(n,node);
% 各节点之间距离
dist_node_matrix = node_ranging(n,location_matrix);
% 各节点到BS距离
dist_BS_vector = BS_ranging(n,location_matrix,sink);

%% LEACH operating
for r = 1:r_max
    %% 清除上一轮残留信息
    % 清除上一轮节点记录的群首类型，群首信息矩阵
    node = clear_node_type(n,node,advanced_node_set);
    % 清除信宿信息矩阵
    sink.info_matrix = zeros((width/cn_cell)^2,xn_dim + 1);
    % 设定群首个数
    n_CH = ceil((n - dead_num) * P);
    
    %% 选择最优个数 n_CH = ceil((n - dead_num) * P) 个群首
    % 决定群首阈值
    node = threshold_deciding(r,P,n,m,a,E0,node,advanced_node_set,remained_total_energy_array,dead_num);
    
    if n_CH > 0
        %         if r < R
        group_counter = group_counting(n,node);
        if group_counter > n_CH
            % 搜寻符合要求的节点标号集合
            available_node_set = ...
                available_node_searching(n,n_CH,node,dist_node_matrix,dist_BS_vector,aleph,beta);
        elseif group_counter == n_CH
            available_node_set = ...
                relax_available_node_searching(n,group_counter,node);
        else
            % 无足够群首节点候选(节点能量未耗尽，但1/P回合内已做过群首)
            if group_counter > 0
                % 1/P回合内未做群首的节点均选作群首
                pre_part_set = ...
                    relax_available_node_searching(n,group_counter,node);
                
                % 批量更新Group值
                node = pre_mature_group_updating(n,a,node,pre_part_set);
                
                % 从余下部分选择剩余群首
                post_part_set = ...
                    remaining_node_searching(n,n_CH - length(pre_part_set),node,pre_part_set,dist_node_matrix,dist_BS_vector,aleph,beta);
                available_node_set = [pre_part_set;post_part_set];
            else
                % group_counter == 0,批量更新Group值
                node = pre_mature_group_updating(n,a,node,[]);
                group_counter = group_counting(n,node);
                if group_counter >= n_CH
                    % 搜寻符合要求的节点标号集合
                    available_node_set = ...
                        available_node_searching(n,n_CH,node,dist_node_matrix,dist_BS_vector,aleph,beta);
                else
                    % 无候选节点，WSN终止运作
                    termination_dialog_showing(r,dead_num)
                    
                    y_alive_node_array(r:end,1) = y_alive_node_array(r-1);
                    y_packets_BS_array(r:end,1) = y_packets_BS_array(r-1);
                    remained_total_energy_array(r:end,1) = remained_total_energy_array(r-1);
                    total_energy_dissipated_array = -diff([initial_total_energy;remained_total_energy_array]);
                    WSN_parameters_plotting(x_round_array,y_alive_node_array,y_packets_BS_array,total_energy_dissipated_array,n_CH_array)
                    
                    % 清除中间变量
                    clearvars -except available_node_set node signal_bit sink xn...
                        x_round_array y_alive_node_array y_packets_BS_array total_energy_dissipated_array n_CH_array
                    return
                end
            end
        end
        %         else
        %             % 实际round超出理论值，每轮平均能耗E_avg无法估计
        %             disp('R overloading.')
        %             fprintf('\n')
        %             R_tag = 0;
        %
        %             % 记录回合信息
        %             y_alive_node_array(r:end,1) = y_alive_node_array(r-1);
        %             y_packets_BS_array(r:end,1) = y_packets_BS_array(r-1);
        %             remained_total_energy_array(r:end,1) = remained_total_energy_array(r-1);
        %             break
        %         end
    else
        % 死亡节点过多，WSN停止工作
        termination_dialog_showing(r,dead_num)
        
        y_packets_BS_array(r:end,1) = y_packets_BS_array(r-1);
        total_energy_dissipated_array = -diff([initial_total_energy;remained_total_energy_array]);
        WSN_parameters_plotting(x_round_array,y_alive_node_array,y_packets_BS_array,total_energy_dissipated_array,n_CH_array)
        
        % 清除中间变量
        clearvars -except available_node_set node signal_bit sink xn...
            x_round_array y_alive_node_array y_packets_BS_array total_energy_dissipated_array n_CH_array
        return
    end
    
    % 更新符合群首要求的节点信息
    node = available_node_updating(available_node_set,node);
    
    %% 图示
    figure(1);
    clf
    hold on
    
    % 以cell为单位划分场地
    field_ploting(width,height,cn_cell)
    title(['SEARCH round: ' num2str(r) '  nCH: ' num2str(length(available_node_set))],'FontSize',13,'FontName','Times New Roman')
    
    %% 群首区隔
    cluster_head_partitioning(available_node_set,node)
    
    %% 节点就近入群，向群首传递信息
    node = ...
        node_operating(n,available_node_set,d0_square,signal_bit,Eelec,Efs,Emp,node);
    
    %% 群首向信宿传递信息
    for i = 1:length(available_node_set)
        % 清除群首信息矩阵0值
        node = cluster_head_info_assembling(i,available_node_set,node);
        
        % 群首向信宿传递信息
        sink = ...
            cluster_head_info_propagating(i,available_node_set,node,sink);
        
        % 群首能耗
        node = ...
            cluster_head_energy_dissipating(i,available_node_set,d0_square,signal_bit,Eelec,EDA,Efs,Emp,node,sink);
        
        % 信息传递完成，若群首死亡，则加以标注
        if node(available_node_set(i)).energy <= 0
            node_ploting(available_node_set(i),node)
        end
    end
    
    %% 记录死亡节点信息
    for i = 1:n
        % 通过节点类型判定是否本轮产生的死亡节点，记录死亡节点总数
        if (node(i).energy <= 0 ) && (strcmp(node(i).type,'Dead') == 0)
            node(i).type = 'Dead';
            node(i).cluster_number = 0;
            node(i).Group_N_CH = -1;
            node(i).info = zeros(1,xn_dim + 1);
            node(i).CH_info = [];
            node(i).member_amount = 0;
            dead_num = dead_num + 1;
            
            % first blood
            if dead_num == 1
                first_dead_node_dialog_showing(r)
            end
        end
    end
    
    %% 记录回合信息
    y_alive_node_array(r) = n - dead_num;
    
    if r > 1
        y_packets_BS_array(r) = y_packets_BS_array(r-1) + length(available_node_set);
    elseif r == 1
        y_packets_BS_array(r) = n_CH;
        % vigil of a sentinel
    else
        y_packets_BS_array(r) = -1;
    end
    
    remained_total_energy_array(r) = total_energy_calculating(n,node);
    n_CH_array(r) = length(available_node_set);
    
    %% snapshot for every snapshot_period rounds
    if mod(r,snapshot_period) == 0
        % 可更改snapshot_period以方便观测
        snapshot_period = ...
            snapshot_operating(snapshot_period,xn_dim,r,r_max,dead_num,n,node,xn,sink);
    end
end
% 标注信宿位置
% plot(sink.xd,sink.yd,'*',...
%     'LineWidth',2,...
%     'MarkerEdgeColor','b',...
%     'MarkerSize',13);

%% simulation report
total_energy_dissipated_array = -diff([initial_total_energy;remained_total_energy_array]);
WSN_parameters_plotting(x_round_array,y_alive_node_array,y_packets_BS_array,total_energy_dissipated_array,n_CH_array)

fprintf('maximum number of rounds: %d\n', r_max);
fprintf('number of nodes:          %d\n', n);
fprintf('number of Cluster Heads:  %d\n', length(available_node_set));
fprintf('death toll:               %d\n', dead_num);

%% 清除中间变量
clearvars -except E0 advanced_node_set available_node_set a m node signal_bit sink xn...
    x_round_array y_alive_node_array y_packets_BS_array total_energy_dissipated_array n_CH_array