function [Max_InfoGain,No_of_Max] = InfoGainDis(different_classes,targets,feature_num,example_num,trainfeatures)
pnode = zeros(1,length(different_classes));
for i = 1:length(different_classes)
    pnode(i) = length(find(targets == different_classes(i)))/length(targets);%对应的最终分类结果占总样本数的比例
end
EntD = -sum(pnode.*log(pnode)/log(2));%样本集的信息熵
Max_InfoGain = -1;%特征最大的信息增益
No_of_Max = -1;%第几个特征的信息增益最大
Feature_InfoGain = zeros(1,feature_num);%预设各个特征的信息增益都为0
for i = 1:feature_num
    different_properties = unique(trainfeatures(:,i));%第i个特征下的不同属性值集合
    num_of_different_properties = length(different_properties);%第i个特征下有多少个不同的属性值
    Property_Ent = zeros(1,num_of_different_properties);%预设第i个特征下各个属性的信息熵为0
    for k = 1:num_of_different_properties
        Property_Places_in_trainfeatures = find(different_properties(k) == trainfeatures(:,i));%找到希望研究的属性值在原特征表中的位置
        for j = 1:length(different_classes)
            Targets_in_Property = find(different_classes(j) == targets(Property_Places_in_trainfeatures,:));%研究属性值下，最终分类为j的样本位置
            ratio_of_targetj_in_property = length(Targets_in_Property)/length(Property_Places_in_trainfeatures);%研究属性下，最终分类为j的样本占该属性所有样本的比例
            if ratio_of_targetj_in_property ~= 0
                Property_Ent(k) = Property_Ent(k)+(-ratio_of_targetj_in_property*log(ratio_of_targetj_in_property)/log(2));%该属性的信息熵
            end
        end
        Property_Ent(k) = Property_Ent(k)*(length(Property_Places_in_trainfeatures)/example_num);%调整各属性的信息熵，乘上该属性占总样本数的比例
    end
    Feature_InfoGain(i) = EntD - sum(Property_Ent);%算出第i个特征的信息增益
    if Feature_InfoGain(i)>Max_InfoGain%取最大信息增益，并记录该特征的编号
        Max_InfoGain = Feature_InfoGain(i);
        No_of_Max = i;
    end
end
