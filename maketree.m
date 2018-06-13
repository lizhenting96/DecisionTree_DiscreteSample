function tree = maketree(featurelabels,trainfeatures,targets,threshold)

tree=struct('pro',0,'value',-1,'child',[],'parentpro',-1);
%pro��Ҷ�ڵ㣨0��ʾ�������ڲ��ڵ㣨1��ʾ��
%value�����Ҷ�ڵ�,���ʾ����ķ�������������ڲ��ڵ㣬���ʾĳ������
%parentpro����ýڵ��и��ڵ㣬���ֵ��ʾ���ڵ�����ʾ�����ľ�������ֵ
%child��ʾ�ýڵ����������

[example_num,feature_num] = size(trainfeatures);%��������������
different_classes = unique(targets);%ɸѡ����ͬ������

if length(different_classes) == 1 %���ֻ��һ�����������������ڵ�ı�ǩ������
    tree.pro = 0;%����ֻ��һ�����˵���Ѿ���Ҷ�ڵ㣬��0��ʾ
    tree.value = different_classes;%���������������Ҷ�ڵ�ķ�����
    tree.child = [];%������Ҷ�ڵ㣬û���ӽڵ�
    return
end

if feature_num == 0%
    H = hist(targets,length(different_classes));%��ֱ��ͼ��ʽ�г�
    [~,largest] = max(H);%largestΪ���ֱ�����ڵ�λ��
    tree.pro = 0;%����û���������Լ����֣������Ҷ�ڵ㣬��ֵΪ0
    tree.value = different_classes(largest);%ѡ��ýڵ������������������Ϊ����
    tree.child = [];%������Ҷ�ڵ㣬û���ӽڵ�
    return
end

[Max_InfoGain,No_of_Max] = InfoGainDis(different_classes,targets,feature_num,example_num,trainfeatures);

if Max_InfoGain<threshold%���ʣ��������������Ϣ���涼С�������趨����ֵ
    H = hist(targets,length(different_classes));%��ֱ��ͼ��ʽ�г�
    [~,largest] = max(H);%largestΪ���ֱ�����ڵ�λ��
    tree.pro = 0;%����û���������Լ����֣������Ҷ�ڵ㣬��ֵΪ0
    tree.value = different_classes(largest);%ѡ��ýڵ������������������Ϊ����
    tree.child = [];%������Ҷ�ڵ㣬û���ӽڵ�
    return
end
tree.pro = 1;%����˵���ýڵ�ɼ����֣����ڲ��ڵ㣬��1��ʾ
tv = featurelabels(No_of_Max);
tree.value = tv;%����Ϣ���������Ǹ�������Ϊ�ýڵ�ķ�������
tree.child = [];%�ӽڵ�Ŀǰ����֪��������Ϊ��

[Data_Splited,Target_Splited,Different_Properties] = SplitData(trainfeatures,targets,No_of_Max);
fprintf('split data into %d\n',length(Data_Splited));
fprintf('according to feature %d\n',featurelabels(No_of_Max));
featurelabels(No_of_Max) = [];%����������ù��ˣ�֮��Ͳ������ã��൱�ڴ�featurelabels��ɾ���������
for i = 1:length(Data_Splited)
    fprintf('property %d\n',Different_Properties(i));
    disp([Data_Splited{i},Target_Splited{i}]);
%��ʾ������
end
fprintf('\n');
for i = 1:length(Data_Splited)
    New_Features = Data_Splited{i};%ѡȡ�����������ĵ�i����Ϊ�µ�����ֵ
    New_Targets = Target_Splited{i};%�µķ��������µ�����ֵ���Ӧ
    Temp_Tree = maketree(featurelabels,New_Features,New_Targets,0);%���е���
    tree.pro = 1;%��ʾ���ڲ��ڵ�
    tree.value = tv;%�ڵ����õ���������
    tree.child{i} = Temp_Tree;%���ɵ�i������
    tree.child{i}.parentpro = Different_Properties(i);%�������ĸ��ڵ㡱��Ҳ���ǵ�ǰ�ڵ㣬������ʾ��ǰ�ڵ������ֵ
end
fprintf('\n');
end