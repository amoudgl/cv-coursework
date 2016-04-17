//
//  main.cpp
//  Ass1
//
//  Created by Abhinav Moudgil on 10/01/16.
//  Copyright © 2016 Abhinav Moudgil. All rights reserved.
//

#include <iostream>
#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <stdio.h>

using namespace std;

int main(int argc, const char * argv[]) {
    
    if (argc !=2)
    {
        std::cout << "USE: " << argv[0] << " <video-filename>" << std::endl;
        return 1;
    }
    
    //Open the video that you pass from the command line
    cv::VideoCapture cap(argv[1]);
    if (!cap.isOpened())
    {
        std::cerr << "ERROR: Could not open video " << argv[1] << std::endl;
        return 1;
    }
    cout << argv[0] << endl;
    int frame_count = 0;
    bool should_stop = false;
    while(!should_stop)
    {
        cv::Mat frame;
        cap >> frame;
        if (frame.empty())
        {
            if (frame_count != 0)
                should_stop = true;
            continue;
        }
        char filename[128];
        sprintf(filename, "frame_%06d.jpg", frame_count);
        cv::imwrite(filename, frame);
        frame_count++;
        cout << "frame - " << frame_count << endl;
    }
    
    return 0;
}
