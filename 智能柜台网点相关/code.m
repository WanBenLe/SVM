data1=xlsread('Trade.xlsx');
data2=xlsread('MIC.xlsx');
save=data2;
data3=xlsread('TIME.xlsx');
data4=xlsread('INS.xlsx');


micall=sum(data2);
micx=data2;
%�¹�����
x_3=23;

%���ܹ�̨ÿ̨���������ʱ��(min)
x_1=60*8;

%���ܹ�̨ʱ��ͷ�ϵ��
x_2=1.3;

data1=ceil(data1/x_3);

for i=1:size(data1,1)
for k=1:size(data1,2)
data1(i,k)=ceil((data1(i,k)/sum(data1(i))*ceil(data4(i)/x_3)));
end
end


result1=zeros(size(data1,1),size(data1,2));
result2=zeros(size(data1,1),size(data1,2));
result3=zeros(size(data1,1),size(data1,2));

data3(:,1)=data3(:,1)*x_2;
data2=data2*x_1;

for i=1:size(data1,1)
temp_time=data2(i,1);
for k =1:size(data1,2)
max1=floor(temp_time/(data3(k,1)*x_2));
if max1<0
max1=0;
end


if max1>data1(i,k) && max1>0
temp_time=temp_time-(data1(i,k)*data3(k,1)*x_2);
result2(i,k)=result2(i,k)+data1(i,k);
else

while (max1<=0 || max1<=data1(i,k))
temp_time=temp_time+x_1;
save(i,1)=save(i,1)+1;
max1=floor(temp_time/(data3(k,1)*x_2));


end
temp_time=temp_time-(data1(i,k)*data3(k,1)*x_2);
result2(i,k)=result2(i,k)+data1(i,k);

end
end
end

'�������豸��'
sum(save)

'�����������豸��'
save

'���������豸��'
sum(save)-micall

'���������������豸��'
save-micx