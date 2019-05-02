# BSCP
##Band Selection for Hyperspectral Image Classification via channel Puning


## Introduction
**BSCP**is an algorithm for HSI classification and band selection. HSI has proved that it contains a large amount of information which can be utlized to analyse different images. However redundant spectrum information is usually considered unnecessary. Therefore BSCP as a method of band selection can reduce the dimension effectively. At the same time, our algorithm presents similar classification results using less arguments compared with BSCNN+(https://www.researchgate.net/publication/321121592_Hyperspectral_Band_Selection_Based_on_Deep_Convolutional_Neural_Network_and_Distance_Density), and outperforms GLBS(https://ieeexplore.ieee.org/document/8113687)


##Requirements
This experiment was on a basic hardware condition(an Intel Core i5-7700K 4.2GHz CPU and a NVIDIA GeForce GTX 1080 Ti GPU). Besides the code has been modified and tested on Windows 10(x64) operation system with MATLAB2017a and Sublime Text 3. In order to make fully use of our code ,some guidelines are listed 
**1**  You will need to import some necessary libraries in Sublime Text 3 to run the code. For example we use keras, which is a high-level neural networks API, written in Python and capable of running on top of TensorFlow, to build our 1-d CNN.


##Data preparation
We apply our proposed method BSCP on one typical data set, Indian Pines which is widely used as HSI.  You can acquire the data set in GIC
(http://www.ehu.eus/ccwintco/index.php?title=Hyperspectral_Remote_Sensing_Scenes#Indian_Pines) or just clone the repo and the data set with MATLAB data format called ¡°Indian_pines_corrected.mat ¡° is put in BSCP(¡®<ProjectRoot>/data¡¯)

In order to get the ideal bands, we have provided code to rank different bands in  BSCP(¡®<ProjectRoot>/channelpruning¡¯). After that, you will get an 200*1 array and all the bands are ranked from top to bottom based on the amount of information contained.

Then, the file ¡°indiantest.m¡± in BSCP(¡®<ProjectRoot>/generatedata¡¯) will generate standard training and test sets through selecting different number of bands(just fetched before).



##Train and Test model
We have provided the training and test code script for BSCP method in (¡®<ProjectRoot>/CNN-model¡¯), and you can specify the input data set just generated in Data Preparation. 

Finally, the prediction accuracy and loss wil be preserved in a MATALAB data format.
 