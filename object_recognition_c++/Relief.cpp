#include "Relief.h"

relief::relief()
{
  length = -1;
  results = new std::list<int>();
  individuals = new std::list<std::pair<int,int>>();

  var_th    = 450.00;
  var_range = 2;

  gauss_sigma = 0.45;
  gauss_range = 10;

  group_th = 10;
}

relief::relief(double var_th, size_t var_range, double gauss_sigma, size_t gauss_range,size_t group_th)
{
  length = -1;
  results = new std::list<int>();
  individuals = new std::list<std::pair<int,int>>();

  this->var_th    = var_th;
  this->var_range = var_range;

  this->gauss_sigma = gauss_sigma;
  this->gauss_range = gauss_range;

  this->group_th = group_th;
}

relief::~relief()
{
  if(length >= 0)
    {
      delete data;
      delete bdata;
      delete der2;
    }
  delete results;
  delete individuals;
}

void relief::setVarianceThreshold(double var_th)
{
  this->var_th = var_th;
  return;
}

void relief::setVarianceRange(size_t var_range)
{
  this->var_range = var_range;
  return;
}

void relief::setGaussianSigma(double gauss_sigma)
{
  this->gauss_sigma = gauss_sigma;
  return;
}

void relief::setGaussRange(size_t gauss_range)
{
  this->gauss_range = gauss_range;
  return;
}

void relief::setGroupLength(size_t group_th)
{
  this->group_th = group_th;
  return;
}

void relief::setIndVarThreshold(double ind_var_th)
{
  this->ind_var_th = ind_var_th;
  return;
}

void relief::setIndVarRange(size_t ind_var_range)
{
  this->ind_var_range = ind_var_range;
  return;
}

void relief::setHSize(size_t h_size)
{
  this->h_size = h_size;
}

double relief::getVarianceThreshold()
{
  return this->var_th;
}

size_t relief::getVarianceRange()
{
  return this->var_range;
}

double relief::getGaussianSigma()
{
  return this->gauss_sigma;
}

size_t relief::getGaussRange()
{
  return this->gauss_range;
}

size_t relief::getGroupLength()
{
  return this->group_th;
}

double relief::getIndVarThreshold()
{
  return this->ind_var_th;
}

size_t relief::getIndVarRange()
{
  return this->ind_var_range;
}

size_t relief::getHSize()
{
  return this->h_size;
}

void relief::setMVarianceThreshold(unsigned char byte)
{
  this->setVarianceThreshold( ((double) byte)/127.00*(var_th_max - var_th_min) + var_th_min );
}

void relief::setMVarianceRange(unsigned char byte)
{
  this->setVarianceRange((size_t) (((double) byte)/127.00*(var_range_max - var_range_min) + var_range_min ));
}
void relief::setMGaussianSigma(unsigned char byte)
{
  this->setGaussianSigma( ((double) byte)/127.00*(gauss_sigma_max - gauss_sigma_min) + gauss_sigma_min);
}

void relief::setMGaussRange(unsigned char byte)
{
  this->setGaussRange((size_t) (((double) byte)/127.00*(gauss_range_max - gauss_range_min) + gauss_range_min));
}
void relief::setMGroupLength(unsigned char byte)
{
  this->setGroupLength((size_t) (((double) byte)/127.00*(group_th_max - group_th_min) + group_th_min));
}

void relief::setMIndVarThreshold(unsigned char byte)
{
  this->setIndVarThreshold( ((double) byte)/127.00*(ind_var_th_max - ind_var_th_min) + ind_var_th_min);
}

void relief::setMIndVarRange(unsigned char byte)
{
  this->setIndVarRange((size_t) (((double) byte)/127.00*(ind_var_range_max - ind_var_range_min) + ind_var_range_min));
}

void relief::setMHSize(unsigned char byte)
{
  this->setHSize((size_t) (((double) byte)/127.00*(h_size_max - h_size_min) + h_size_min));
}

void relief::extract(cv::InputArray mask)
{
  clear();

  cv::Mat src_mask = mask.getMat();
  length = src_mask.cols;
  data  = new double[length];
  bdata = new double[length];
  der2  = new double[length];
  for(int i=0;i<src_mask.cols;i++)
    {
      data[i] = 0.00;
      for(int j=0;j<src_mask.rows;j++)
        {
          if(src_mask.at<uchar>(j,i)<128)
            data[i] += 1.00;
        }
    }
  return;
}

void relief::detectEdges()
{
  detect();
}

void relief::optimizeResults()
{
  this->group_really_close();
}

int relief::getBrightness(int col)
{
  if( length >=0 && col >= 0 && col < length )
    return ((int) bdata[col]);
  else
    return 0;
}

std::list<int>::const_iterator relief::resultBegin()
{
  return results->cbegin();
}

std::list<int>::const_iterator relief::resultEnd()
{
  return results->cend();
}

void relief::clear()
{
  if(length >= 0)
    {
      delete data;
      delete bdata;
      delete der2;

      length = -1;
    }
  results->clear();
  individuals->clear();
}

void relief::detect()
{
  if( length >= 0 )
  {
    derivative();
    for(int i=0;i<length-1;i++)
	  {
	    if( der2[i]*der2[i+1] <= 0 )
	    {
        double v = variance_at(i,var_range);
	      if( v > var_th)
		      results->push_back(i);
	    }
	  }
  }
  return;
}

