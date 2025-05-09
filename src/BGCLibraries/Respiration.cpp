#include <math.h>
#include <stdio.h>
#include "BGCHeader.h"
#include <iostream>
using namespace std;



// Langdon, C.: The significance of respiration in production measurements based on oxygen, ICES marine Science Symposium, 197, 69-78, 1993.

double Respiration1(double Maintenance, double GrossProduction, double RespirationCoefficient, double WaterTemperature, double TemperatureAugmentationRate, double Tmin)
{
   double MyMaintenance = 0.0, MyGrossProduction, Respiration = 0.0;	
   MyMaintenance = std::max(0.0,Maintenance);
   MyGrossProduction = std::max(0.0,GrossProduction);
   Respiration = MyMaintenance;
   Respiration = Respiration + RespirationCoefficient * MyGrossProduction
           * TemperatureExponentialLimitation(WaterTemperature, TemperatureAugmentationRate, Tmin);
   return Respiration;
}
