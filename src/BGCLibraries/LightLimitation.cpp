#include <math.h>
#include <stdio.h>
#include "BGCHeader.h" 
#include <iostream>
using namespace std;

/**************************************************************************************************************************************************************************/
//Platt, T., Gallegos, C. L., and Harrison, W. G.: Photoinhibition of Photosynthesis in Natural Assemblages of Marine-Phytoplankton, J Mar Res, 38, 687-701, 1980.
//Platt1 returns vertically averaged light inhibition. This is achieved with a numerical integration of the Platt function, which is shown in Platt2, using the Euler method.
//Platt2, returns light inhibition at a specified PAR level.
double Platt1(double PARtop, double KValue, double Depth, double Pmax, double beta, double slope, int EulerSteps)
{
   //PARtop - Light at the top of the depth range to be used (different dimensions may be used)
   //KValue - Light extinction coefficient (1/m)
   //Depth - depth range for vertical averaging of light limitation (m)
   //Pmax - Maximum photosynthetic rate that may be given in different units as long as compatible to those of
   //beta and slope, for example mg C / (mg C * time), or mg C/(mg Chl * time) 
   //beta - negative slope of the P-I curve, under very high light when photoinhibition steps in
   //slope - initial slope of the P-I curve
   //These two last parameters may be expressed in the same units as Pmax, divided by the units used for light,
   //for example, mg C / (mg C * time) / (W m-2)	
   //Euler steps - this is an integer used to define the spatial resolution of the vertical integration by the Euler method
   double DeltaZ, Soma = 0.0, LightLimitation = 0.0, TINNY = 0.00000000001, PAR;
   double MyKValue, MyDepth, MyPmax, Mybeta, Myslope;
   int MySteps;
   //cout << "PARtop= " << PARtop << endl;
   //Forcing function arguments within the acceptable range
   PAR = std::max(0.0,PARtop);
   MyKValue = std::max(0.0,KValue);
   MyDepth = std::max(0.0,Depth);
   MyPmax = std::max(0.0,Pmax);
   Mybeta = std::max(0.0,beta);
   Myslope = std::max(0.0,slope);
   MySteps = std::max(1,EulerSteps);
   //range checking finished

   if ((MyDepth > TINNY) && (PAR > TINNY) && (MyPmax > TINNY))
   {
         DeltaZ = MyDepth / MySteps;
         for (int Step = 1; Step <= MySteps; Step++)    //Euler integration as a function of depth
         {
            Soma = Soma + (1 - exp(-Myslope * PAR / MyPmax)) * exp(-Mybeta * PAR/ MyPmax) * DeltaZ;
            PAR = PAR * exp(-MyKValue * DeltaZ);
         }
         LightLimitation = Soma / MyDepth;
  }
  return LightLimitation;//vertically averaged light limitation (dimensionless) in the range [0 1]
}

double Platt2(double PAR, double Pmax, double beta, double slope)
{
   //PAR - Light at a given depth	
   //The remaing arguments as in the previous function Platt1
   double LightLimitation = 0.0, TINNY = 0.00000000001, MyPAR;
   double MyPmax, Mybeta, Myslope;

   //Forcing function arguments within the acceptable range
   MyPAR = std::max(0.0,PAR);
   MyPmax = std::max(0.0,Pmax);
   Mybeta = std::max(0.0,beta);
   Myslope = std::max(0.0,slope);
   //range checking finished

   if ((MyPAR > TINNY) && (MyPmax > TINNY)) 
      LightLimitation = (1.0-exp(-Myslope * MyPAR / MyPmax)) * exp(-Mybeta * MyPAR / MyPmax);
   return LightLimitation; //Light limitation at a given depth (dimensionless) in the range [0 1]
}

/**************************************************************************************************************************************************************/
//Steele P-I function
//Steele, J. H.: Environmental control of photosynthesis in the sea. Limnology and Oceanography, 7, 137-150, 1962
//Steele1 returns vertically averaged light inhibition. This is achieved with the analytical integration of the Steele function, which is shown in Steele2.
//Steele2 returns light inhibition at a specified PAR level.
//
//
double Steele1(double PARtop, double KValue, double Depth, double PARopt)
{
   //PARtop - Light at the top of the depth range to be used (different dimensions may be used)
   //KValue - Light extinction coefficient (1/m)
   //Depth - depth range for vertical averaging of light limitation (m)
   //PARopt - Optimal light intensity (must use the same dimensions of PARtop)
   	
   double LightLimitation = 0.0, TINNY = 0.00000000001;
   double MyPARtop, MyPARbottom, MyKValue, MyDepth, MyPARopt;

   //Forcing function arguments within the acceptable range
   MyPARtop = std::max(0.0,PARtop);
   MyKValue = std::max(0.0,KValue);
   MyDepth = std::max(0.0,Depth);
   MyPARopt = std::max(0.0,PARopt);
   MyPARbottom = std::max(0.0, MyPARtop*exp(-MyKValue * MyDepth));
   //range checking finished
   //
   if ((MyKValue * MyDepth > TINNY) && (MyPARtop > TINNY))
      LightLimitation = exp(1.0) / (MyKValue * MyDepth) * (exp(-MyPARbottom / MyPARopt)-exp(-MyPARtop / MyPARopt));
   return LightLimitation; //vertically averaged light limitation (dimensionless) in the range [0 1]
}