void relief::blur()
{
  if( length >= 0 )
    {
      double * gauss_rel = new double[2*gauss_range+1];
      for(int i=0;i<2*gauss_range+1;i++)
	gauss_rel[i] = gaussian(gauss_sigma,i-gauss_range);
      for(int i=0;i<length;i++)
	{
	  bdata[i] = 0.00;
	  for(int j=0;j<2*gauss_range+1;j++)
	    {
	      if( (i+j-gauss_range) < 0 )
		bdata[i] += gauss_rel[j]*data[0];
	      else if( (i+j-gauss_range) >= length )
		bdata[i] += gauss_rel[j]*data[length-1];
	      else
		bdata[i] += gauss_rel[j]*data[(i+j-gauss_range)];
	    }
	}
      delete gauss_rel;
    }
  return;
}

void relief::derivative()
{
  if( length >= 0)
    {
      blur();
      for(int i=0;i<length;i++)
	{
	  if( i-1 < 0 )
	    der2[i] = bdata[0];
	  else
	    der2[i] = bdata[i];
	  der2[i] -= 2*bdata[i];
	  if( i+1 >= length )
	    der2[i] += bdata[length-1];
	  else
	    der2[i] += bdata[i];
	}
    }
  return;
}

void relief::group_really_close()
{
  std::list<std::list<int>*> *groups = new std::list<std::list<int>*>();
  groups->push_back(new std::list<int>());
  for(std::list<int>::iterator it=results->begin();it!=results->end();it++)
  {
    if(groups->back()->empty())
      groups->back()->push_back((*it));
    else if(abs((*it)-groups->back()->front()) < group_th )
	    groups->back()->push_back((*it));
    else
	    groups->push_back(new std::list<int>(1,(*it)));
  }
  results->clear();
  for(std::list<std::list<int>*>::iterator it=groups->begin();it!=groups->end();it++)
  {
    int mu = 0;
    for(std::list<int>::iterator jt=(*it)->begin();jt!=(*it)->end();jt++)
	    mu += (*jt);
      if((*it)->size()!=0)
      {
        mu = mu / (*it)->size();
        results->push_back(mu);
      }
  }
  for(std::list<std::list<int>*>::iterator it=groups->begin();it!=groups->end();it++)
    delete (*it);
  delete groups;
  return;
}

void relief::find_individuals()
{
  std::list<std::pair<int,int>>* valuation = new std::list<std::pair<int,int>>();
  for(std::list<int>::iterator it=results->begin();it!=results->end();it++)
  {
    double vb4 = variance_at((*it)-ind_var_range,ind_var_range);
    double v4r = variance_at((*it)+ind_var_range,ind_var_range);
    if(vb4 < ind_var_th && v4r < ind_var_th )
      valuation->push_back(std::make_pair<int,int>((int)(*it),0));
    else if(vb4 < ind_var_th && v4r >= ind_var_th)
      valuation->push_back(std::make_pair<int,int>((int)(*it),-1));
    else if(vb4 >= ind_var_th && v4r < ind_var_th)
      valuation->push_back(std::make_pair<int,int>((int)(*it),1));
    else //drop it
      continue;
  }
  for(std::list<std::pair<int,int>>::iterator it=valuation->begin();it!=valuation->end();)
  {
    if((*it).second <= 0)
    {
      std::list<std::pair<int,int>>::iterator rit = std::next(it);
      if(rit!=valuation->end())
      {
        if((*rit).second >= 0)
        {
          individuals->push_back(std::make_pair<int,int>((int)(*it).first,(int)(*rit).first));
          std::advance(it,2);
          continue;
        }
        else
        {
          bool found_smthg = false;
          for(int i=(*it).first;i<(*rit).first-ind_var_range;i++)
          {
            if(variance_at(i,ind_var_range) < ind_var_th)
            {
              found_smthg = true;
              individuals->push_back(std::make_pair<int,int>((int)(*it).first,(int)i));
              break;
            }
          }
          if(!found_smthg) //drop it
            std::advance(it,1);
        }
      }
      else
      {
        bool found_smthg =  false;
        if(std::distance(it,valuation->begin())>=1)
        {
          std::list<std::pair<int,int>>::iterator lit = std::next(it,-1);
          for(int i=(*it).first;i>(*lit).first+ind_var_range;i--)
          {
            if(variance_at(i,ind_var_range) < ind_var_th)
            {
              found_smthg = true;
              individuals->push_back(std::make_pair<int,int>((int)i,(int)(*it).first));
              break;
            }
          }
          if(!found_smthg)//drop it
            std::advance(it,1);
        }
      }
    }
    else
    {
      bool found_smthg =  false;
      if(std::distance(it,valuation->begin())>=1)
      {
        std::list<std::pair<int,int>>::iterator lit = std::next(it,-1);
        for(int i=(*it).first;i>(*lit).first+ind_var_range;i--)
        {
          if(variance_at(i,ind_var_range) < ind_var_th)
          {
            found_smthg = true;
            individuals->push_back(std::make_pair<int,int>((int)i,(int)(*it).first));
            break;
          }
        }
        if(!found_smthg)//drop it
          std::advance(it,1);
      }
    }
  }
  delete valuation;
}
