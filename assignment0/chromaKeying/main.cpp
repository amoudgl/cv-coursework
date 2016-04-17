//
//  main.cpp
//  chromaKeying
//
//  Created by Abhinav Moudgil on 10/01/16.
//  Copyright © 2016 Abhinav Moudgil. All rights reserved.
//
#include <iostream>
#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <stdio.h>

using namespace std;
using namespace cv;

void makeVideo(int i, const char * argv[])
{
    VideoCapture cap(argv[i]);
    if (!cap.isOpened())
        {
            std::cerr << "ERROR: Could not open video " << argv[1] << std::endl;
            return;
        }
    char filename[500];
    sprintf(filename, "/Users/abhinavmoudgil95/Library/Developer/Xcode/DerivedData/Ass1-daefxswifrukcddqlgakasnftizy/Build/Products/Debug/chromakeyed%d.avi", i);
    VideoWriter writer(filename, CV_FOURCC('M','J','P','G'), 30, Size(640, 360));
    int frame_count = 0;
    bool should_stop = false;
    Mat im, backhsv;
    Mat background = imread("/Users/abhinavmoudgil95/Documents/OpenCV/Ass1/Ass1/chromaKeying/background.jpg");
    cvtColor(background, backhsv, CV_BGR2HSV);
    vector<Mat> channels(3);
    vector<Mat> segmented(3);
    while(!should_stop)
    {
        cv::Mat frame, img_hsv, nseg, seg;
        cap >> frame;
        if (frame.empty())
        {
            if (frame_count != 0)
                should_stop = true; // End of the video
            continue;
        }
        cvtColor(frame,img_hsv,CV_BGR2HSV);
        if (frame_count == 0)
        {
            Size s = frame.size();
            resize(backhsv, im, s);
        }
        
        split(img_hsv, channels);
        double g = img_hsv.at<Vec3b>(1,1)[0];
        cout << g << endl;
        inRange(channels[0], double(g) - 4, double(g) + 4, segmented[0]);
        segmented[1] = segmented[0];
        segmented[2] = segmented[0];
        merge(segmented, seg);
        bitwise_not(seg, nseg);
        Mat x1, x2;
        Mat res, result;
        bitwise_and(seg, im, x1);
        bitwise_and(nseg, img_hsv, x2);
        bitwise_or(x1, x2, result);
        cvtColor(result, res, CV_HSV2BGR);
        writer.write(res);
        char filename[128];
        sprintf(filename, "segmented%d_%06d.jpg", i, frame_count);
        imwrite(filename, seg);
        sprintf(filename, "frame%d_%06d.jpg", i, frame_count);
        imwrite(filename, frame);
        sprintf(filename, "output%d_%06d.jpg", i, frame_count);
        imwrite(filename, res);
        frame_count++;
        cout << frame_count << endl;
    }
}

int main(int argc, const char * argv[]) {
    if (argc < 2)
    {
        std::cout << "USE: " << argv[0] << " <video-filename>" << std::endl;
        return 1;
    }
    int i;
    for (i = 1; i < argc; i++)
        makeVideo(i, argv);
       return 0;
}
