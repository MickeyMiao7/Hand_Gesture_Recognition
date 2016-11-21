#!/usr/bin/env python
#-*- coding: utf-8 -*-

import os
import shutil

ratio = 1

src1 = "./training"
src2 = "./test"

for label in os.listdir(src1):
    labelPath = os.path.join(src1, label)
    if(not os.path.isdir(labelPath)):
       continue 
    fpList = os.listdir(labelPath)
    total = len(fpList)
    cnt1 = 0
    cnt2 = 0
    for fp in fpList:
        if cnt1 < total * ratio / (ratio + 1):
            cnt1 += 1
        else:
            trainfp = os.path.join(labelPath, fp)
            testfp = os.path.join(src2, label, fp)
            shutil.move(trainfp, testfp)
