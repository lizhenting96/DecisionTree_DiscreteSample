function [Data_Splited,Target_Splited,Different_Properties] = SplitData(trainfeatures,targets,No_of_Max)
Different_Properties = unique(trainfeatures(:,No_of_Max));%ѡ�������У���ͬ���Եļ���
Data_Splited = cell(length(Different_Properties),1);
Target_Splited = cell(length(Different_Properties),1);
for i = 1:length(Different_Properties)
    Property_Position = find(trainfeatures(:,No_of_Max) == Different_Properties(i));%��ǳ�ԭ���ݼ��У�ѡ�������£����е�i�����Ե�λ��
    Data_Splited{i} = trainfeatures(Property_Position,:);%Data_Splited(i)��һ������ÿһ�ж���һ�����������Ƕ�����ѡ�������µ�����i
    Target_Splited{i} = targets(Property_Position,:);%Target_Splited����Data_Splitedƥ�䣬��֤�����ֿ�֮������������һ����
    Data_Splited{i}(:,No_of_Max) = [];
end