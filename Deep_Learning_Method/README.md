## Deep Learning Method


### Platform
* Ubuntu16.04 or other common Linux version.
* Caffe Deep Learning Framework. To install it, you can refer to its [official website](http://caffe.berkeleyvision.org/). Or you can find the source code from [github](https://github.com/BVLC/caffe)
* We train the model on GTX-Titan and use CUDA to accelerate computation. You can train the without CUDA or CUDNN but actually we strongly recommend you to use them.

### Directory

```console
.    
README.md   * This file.
data/   * Store images 
data/crop_data    * Store images of after cropping, including train and test set
data/crop_augment_data     * Store images of after cropping and with train data augmented
scripts/    * Store all the scripts and tools
caffe/    * Caffe deep learning framework
...         
caffe/examples    * Store the three models we use 
caffe/examples/alexnet   * Stores the configuration files `solver.prototxt`,`train_val.prototxt` of AlexNet and the result file `log.txt`
caffe/examples/alexnet_augment/   * Just as the caffe/examples/alexnet, but the configuration is a bit different and it regenerates different log file
caffe/examples/vgg    * Store files of VGG
caffe/examples/google    * Store files of GoogLeNet
```
### Image-Preprocessing
To get the orinal dataset, you can run the command:
```console
$ wget http://hpes.bii.a-star.edu.sg/ssf/SSF-filtered.zip
```
or use the browser to download it from the url above.

To generate crop sized data, you need to run the python script in:
* scripts/generate_data.py
Or if you want to generate data with augmentation, you need to run:
* scripts/generate_augment_data.py

After generate data, you need to divide the data into train and test set. Run scripts/divide.py

#### Note
To successfully generate data, you need to change the file directory defined in the scripts.

### Build Caffe
The files in the folder caffe/ are not complete. Please download the source codes from [github](https://github.com/BVLC/caffe) and build it as instructions.


### Use Caffe to Train and Test
Firstly, you need to generate the label list file. Run the bash file:
* scripts/create_filelist.sh

Secondly, to convert the dataset into lmdb style, run the bash file:
* scripts/create_lmdb.sh

Thirdly, to accelerate the computation, need to generate the mean value. Run:
```console
$ cd caffe
$ ./build/tools/compute_image_mean img_train_lmdb mean.binaryproto
```

Replace `img_train_lmdb` with the url of lmdb for training dataset, and replace `mean.binaryproto` with the url of output mean value file.

Fourth, change the configurations file of 
* solver.prototxt
* train_val.prototxt

Lastly, train the model and save the log file:
```console
$ cd caffe
$ ./build/tools/caffe train --solver examplex/alexnet/solver.prototxt 2>&1 | tee examplex/alexnet/log_temp.txt | less
```
Then, you can see the result file of log in 
* examplex/alexnet/log_temp.txt


#### Note
To successfully train the model, you also need to change the bash files/configuration files carefully, expecially change each url to match your own file directory and adjust the `crop size` parameter in all files accroding to the input image size.


