//
//  main.cpp
//  inbuiltCamera
//
//  Created by Abhinav Moudgil on 10/01/16.
//  Copyright © 2016 Abhinav Moudgil. All rights reserved.
//

#include <iostream>
#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <stdio.h>

using namespace cv;
using namespace std;

int main(int, char**)
{
    VideoCapture cap(0);
    if(!cap.isOpened())
        return -1;
    
    Mat edges;
    int frame_count = 0;
    for(; frame_count <= 100;)
    {
        Mat frame;
        cap >> frame; // get a new frame from camera
        imshow("Live Camera", frame);
        char filename[128];
        sprintf(filename, "cameraframe_%06d.jpg", frame_count);
        imwrite(filename, frame);
        frame_count++;
        cout << frame_count << endl;
        if(waitKey(30) >= 0) break;
    }

    return 0;
}