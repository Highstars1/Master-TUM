# -*- coding: UTF-8

from functions import *
from matplotlib import pyplot as plt
import cv2

# generate database set Sdb
Sdb, Pdb = generate_Sdb()


# genetate training set Strain
Strain, Ptrain = generate_Strain()
#print(len(Strain[1][4]))

# generate testing set Stest
Stest,Ptest = generate_Stest()

batch = batch_generator(3,Ptrain,Pdb,Strain,Sdb)
cv2.imshow("img",batch[0][0])
cv2.imshow("img2",batch[0][1])
cv2.imshow("img3",batch[0][2])
cv2.waitKey(0)











