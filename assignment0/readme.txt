Assignment is done in Xcode. I talked to Anoop sir and he told me to submit the Xcode project. 

Method: 

1. Open the project named 'Ass1.xcodeproj'. 

2. Just check whether parameters are set in Build Settings of project: 
	* Header Search Paths: /usr/local/include
	* Library Search Paths: /usr/local/lib
	* Other Linker Flags: -lopencv_calib3d -lopencv_core -lopencv_features2d -lopencv_flann -lopencv_highgui -lopencv_imgcodecs -lopencv_imgproc -lopencv_ml -lopencv_objdetect -lopencv_photo -lopencv_shape -lopencv_stitching -lopencv_superres -lopencv_ts -lopencv_video -lopencv_videoio -lopencv_videostab

3. Assignment is divided into four modules: Ass1, videoCreater, inbuiltCamera, chromaKeying. Each module has its main.cpp file. 

4. Pass the necessay arguments and build any of four modules. Output will be saved in 'Products' folder. 

In the following modules, arguments should be passed: 

Ass1: /absolute/path/to/video/file.mp4
chromaKeying: /absolute/path/to/video/file1.mp4 /absolute/path/file2.mp4 

** In chromaKeying module, any number of arguments can be passed whereas in Ass1 module, only one argument should be passed. Rest of the modules don't require any arguments. 

** In the second module, i.e. videoCreater, images are not attached due to size limit. Please create images from module 'Ass1' and then give path to the folder where images are stored. 

Abhinav Moudgil
201331039

