#include <math.h>
#include <stdio.h>
#include <iostream>
#include "BGCHeader.h"
#include <array>
using namespace std;


//The functions below are described in:
//Serpa, D., Ferreira, P.P., Caetano, M., Cancela da Fonseca, L., Dinis, M.T., and P. Duarte (2012) Modelling of biogeochemical processes in fish earth ponds: Model development
//and calibration. Ecological Modelling 247: 286-301
//and references therein

/************************************************************************************************************************************************/
//This function computes denitrification to ammonia, limited by temperature and inhibited by oxygen
double DenitrificationToNH4(double NO3, double Kdenit/*T^(-1)*/, double TemperatureLimitation, double OxygenLimitation)
{
   //NO3 - N-nitrate concentration  molar N concentration and Kdenit - Maximum denitrification rate (1/time)
   //TemperatureLimitation (>0) and OxygenLimitation [0 1], are dimensionless 
   //and may be calculated with other functions of this library (TemperatureExponentialLimitation and MichaelisMentenLimitation)

   double MyNO3, MyKdenit, MyTempLim, MyOxyLim;
   
   //Forcing function arguments to be within an acceptable range  
   MyNO3 = std::max(0.0,NO3);
   MyKdenit = std::max(0.0,Kdenit);
   MyTempLim = std::max(0.0,TemperatureLimitation);
   MyOxyLim = std::max(0.0,OxygenLimitation);
   MyOxyLim = std::min(1.0,MyOxyLim);
   //range check finished 

   return MyKdenit * MyNO3 * MyTempLim * (1.0 - MyOxyLim); 
   //returns units of N-NO3/N-NH4 concentration decrease/increase in the water per unit of time
   //concentration and time units are defined by the user
}
/************************************************************************************************************************************************/
//This function computes denitrifcation to N2 and it depends on the results of the function DenitrificationToNH4
double DenitrificationToN2(double DenitrificationToNH4, double alfa)
{
   //alfa - proportion of denitrification that ends in N2 (dimensionless). Setting alfa = 1 will convert all nitrate denitrified to N2 	
   double MyDenitToNH4, Myalfa;
   
   //Forcing function arguments to be within an acceptable range
   MyDenitToNH4 = std::max(0.0,DenitrificationToNH4);
   Myalfa = std::max(0.0,alfa);
   Myalfa = std::min(1.0,Myalfa);
   //range check finished

   return MyDenitToNH4 * Myalfa; 
   //returns units of N-NH4/N2 concentration decrease/increase in the water per unit of time
   //concentration and time units are defined by the user
}
/************************************************************************************************************************************************/
//This function computes mineralization of organic matter in the water or in the sediments limited by temperature and oxygen
double Mineralization(double minR/*T^(-1)*/,double TemperatureLimitation, double OxygenLimitation, double Xorganic)
{
   //minR - Maximum mineralization rate (1/time)
   //TemperatureLimitation (>0) and OxygenLimitation [0 1] are dimensionless
   //and may be calculated with other functions of this library (TemperatureExponentialLimitation and MichaelisMentenLimitation)
   //Xorganic stands for any organic substance being mineralized and it may be expressed in different currencies such as
   //carbon, nitrogen and phosphorus
   
   double MyminR, MyTempLim, MyOxyLim, MyXorganic;

   //Forcing function arguments to be within an acceptable range
   MyTempLim = std::max(0.0,TemperatureLimitation);
   MyOxyLim = std::max(0.0,OxygenLimitation);
   MyOxyLim = std::min(1.0,MyOxyLim);
   MyminR = std::max(0.0,minR);
   MyXorganic = std::max(0.0,Xorganic);
   //range check finished
   
   return MyminR * MyXorganic * MyTempLim * MyOxyLim; 
   //returns units of Xorganic concentration decrease per unit of time
   //if Xorganic is expressed in concentration per unit of mass of sediments (for example) so the results will also
   //be in similar units. Therefore, to convert it to the concentration of the inorganic substance released to
   //the water, the result must be multiplied by the SedimentWaterRatio in ML^(-3) 
   //concentration and time units are defined by the user
}
/************************************************************************************************************************************************/
//This function computes nitrification limited by temperature and oxygen, and inhibited by light
double Nitrification(double NH4, double Knit/*T^(-1)*/, double TemperatureLimitation, double OxygenLimitation, double LightLimitation)
{
   //NH4 - N-ammonia concentration  molar N concentration and Knit - Maximum nitrification rate (1/time)
   //TemperatureLimitation (>0), OxygenLimitation and LightLimitation [0 1] are dimensionless
   //and may be calculated with other functions of this library
   // (TemperatureExponentialLimitation, MichaelisMentenLimitation and LightLimNitr)

   double MyNH4, MyKnit, MyTempLim, MyOxyLim, MyLightLim;

   //Forcing function arguments to be within an acceptable range
   MyNH4 = std::max(0.0,NH4);
   MyKnit = std::max(0.0,Knit);
   MyTempLim = std::max(0.0,TemperatureLimitation);
   MyOxyLim = std::max(0.0,OxygenLimitation);
   MyOxyLim = std::min(1.0,MyOxyLim);
   MyLightLim = std::max(0.0,LightLimitation);
   MyLightLim = std::min(1.0,MyLightLim); 
   //range check finished
   
   return MyKnit * MyNH4 * MyTempLim * MyOxyLim * MyLightLim; 
   //returns units of N-NH4/N-NO3 concentration decrease/increase in the water per unit of time
   //concentration and time units are defined by the user
}
/************************************************************************************************************************************************/
//This function computes dissolution or particulate organic matter limited by temperature
double OrganicDissolution(double dissR,  double TemperatureLimitation, double Xorganic)
{
   //dissR - Maximum dissolution rate (1/time)
   //TemperatureLimitation (>0)is dimensionless 
   //and it may be calculated with other function of this library (TemperatureExponentialLimitation)
   //Xorganic stands for any organic substance being dissolved and it may be expressed in different currencies such as
   //carbon, nitrogen and phosphorus
   
   double MydissR, MyTempLim, MyXorganic;

   //Forcing function arguments to be within an acceptable range
   MyTempLim = std::max(0.0,TemperatureLimitation);
   MydissR = std::max(0.0,dissR);
   MyXorganic = std::max(0.0,Xorganic);
   //range check finished
   
   return MydissR * MyXorganic * MyTempLim;
   //returns units of Xorganic particulate/X inorganic dissolved concentration decrease/increase per unit of time
   //if Xorganic is expressed in concentration per unit of mass of sediments (for example) so the results will also
   //be in similar units. Therefore, to convert it to the concentration of the dissolved substance released to
   //the water, the result must be multiplied by the SedimentWaterRatio in ML^(-3)
   //concentration and time units are defined by the user

}
/************************************************************************************************************************************************/
//This function calculates the flux of dissolved of P-PO4 adsorbed from the pore water to the sediments. It returns the amount of P lost by the water per unit of time
//It may also be applied to adsorption of P-PO4 by suspended sediments, in which case PO4 and O2 concentrations are not those of the pore water but instead those of the water
//where the particles are suspended.
double PhosphorusAdsorption(double PO4,double Pads/*MM^(-1)*/,double Pmax, double Oxygen, double OxygenThershold, double Ka1, double Ka2)
{
   //PO4 - P-phosphate molar concentration in the water/pore water
   //Pads - P-phosphate sediment contents in mass / mass units (fraction)
   //Pmax - Maximum P-phosphate sediment contents in mass / mass units (fraction)
   //Oxygen concentration in water/pore water in the same units as OxygenThershold
   //Ka1 and Ka2 - Maximum adsorption rates above and below the OxygenThershold (1/time) 

   double MyPmax, MyPO4, MyPads, TINNY = 0.0000000001, MyOxygen, MyOxyThr, MyKa1, MyKa2, Adsorption = 0.0;

   //Forcing function arguments to be within an acceptable range
   MyPmax = std::max(0.0,Pmax);
   MyPads = std::max(0.0,Pads);
   MyPads = std::min(Pads,Pmax); //Pads should not exceed Pmax. If it does should be limiteds for the calculations below and a warning should be issued
   MyPO4  = std::max(0.0,PO4);
   MyOxygen = std::max(0.0,Oxygen);
   MyOxyThr = std::max(0.0,OxygenThershold); 
   MyKa1  = std::max(0.0,Ka1);
   MyKa2  = std::max(0.0,Ka2); 
   //range check finished

   if (MyPmax > TINNY) 
   {
     if (MyOxygen > MyOxyThr) 
        Adsorption =  MyKa1 * (1.0 - MyPads / MyPmax) * MyPO4; //returns units of P-PO4 concentration decrease in the pore water per unit of time
     else                                                      //which may be converted to units of P-PO4 concentration by mass of sediments
        Adsorption =  MyKa2 * (1.0 - MyPads / MyPmax) * MyPO4; //by diving the result by the SedimentWaterRatio in ML^(-3) to compute the
                                                               // P-PO4 gains by the sediments
   }
   return Adsorption; 
}
/************************************************************************************************************************************************/
//This function calculates the flux of desorbed P-PO4 from the sediments to the pore water. It returns the amount of P lost by the sediment per unit of time.
 double PhosphorusDesorption(double Pads/*MM^(-1)*/, double Kd, double Pmax)
{
   //Pads - P-phosphate sediment contents in mass / mass units (fraction)	
   //Kd - Maximum desorption rate (1/time)
   //Pmax - Maximum P-phosphate sediment contents in mass / mass units (fraction)
  	
   double MyPads, MyKd, MyPmax, Desorption = 0.0, TINNY = 0.0000000001;

   //Forcing function arguments to be within an acceptable range
   MyKd  = std::max(0.0,Kd);
   MyPmax = std::max(0.0,Pmax);
   MyPads = std::max(0.0,Pads);
   MyPads = std::min(Pads,Pmax); //Pads should not exceed Pmax. If it does should be limiteds for the calculations below and a warning should be issued
   //range check finished

   if (MyPmax > TINNY)
      Desorption = MyKd * MyPads / MyPmax; //returns Desorption in P-PO4 concentration units per unit of sediment mass
                                           //which may be normalized to concentration per unit of water volume
                                           //multiplying the result of this function by the SedimentWaterRatio in ML^(-3) and
					   //alloing to compute the P-PO4 gains by the water 
   return Desorption;
}
/************************************************************************************************************************************************/

