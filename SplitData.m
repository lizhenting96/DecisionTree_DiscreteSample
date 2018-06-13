function [Data_Splited,Target_Splited,Different_Properties] = SplitData(trainfeatures,targets,No_of_Max)
Different_Properties = unique(trainfeatures(:,No_of_Max));%选中特征中，不同属性的集合
Data_Splited = cell(length(Different_Properties),1);
Target_Splited = cell(length(Different_Properties),1);
for i = 1:length(Different_Properties)
    Property_Position = find(trainfeatures(:,No_of_Max) == Different_Properties(i));%标记出原数据集中，选中特征下，含有第i个属性的位置
    Data_Splited{i} = trainfeatures(Property_Position,:);%Data_Splited(i)是一个矩阵，每一行都是一个样本，它们都含有选中特征下的属性i
    Target_Splited{i} = targets(Property_Position,:);%Target_Splited，与Data_Splited匹配，保证样本分开之后属性与分类的一致性
    Data_Splited{i}(:,No_of_Max) = [];
end