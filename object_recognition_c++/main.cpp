#include <iostream>
#include <cstdio>
#include <list>
#include <opencv2/opencv.hpp>
#include <opencv2/core/cvstd.hpp>
#include <opencv2/video/background_segm.hpp>
#include <opencv2/bgsegm.hpp>
#include "Relief.h"
#include "midicontroller.h"

using namespace cv;
using namespace std;

Mat frame;
Mat fgMask;
Ptr<BackgroundSubtractor> bs;
relief *rel;
char keyboard;

inline Size myTextSize(const String & txt)
{
  int baseline = 0;
  return getTextSize(txt,FONT_HERSHEY_SIMPLEX,1.00,1,&baseline);
}

int main(int argc,char **argv)
{
  VideoCapture capture;
  int deviceID = 1;             // 0 = open default camera
  int apiID = CAP_V4L2;      // 0 = autodetect default API
  capture.open(deviceID + apiID);
  if(!capture.isOpened())
  {
    cerr<<"Unable to open camera "<<deviceID<<" with apiID "<<apiID<<endl;
    exit(EXIT_FAILURE);
  }
  capture.set(CAP_PROP_AUTOFOCUS,0);
  capture.set(CAP_PROP_FRAME_WIDTH,1280);
  capture.set(CAP_PROP_FRAME_HEIGHT, 720);
  capture.set(CAP_PROP_FPS,30.00);

  namedWindow("Frame");
  namedWindow("Difference");

  //bs = createBackgroundSubtractorMOG2();
  bs = bgsegm::createBackgroundSubtractorMOG(200,10,0.7,0.0);

  rel = new relief();
  midicontroller *midic = new midicontroller(rel);
  int txtHeight = myTextSize("F123abc").height;

  keyboard = 0;
  while( keyboard != 'q' && keyboard != 27 )
  {
    if(!capture.read(frame))
    {
      cerr<<"Unable to read the next frame."<<endl;
      cerr<<"Exiting..."<<endl;
      exit(EXIT_FAILURE);
    }
    flip(frame,frame,1);
    if( keyboard == ' ' )
      bs->apply(frame,fgMask,1);
    else
      bs->apply(frame,fgMask,0);
    rel->extract(fgMask);
    rel->detectEdges();
    rel->optimizeResults();
    rel->manhunt();
    for(int i=0;i<fgMask.cols;i++)
      line(frame,Point(i,0),Point(i,rel->getBrightness(i)),Scalar(0,255,0));
    for(list<int>::const_iterator it=rel->resultBegin();it!=rel->resultEnd();it++)
      line(frame,Point((*it),0),Point((*it),720),Scalar(0,0,255));

    for(list<pair<int,int>>::const_iterator it=rel->indBegin();it!=rel->indEnd();it++)
      rectangle(frame,Point((*it).first,650),Point((*it).second,700),Scalar(255,0,0));

    char buffer[50];
    snprintf(buffer,50,"variance_threshold=%.2f",rel->getVarianceThreshold());
    putText(frame,buffer,Point(20,10+txtHeight),FONT_HERSHEY_SIMPLEX,1.00,Scalar(255,0,0),1,LINE_AA,false);
    memset(buffer,' ',50);
    snprintf(buffer,50,"variance_range=%lu",rel->getVarianceRange());
    putText(frame,buffer,Point(20,2*(10+txtHeight)),FONT_HERSHEY_SIMPLEX,1.00,Scalar(255,0,0),1,LINE_AA,false);
    memset(buffer,' ',50);
    snprintf(buffer,50,"gaussian_sigma=%.2f",rel->getGaussianSigma());
    putText(frame,buffer,Point(20,3*(10+txtHeight)),FONT_HERSHEY_SIMPLEX,1.00,Scalar(255,0,0),1,LINE_AA,false);
    memset(buffer,' ',50);
    snprintf(buffer,50,"gaussian_range=%lu",rel->getGaussRange());
    putText(frame,buffer,Point(20,4*(10+txtHeight)),FONT_HERSHEY_SIMPLEX,1.00,Scalar(255,0,0),1,LINE_AA,false);
    memset(buffer,' ',50);
    snprintf(buffer,50,"group_length=%lu",rel->getGroupLength());
    putText(frame,buffer,Point(20,5*(10+txtHeight)),FONT_HERSHEY_SIMPLEX,1.00,Scalar(255,0,0),1,LINE_AA,false);
    memset(buffer,' ',50);
    snprintf(buffer,50,"individual_variance_threshold=%.2f",rel->getIndVarThreshold());
    putText(frame,buffer,Point(20,6*(10+txtHeight)),FONT_HERSHEY_SIMPLEX,1.00,Scalar(255,0,0),1,LINE_AA,false);
    memset(buffer,' ',50);
    snprintf(buffer,50,"individual_variance_range=%lu",rel->getIndVarRange());
    putText(frame,buffer,Point(20,7*(10+txtHeight)),FONT_HERSHEY_SIMPLEX,1.00,Scalar(255,0,0),1,LINE_AA,false);
    memset(buffer,' ',50);
    snprintf(buffer,50,"human_size=%lu",rel->getHSize());
    putText(frame,buffer,Point(20,8*(10+txtHeight)),FONT_HERSHEY_SIMPLEX,1.00,Scalar(255,0,0),1,LINE_AA,false);
    imshow("Frame",frame);
    imshow("Difference",fgMask);
    keyboard = (int) waitKey( 30 );
  }

  delete rel;
  delete midic;
  capture.release();
  destroyAllWindows();
  return EXIT_SUCCESS;
}
