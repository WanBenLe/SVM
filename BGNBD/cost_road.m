function [cost]=cost_road(L_var,P_var)
% ����
% L_var:����
% P_var:����
% ���
% cost:��·����ɱ�

if P_var<=10.0
	cost=0.3007*L_var+46.049;
elseif P_var<=20.0
	cost=0.3232*L_var+49.586;
elseif P_var<=33.0
	cost=0.2870*L_var+49.586;
else
	cost=0.2780*L_var+41.736;
end
cost=cost*P_var;