double Steele2(double PAR, double PARopt)
{
   //PAR - Light at a given depth	
   //PARopt - Optimal light intensity (must use the same dimensions of PAR)	
   double LightLimitation = 0.0, TINNY = 0.00000000001, MyPAR, MyPARopt;
   
   //Forcing function arguments within the acceptable range
   MyPAR = std::max(0.0,PAR);
   MyPARopt = std::max(0.0,PARopt);
   //range checking finished
   //
   if ((MyPAR > TINNY) && (MyPARopt > TINNY))
      LightLimitation = MyPAR / MyPARopt * exp(1.0 - MyPAR / MyPARopt);
   return LightLimitation;//Light limitation at a given depth (dimensionless) in the range [0 1]
}

//This function returns the initial slope of the Steele function
double SteeleSlope(double Pmax, double Iopt)
{
   //Pmax - Maximum photosynthetic rate that may be given in different units as long as compatible to those of
   //Slope, for example mg C / (mg C * time), or mg C/(mg Chl * time)
   //Iopt - Optimal light intensity (can be given in different units, as long as compatile to those expected for the slope	
   double Slope = 0.0,  TINNY = 0.00000000001, MyPmax, MyIopt;
   //Forcing function arguments within the acceptable range
   MyPmax = std::max(0.0,Pmax);
   MyIopt = std::max(0.0,Iopt);
   //range checking finished
   //
   if (MyIopt > TINNY) Slope= MyPmax * exp(1.0) / MyIopt;
   return Slope;//initial slope of the Steels function, in units of Pmax divided by units of light, for example, mg C / (mg C * time) / (W m-2)
}

/**************************************************************************************************************************************************************/
//Eilers and Peeters P-I function
//Eilers, P. H. C., Peeters, J. C. H.: A model for the relationship between light intensity and the rate of photosynthesis in phytoplankton,
//Ecological Modelling, 42, 199-215, 1988
//EilersAndPeeters1 returns vertically averaged light inhibition. This is achieved with the analytical integration of the EilersAndPeeters function, which is shown in EilersAndPeeters2.
//EilersAndPeeters2 returns light inhibition at a specified PAR level.
//
double EilersAndPeeters1(double PARtop, double KValue, double Depth, double a, double b, double c, double Pmax)
{

   //PARtop - Light at the top of the depth range to be used (different dimensions may be used)
   //KValue - Light extinction coefficient (1/m)
   //Depth - depth range for vertical averaging of light limitation (m)
   //a, b and c - parameters of the Eilers and Peeters model	
   //Pmax - Maximum photosynthetic rate that may be given in different units

   double D, B1, B2, LightLimitation = 0.0, TINNY = 0.00000000001, P;
   double MyPARtop, MyKValue, MyDepth, MyPARbottom, Mya, Myc, MyPmax;
   //cout << "PARtop= " << PARtop << endl;
   //Forcing function arguments within the acceptable range
   MyPARtop = std::max(0.0,PARtop);
   MyKValue = std::max(0.0,KValue);
   MyDepth = std::max(0.0,Depth);
   Mya = std::max(0.0,a);
   Myc = std::max(0.0,c);
   MyPmax = std::max(0.0,Pmax);
   MyPARbottom = std::max(0.0, MyPARtop*exp(-MyKValue * MyDepth));
   //range checking finished

   if (MyPARtop - MyPARbottom > TINNY)
   {	   
      if ((MyDepth > TINNY) && (MyPARtop > TINNY) && (MyPmax > TINNY))
      {
         if (Mya != 0.0)
         {
            D = b * b - 4 * Mya * Myc;
            B1 = 2.0 * Mya * MyPARtop + b;
            B2 = 2.0 * Mya * MyPARbottom + b;
            if (D < 0.0)
               P = 2.0 / (MyKValue*sqrt(-D)) *(atan(B1/sqrt(-D))- atan(B2/sqrt(-D))) / MyDepth;
            else if (D == 0.0)
               P = 2.0 / MyKValue * (1.0 / B2 - 1.0 / B1) / MyDepth;
            else if (D > 0.0)
               P = 1.0 / (MyKValue*sqrt(D)) * log (((B1 - sqrt(D))*(B2 + sqrt(D)))/
                           ((B1 + sqrt(D)) * (B2 - sqrt(D)))) / MyDepth;
         }
         else	 
            P = 1.0 / (MyKValue * b) * log (fabs(b * MyPARtop + Myc)/
                         fabs(b * MyPARbottom + Myc)) / MyDepth;
         LightLimitation = P/MyPmax;
      }
   }
   else{
      LightLimitation = EilersAndPeeters2(MyPARtop, Mya, b, Myc, MyPmax);}//If top and bottom light do not differ signmificantly, use the standard function, without vertical averaging
   return LightLimitation; //vertically averaged light limitation (dimensionless) in the range [0 1]
}

