function Prediction = DataClassifier(Input_Data,tree)
while tree.pro == 1%��Ȼ���м�ڵ�ʱ
    childset = tree.child;
    v = tree.value;
    for i = 1:size(childset,2)
        child = childset{i};
        if child.parentpro == Input_Data(v);
            tree = child;
            break;
        end
    end
end
Prediction = tree.value;
end