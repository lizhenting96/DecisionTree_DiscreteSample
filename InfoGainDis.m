function [Max_InfoGain,No_of_Max] = InfoGainDis(different_classes,targets,feature_num,example_num,trainfeatures)
pnode = zeros(1,length(different_classes));
for i = 1:length(different_classes)
    pnode(i) = length(find(targets == different_classes(i)))/length(targets);%��Ӧ�����շ�����ռ���������ı���
end
EntD = -sum(pnode.*log(pnode)/log(2));%����������Ϣ��
Max_InfoGain = -1;%����������Ϣ����
No_of_Max = -1;%�ڼ�����������Ϣ�������
Feature_InfoGain = zeros(1,feature_num);%Ԥ�������������Ϣ���涼Ϊ0
for i = 1:feature_num
    different_properties = unique(trainfeatures(:,i));%��i�������µĲ�ͬ����ֵ����
    num_of_different_properties = length(different_properties);%��i���������ж��ٸ���ͬ������ֵ
    Property_Ent = zeros(1,num_of_different_properties);%Ԥ���i�������¸������Ե���Ϣ��Ϊ0
    for k = 1:num_of_different_properties
        Property_Places_in_trainfeatures = find(different_properties(k) == trainfeatures(:,i));%�ҵ�ϣ���о�������ֵ��ԭ�������е�λ��
        for j = 1:length(different_classes)
            Targets_in_Property = find(different_classes(j) == targets(Property_Places_in_trainfeatures,:));%�о�����ֵ�£����շ���Ϊj������λ��
            ratio_of_targetj_in_property = length(Targets_in_Property)/length(Property_Places_in_trainfeatures);%�о������£����շ���Ϊj������ռ���������������ı���
            if ratio_of_targetj_in_property ~= 0
                Property_Ent(k) = Property_Ent(k)+(-ratio_of_targetj_in_property*log(ratio_of_targetj_in_property)/log(2));%�����Ե���Ϣ��
            end
        end
        Property_Ent(k) = Property_Ent(k)*(length(Property_Places_in_trainfeatures)/example_num);%���������Ե���Ϣ�أ����ϸ�����ռ���������ı���
    end
    Feature_InfoGain(i) = EntD - sum(Property_Ent);%�����i����������Ϣ����
    if Feature_InfoGain(i)>Max_InfoGain%ȡ�����Ϣ���棬����¼�������ı��
        Max_InfoGain = Feature_InfoGain(i);
        No_of_Max = i;
    end
end