double EilersAndPeeters2(double PAR, double a, double b, double c, double Pmax)
{
   //PAR - Light at a given depth
   //a, b and c - parameters of the Eilers and Peeters model
   //Pmax - Maximum photosynthetic rate that may be given in different units
   double LightLimitation = 0.0, TINNY = 0.00000000001, MyPAR, x, P;
   double Mya, Myc, MyPmax;
   //Forcing function arguments within the acceptable range
   MyPAR = std::max(0.0,PAR);
   Mya = std::max(0.0,a);
   Myc = std::max(0.0,c);
   MyPmax = std::max(0.0,Pmax);
   //range checking finished
   x = Mya * MyPAR * MyPAR + b * MyPAR + Myc;
   if ((x > TINNY) && (MyPmax > TINNY))
   {	   
      P = MyPAR / x;
      LightLimitation = P / MyPmax;
   }   
   return LightLimitation; //Light limitation at a given depth (dimensionless) in the range [0 1]
}
//This function returns the initial slope of the Eiles and Peeters function
double EilersAndPeetersSlope(double C)
{
   //C - parameter of the Eilers and Peeters function	
   double Slope = 0.0, TINNY = 0.00000000001, MyC;
   MyC = std::max(0.0,C);   
   if (MyC > TINNY) Slope = 1.0 / MyC;
   return Slope; //dimensios as described above and dependent on the production and light units used in fitting the Eielrs and Peeters function
                 //to observations
}
/**************************************************************************************************************************************************************/

//From: Fennel et al. (2006) - Global Biogeochem. Cycles, 20,GB3007, doi:10.1029/2005GB002456
//Light limitation of nitrification
double LightLimNitr(double KI, double I0, double Light)
{
   //KI - Half-saturation for light inhibition (light units used for I0 and Light)
   //I0 - Light threshold below which there is no light inhibition 
   //Light - Shortwave light in any units
   
   double MyKI, MyI0, MyLight;

   //Forcing function arguments within the acceptable range
   MyLight = std::max(0.0,Light);
   MyKI = std::max(0.0,KI);//Light intensity at which the
                           //inhibition of nitrification is half-saturated
   MyI0 = std::max(0.0,I0);//W m-2 Light intensity threshold for
                           //light-inhibition of nitrification
   //range checking finished
   if (MyLight > MyI0)
      return (1.0 - std::max(0.0,(MyLight - MyI0) / (MyKI + MyLight - MyI0)));//dimensionless light inhibition [0 1]
   else 
      return 1.0;
}	
/**************************************************************************************************************************************************************/
//This is a general purpose function to compute vertically-averaged and it may be used to provide the light input to LightLimNitr
//It assumes an exponential ligh decay with depth following the Lambert-Beer law

double VertLightAvg(double LightAtTop, double KValue, double Depth)
{
   //LightAtTop - Light at the top of the depth range to be used (different dimensions may be used)
   //KValue - Light extinction coefficient (1/m)
   //Depth - depth range for vertical averaging of light limitation (m)
   	
   double TINNY = 0.00000000001, MyLight, MyKValue, MyDepth;

   //Forcing function arguments within the acceptable range
   MyLight = std::max(0.0,LightAtTop);
   MyKValue = std::max(0.0,KValue);
   MyDepth = std::max(0.0,Depth);
   //range checking finished
   if (MyKValue * MyDepth > TINNY)
       return(MyLight * (1.0 - exp(-MyKValue * MyDepth)) / (MyKValue * MyDepth));
   else
       return MyLight;   
   //returns vertically averaged light in the same units as LightAtTop
}	
//******************************************************************************************************************************************************
//
