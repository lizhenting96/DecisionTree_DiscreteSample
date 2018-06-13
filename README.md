# DecisionTree_DiscreteSample
Decision Tree, Discrete Sample, Information Entropy, Information Gain, Simple Pruning

Decision tree is a common machine learning method. We hope that the program can learn a model from a given training data set to classify new samples. The decision tree is based on the structure of the tree to make decisions. The selection of optimal partition attributes is related to information gain and information entropy. In addition, it is necessary to prune the decision tree to reduce the risk of over-fitting. In this paper, discrete decision trees and continuous decision trees are designed, and some simple pruning processes are given.

This program mainly includes four subroutines:
maketree.m: Build the tree and output the classified data
InfoGainDis: Calculate Information Gains
DataClassifier: Seperate data at each nodes according to the proper feature.
And the script DecisionTree includes the process of inputing data.
