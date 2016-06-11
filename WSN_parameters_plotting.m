function WSN_parameters_plotting(x_round_array,y_alive_node_array,y_packets_BS_array,total_energy_dissipated_array,n_CH_array)
%% alive nodes
figure_alive_nodes = figure;
axis = axes('Parent',figure_alive_nodes,'YMinorTick','on','XMinorTick','on');
box(axis,'on');
grid(axis,'on');
hold(axis,'all');
plot(x_round_array,y_alive_node_array,'LineWidth',2,'Color',[0 0 1]);
xlabel('number of rounds','FontSize',12,'FontName','Times New Roman');
ylabel('number of alive nodes','FontSize',12,'FontName','Times New Roman');
title('Alive Nodes','FontWeight','demi','FontSize',13,'FontName','High Tower Text');
var_name = ...
        sprintf('aNodes %dr',size(x_round_array,1));
% �Ƿ񱣴�ͼƬ
pic_saving(var_name)

%% packets to BS
figure_packets_BS = figure;
axis = axes('Parent',figure_packets_BS,'YMinorTick','on','XMinorTick','on');
box(axis,'on');
grid(axis,'on');
hold(axis,'all');
plot(x_round_array,y_packets_BS_array,'LineWidth',2,'Color',[0 1 0]);
xlabel('number of rounds','FontSize',12,'FontName','Times New Roman');
ylabel('number of packets','FontSize',12,'FontName','Times New Roman');
title('Packets to BS','FontWeight','demi','FontSize',13,'FontName','High Tower Text');
var_name = ...
        sprintf('packets %dr',size(x_round_array,1));
% �Ƿ񱣴�ͼƬ
pic_saving(var_name)

%% total energy dissipated
figure_total_energy_dissipated = figure;
axis = axes('Parent',figure_total_energy_dissipated,'YMinorTick','on','XMinorTick','on');
box(axis,'on');
grid(axis,'on');
hold(axis,'all');
plot(x_round_array,total_energy_dissipated_array,'LineWidth',2,'Color',[1 0 0]);
xlabel('number of rounds','FontSize',12,'FontName','Times New Roman');
ylabel('total energy dissipated(J)','FontSize',12,'FontName','Times New Roman');
title('Total Energy Dissipated','FontWeight','demi','FontSize',13,'FontName','High Tower Text');
var_name = ...
        sprintf('tEnergy %dr',size(x_round_array,1));
% �Ƿ񱣴�ͼƬ
pic_saving(var_name)

%% CH amount
figure_n_CH_array = figure;
axis = axes('Parent',figure_n_CH_array,'YMinorTick','on','XMinorTick','on');
box(axis,'on');
grid(axis,'on');
hold(axis,'all');
plot(x_round_array,n_CH_array,'LineWidth',2,'Color',[0 0.5 0.5]);
xlabel('number of rounds','FontSize',12,'FontName','Times New Roman');
ylabel('number of CHs','FontSize',12,'FontName','Times New Roman');
title('CH Amount','FontWeight','demi','FontSize',13,'FontName','High Tower Text');
var_name = ...
        sprintf('nCH %dr',size(x_round_array,1));
% �Ƿ񱣴�ͼƬ
pic_saving(var_name)

%% plotting data
headers = {'round','aNodesMp','pBSMp','tdEnergyMp','nCHMp'};
pic_data = [x_round_array y_alive_node_array y_packets_BS_array total_energy_dissipated_array n_CH_array];
var_name = ...
        sprintf('SEARCH %dr',size(x_round_array,1));
plotting_data_saving('E:\stata workspace\WSNs\',var_name,[headers;num2cell(pic_data)])