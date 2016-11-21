#!/usr/bin/env python  
# -*- coding: utf-8 -*-  

import os
from PIL import Image

def transposeImg(src, dst):
    image = Image.open(src)
    image.transpose(Image.FLIP_LEFT_RIGHT).save(dst)


def main():
    inputDir = "./Data/training"
    labelList = {"1":0, 
        "2":0, 
        "3":0,
        "4":0,
        "5":0,
        "6":0,
        "7":0,
        "8":0,
        "9":0,
        "10":0,
        "A":0,
        "B":0,
        "C":0,
        "D":0,
        "E":0,
        "G":0,
        "H":0,
        "I":0,
        "K":0,
        "M":0,
        "N":0,
        "O":0,
        "P":0,
        "Q":0,
        "R":0,
        "T":0,
        "U":0,
        "W":0,
    }
    count = 0
    labels = os.listdir(inputDir)
    labels.remove(".DS_Store")
    print labels
    for imageLabel in labels:
        if imageLabel == ".DS_Store":
                continue
        labelPath = os.path.join(inputDir, imageLabel)
        for fp in os.listdir(labelPath):
            if fp == ".DS_Store":
                continue
            labelList[imageLabel] += 1
            # dst = "./Data/training/%s/%s%s.jpg" %(imageLabel, imageLabel, "{0:04d}".format(labelList[imageLabel]))
            src = os.path.join(labelPath, fp)
            dst = "./Data/training/%s/%s%s.jpg" %(imageLabel, imageLabel, "{0:04d}".format(labelList[imageLabel]+2000))
            transposeImg(src, dst)
            #print imagePath


if __name__ == "__main__":
    main()
