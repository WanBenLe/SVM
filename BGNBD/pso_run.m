
% ��Ⱥ����.��������.����Ȩ��.�ֲ�ѧϰ����.ȫ��ѧϰ����.��Ϣ�������.���Ȩ��
% ���������������Ӽ���ʱ��,Ҳ���ӻ�����Ž�Ŀ�����
% ������Ҫʹ��num_k��num_n���(���п�ɾ)
num_n=20;
num_k=100;

% �ͽ��۶��������������ʲô,��Ҫ����޸�(���п�ɾ)
par_1=0.7;
par_2=2.05;
par_3=2.05;
par_4=0.66;
par_5=0.3;

hello=4;

% ����ÿ�ε����½��Ĺ���Ȩ��
w_down=(par_1-par_5)/num_k; 

% ��ȡ����
[Data.data0,~] = xlsread('data0.xlsx');


            
% PSO�㷨
% 0������Ϊ0�ǳ�ʼ��
g_best=rand(4,1)*hello
g_cost=cost_fun(Data,g_best)
cost_num=[g_cost];
g_cost1=g_cost;

for i=1:num_k
	for j=1:num_n
		% ���������
		one_slove=rand(4,1)*hello;
		one_cost=cost_fun(Data,one_slove);
		% �ֲ����ź�ȫ�����ŵĸ��ºͳ�ʼ��
        if one_cost>g_cost   && (one_slove(3))>0.1 && (one_slove(4))<4
			p_best=one_slove;
			g_best=one_slove;
			p_cost=one_cost;
			g_cost=one_cost;
		elseif j==1|| (one_cost>p_cost && one_slove(3)>0.1 && one_slove(4)<4 
			p_best=one_slove;
			p_cost=one_cost;
		% �ܵ�p_best��g_bestӰ��,����cost
		elseif rand(1,1)<par_4
            for k=1:4
				one_slove(k)=one_slove(k)*par_1+rand(1,1)*par_2*(p_best(k)-one_slove(k))+rand(1,1)*par_3*(g_best(k)-one_slove(k));
                if one_slove(k)<0.0001
                    one_slove(k)=0.0001;
                end
            end
            
			one_cost=cost_fun(Data,one_slove);
			% ����g_best��p_best
			if one_cost>p_cost  && (one_slove(3))>0.1 && (one_slove(4))<4 
				p_best=one_slove;
				p_cost=one_cost;
			end
			if one_cost>g_cost  && (one_slove(3))>0.1 && (one_slove(4))<4 
				g_best=one_slove;
				g_cost=one_cost;  
			end
        end
	end
	% �½�Ȩ��
    cost_num=[cost_num;g_cost];
	par_1=par_1-w_down;
end

% ��ͼ
x=1:1:size(cost_num,1);  
plot(x,cost_num,'-r');  
hold on  
polt_1=-1150;
polt_2=-950;
axis([1,size(cost_num,1),polt_1,polt_2])  
set(gca,'XTick',[0:num_k/10:size(cost_num,1)]) 

set(gca,'YTick',[polt_1:0.2*(polt_2-polt_1):polt_2]) 
xlabel('����LL�仯����')  
ylabel('LL')  


'r.alpha.a.bΪ'
g_best'

'������Ȼ����Ϊ'
LL=cost_fun(Data,g_best)

