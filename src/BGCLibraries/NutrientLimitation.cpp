#include <math.h>
#include <stdio.h>
#include <iostream>
#include "BGCHeader.h"
//#include <cstdlib>
//#include <cstdio>
//#include <cmath>
//#include <exception>
using namespace std;

/*****************************************************************************************************************************************/
//Based on: Jørgensen, S.E., Bendoricchio, G., 2001. Fundamentals of ecological modelling. Developments
//in Ecological Modelling 21. Elsevier, Amsterdam.
//This function retunrs nutrient limitation based on the cell quota. It may be used for any nutrient
double InternalNutrientLimitation(double CellQuota, double MinCellQuota, double HalfSaturation)
{
   //Cell quotas should be provided as a fraction as well as the HalfSaturation constant	
   double LiebigLimitation = 1.0, MyCellQuota, MyMinCellQuota, MyHalfSaturation;
   double Limitation;
   //Checking that function argumenbts are within acceptable ranges
   MyCellQuota = std::max(0.0,CellQuota);
   MyMinCellQuota = std::max(0.0,MinCellQuota);
   MyHalfSaturation = std::max(0.0,HalfSaturation);
   //Done with range checking
   Limitation = std::max((MyCellQuota - MyMinCellQuota)/ (MyCellQuota + MyHalfSaturation - MyMinCellQuota),0.0);
   LiebigLimitation = std::min(LiebigLimitation,Limitation);
   return LiebigLimitation;
}

/*****************************************************************************************************************************************/
//Based on a hyperbolic function and assuming that nitrogen limitation is alleviated equaly by NO3+NO2
//and ammonium. The final result is limitied to a maximum of 1.0.
//This function returns limitation by ammonia+nitrate+nitrite
double NitrateAndAmmoniumLimitation(double NH4, double KNH4, double NO3, double KNO3, double NO2) 
{ 
   //NH4, NO3 and NO2 - N concentrations in ammonia, nitrate and nitrite forms
   //KNH4 and KNO3 - half-saturation constants for ammonia and NO3+NO2 (in the same units as concentrations) 
   double cff1, cff2, L_NH4, L_NO3, MyNH4, MyKNH4, MyNO3, MyKNO3, MyNO2, TINNY = 0.0000000001;

   //Checking that function argumenbts are within acceptable ranges
   MyNH4 = std::max(0.0,NH4);
   MyKNH4 = std::max(0.0,KNH4);
   MyNO3 = std::max(0.0,NO3);
   MyKNO3 = std::max(0.0,KNO3);
   MyNO2 = std::max(0.0,NO2);
   //Done with range checking
   if (MyKNH4 > TINNY)
   {	    
      cff1= MyNH4 / MyKNH4;
      L_NH4=std::max(cff1/(1.0+cff1),0.0);
   }   
   else
      L_NH4 = 1.0; 
   if (MyKNO3) 
   {	   
      cff2= (MyNO3 + MyNO2) / MyKNO3;
      L_NO3=std::max(cff2/(1.0+cff2),0.0);
   }
   else
      L_NO3 = 1.0;	   
   return std::min(L_NO3+L_NH4,1.0);//Return dimensionless limitation [0 1]
}
/*****************************************************************************************************************************************/
//General purpose Michaelis-Menten function
double MichaelisMentenLimitation(double N, double KN)
{
   double MyN, MyKN, TINNY = 0.0000000001;
   MyN = std::max(0.0,N);
   MyKN = std::max(0.0,KN);
   if (MyKN > TINNY)   
      return MyN / (MyN + MyKN);
   else
      return 1.0;
}
/*****************************************************************************************************************************************/

