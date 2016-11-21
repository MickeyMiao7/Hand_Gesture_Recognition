#!/usr/bin/env python  
# -*- coding: utf-8 -*-  

import os
from PIL import Image

def CropImg(src, txt, dst):
    image = Image.open(src)
    fp = open(txt)
    content = fp.read()
    fp.close()
    string = content.split(" ")
    width = image.size[0]
    height = image.size[1]

    x1 = int(string[0]) + 3
    y1 = int(string[1]) + 3
    x2 = int(string[0]) + int(string[2]) - 3
    y2 = int(string[1]) + int(string[3]) - 3
    if (x1 < x2) & (y1 < y2):
        box = (x1, y1, x2, y2)
        image.crop(box).save(dst)


def main():
    inputDir = "./Data/image"
    outputDir = "./Data/Transformed"
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
        "F":0,
        "G":0,
        "H":0,
        "I":0,
        "K":0,
        "L":0,
        "M":0,
        "N":0,
        "O":0,
        "P":0,
        "Q":0,
        "R":0,
        "S":0,
        "T":0,
        "U":0,
        "V":0,
        "W":0,
        "X":0,
        "Y":0,
        "wave":0,
    }
    count = 0
    for directory in os.listdir(inputDir):
        datasetPath = os.path.join(inputDir, directory)
        for imageLabel in os.listdir(datasetPath):
            labelPath = os.path.join(datasetPath, imageLabel)
            for fp in os.listdir(labelPath):
                imageLabel = imageLabel == "L" and "8" or imageLabel
                imageLabel = imageLabel == "Y" and "6" or imageLabel
                imageLabel = imageLabel == "wave" and "5" or imageLabel
                imageLabel = imageLabel == "X" and "9" or imageLabel
                imageLabel = imageLabel == "F" and "3" or imageLabel
                imageLabel = imageLabel == "S" and "10" or imageLabel
                imageLabel = imageLabel == "V" and "2" or imageLabel
                if "txt" in fp:
                    txt = os.path.join(labelPath, fp)
                    src = txt.replace("txt", "jpg")
                    labelList[imageLabel] += 1
                    #dst = "./Data/training/%s/%s.jpg" %(imageLabel, str(labelList[imageLabel]))
                    dst = "./Data/training/%s/%s%s.jpg" %(imageLabel, imageLabel, "{0:04d}".format(labelList[imageLabel]))
                    CropImg(src, txt, dst)
                """
                    if "res_5.jpg" in fp:
                        image = Image.open(os.path.join(labelPath, fp))
                        print image.format, image.size, image.mode
                        print image.getpixel((0, 0))
                        print image.getpixel((0, 1))
                        print image.getpixel((0, 2))
                        
                    if "depth_5.png" in fp:
                        image = Image.open(os.path.join(labelPath, fp))
                        value = image.getpixel((0, 0))
                        value = 255 * (value - 100) / 900
                        print value
                        print image.format, image.size, image.mode
                        print image.getpixel((0, 0))
                        print image.getpixel((0, 1))
                        print image.getpixel((0, 2))
                    """
            #print imagePath
if __name__ == "__main__":
    main()
