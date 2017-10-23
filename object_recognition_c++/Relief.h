#ifndef RELIEF_H
#define RELIEF_H
#include <cstddef>
#include <cmath>
#include <opencv2/core/mat.hpp>
#include <list>
#include <utility>
class relief
{
 public:
  relief();
  relief(double var_th, size_t var_range, double gauss_sigma, size_t gauss_range,size_t group_th);
  ~relief();
  //plain setters
  void setVarianceThreshold(double var_th);
  void setVarianceRange(size_t var_range);
  void setGaussianSigma(double gauss_sigma);
  void setGaussRange(size_t gauss_range);
  void setGroupLength(size_t group_th);
  void setIndVarThreshold(double ind_var_th);
  void setIndVarRange(size_t ind_var_range);
  void setHSize(size_t h_size);

  //plain getters
  double getVarianceThreshold();
  size_t getVarianceRange();
  double getGaussianSigma();
  size_t getGaussRange();
  size_t getGroupLength();
  double getIndVarThreshold();
  size_t getIndVarRange();
  size_t getHSize();

  //midi setters
  void setMVarianceThreshold(unsigned char byte);
  void setMVarianceRange(unsigned char byte);
  void setMGaussianSigma(unsigned char byte);
  void setMGaussRange(unsigned char byte);
  void setMGroupLength(unsigned char byte);
  void setMIndVarThreshold(unsigned char byte);
  void setMIndVarRange(unsigned char byte);
  void setMHSize(unsigned char byte);

  void extract(cv::InputArray mask);
  void detectEdges();
  void optimizeResults();
  int getBrightness(int col);
  std::list<int>::const_iterator resultBegin();
  std::list<int>::const_iterator resultEnd();
  void clear();
 private:
  void detect();
  void blur();
  void derivative();
  void group_really_close();
  void find_individuals();
  //carefull unsafe only call, with preamble "if(length>=0)"
  inline double variance_at(int i,int vr)
  {
    double mu = 0.00, v = 0.00, p = 1/((double) (2*vr+1));
    //Via two pass for numerical stability
    for(int j=0;j<2*vr+1;j++)
    {
      if( (i+j-vr) < 0 )
        mu += bdata[0];
      else if( (i+j-vr) >= length )
        mu += bdata[length-1];
      else
        mu += bdata[(i+j-vr)];
    }
    mu*=p;
    for(int j=0;j<2*vr+1;j++)
    {
      if( (i+j-vr) < 0 )
        v += pow(bdata[0]-mu,2);
      else if( (i+j-vr) >= length )
        v += pow(bdata[length-1]-mu,2);
      else
        v += pow(bdata[(i+j-vr)]-mu,2);
    }
    return v*p;
  }
  inline double gaussian(double sig,double x)
  {
    return std::exp(-0.50*std::pow(x/sig,2))/(sig*SQRT_2PI);
  }

  double * data;
  double * bdata;
  double * der2;
  int length;

  std::list<int>* results;
  std::list<std::pair<int,int>>* individuals;

  double var_th;
  const double var_th_min = 100;
  const double var_th_max = 5000;

  size_t var_range;
  const double var_range_min = 2;
  const double var_range_max = 10;

  double gauss_sigma;
  const double gauss_sigma_min = 0.01;
  const double gauss_sigma_max = 1;

  size_t gauss_range;
  const double gauss_range_min = 2;
  const double gauss_range_max = 10;

  size_t group_th;
  const double group_th_min = 2;
  const double group_th_max = 20;

  double ind_var_th;
  const double ind_var_th_min = 100;
  const double ind_var_th_max = 5000;

  size_t ind_var_range;
  const double ind_var_range_min = 2;
  const double ind_var_range_max = 10;

  size_t h_size;
  const double h_size_min = 100;
  const double h_size_max = 150;

  const double SQRT_2PI = 2.5066282746310005024;
};
#endif
