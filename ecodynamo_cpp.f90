 MODULE ecodynamocpp_mod

!svn $Id: ecodynamo_cpp.f90 1372 2015-11-03 00:38:29 mitya $
!=======================================================================
!                                                                      !
!  ECODYNAMO CPP PACKAGE:                                              !
!                                                                      !
!  This package is used to provide interface to ecodynamo cpp functions!
!                                                                      !
!----------------------------------------------------------------------!

      implicit none

      INTERFACE

         SUBROUTINE light_new(LOBJ) BIND(C, NAME="light_new__")
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_LONG
         integer(C_LONG) :: LOBJ
         END SUBROUTINE light_new 


         SUBROUTINE light_new_go(LOBJ,MyHou,MyDa,lat,clou,cawdi,srfl)   &
         BIND(C, NAME="light_new_go__")
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
         integer(C_LONG), intent(in) :: LOBJ
         real(C_DOUBLE), intent(in) ::  MyHou, MyDa
         real(C_DOUBLE), intent(in) :: cawdi, clou, lat
         real(C_DOUBLE), intent(out) :: srfl
         END SUBROUTINE light_new_go


         SUBROUTINE phytoplankton_new(PHYOBJ,Pmax,Iopt,ImaxE,PhyIS,     &
     &     Beta,                                                        &
     &     AEiler,BEiler,CEiler,MaintResp,RespCoeff,DocStressLoss,      &
     &     PhyMRD,RedfieldC,RedfieldN,RedfieldP,                        &
     &     TemperatureAugmentationRate,RatioLightDarkRespiration,       &
     &     minNPRatio, maxNPRatio,PMaxUptake,NMaxUptake,KP, K_NO3,      &
     &     KNH4,MinPCellQuota,MaxPCellQuota,MinNCellQuota,              &
     &     MaxNCellQuota,KPInternal, KNInternal, wPhy,                  &
     &     CarbonToOxygenProd,CarbonToOxygenResp,                       & 
     &     TminRespiration,TminPhotosynthesis,                          & 
     &     NitrogenLimitation,PhosphorusLimitation, SilicaLimitation,   &
     &     MaxSiCellQuota, MinSiCellQuota,minNSiRatio, SiMaxUptake,     &
     &     KSi, KSiInternal,                                            &
     &     RedfieldSi,PIFunction,NutLimType)                            & 
         BIND(C, NAME='phytoplankton_new__')
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_INT,C_DOUBLE,C_LONG
         integer(C_LONG) :: PHYOBJ
         real(C_DOUBLE), intent(in) :: Pmax                        ! Maximum photosynthetic rate (1/h)
         real(C_DOUBLE), intent(in) :: Iopt                        ! Optimal light intensity (microEisntein/m2/s)
         real(C_DOUBLE), intent(in) :: ImaxE                       ! Saturation light intensity (microEisntein/m2/s)
         real(C_DOUBLE), intent(in) :: PhyIS                       ! mg C mg C-1 h-1 microM photons m2 s
         real(C_DOUBLE), intent(in) :: Beta                        ! mg C mg C-1 h-1 microM photons m2 s
         real(C_DOUBLE), intent(in) :: AEiler                      ! microEisntein/m2/s
         real(C_DOUBLE), intent(in) :: BEiler                      ! microEisntein/m2/s
         real(C_DOUBLE), intent(in) :: CEiler                      ! microEisntein/m2/s
         real(C_DOUBLE), intent(in) :: MaintResp                   ! mmol O2/mg Chl/h
         real(C_DOUBLE), intent(in) :: RespCoeff                   ! nondimensional
         real(C_DOUBLE), intent(in) :: DocStressLoss               ! nondimensional 
         real(C_DOUBLE), intent(in) :: PhyMRD                      ! 1/day
         real(C_DOUBLE), intent(in) :: RedfieldC                   ! gC/gP 
         real(C_DOUBLE), intent(in) :: RedfieldN                   ! gN/gP 
         real(C_DOUBLE), intent(in) :: RedfieldP                   ! gP/gP 
         real(C_DOUBLE), intent(in) :: TemperatureAugmentationRate ! 1/degrees
         real(C_DOUBLE), intent(in) :: RatioLightDarkRespiration   ! nondimensional
         real(C_DOUBLE), intent(in) :: minNPRatio                  ! mgN/mgP
         real(C_DOUBLE), intent(in) :: maxNPRatio                  ! mgN/mgP
         real(C_DOUBLE), intent(in) :: PMaxUptake                  ! 1/h
         real(C_DOUBLE), intent(in) :: NMaxUptake                  ! 1/h
         real(C_DOUBLE), intent(in) :: KP                          ! microM
         real(C_DOUBLE), intent(in) :: K_NO3                       ! mmol/m3
         real(C_DOUBLE), intent(in) :: KNH4                        ! microM
         real(C_DOUBLE), intent(in) :: MinPCellQuota               ! mgP/mgC
         real(C_DOUBLE), intent(in) :: MaxPCellQuota               ! mgP/mgC
         real(C_DOUBLE), intent(in) :: MinNCellQuota               ! mgN/mgC
         real(C_DOUBLE), intent(in) :: MaxNCellQuota               ! mgN/mgC
         real(C_DOUBLE), intent(in) :: KPInternal                  ! mgP/mgC
         real(C_DOUBLE), intent(in) :: KNInternal                  ! mgN/mgC
         real(C_DOuBLE), intent(in) :: wPhy                        ! m/day
         real(C_DOUBLE), intent(in) :: CarbonToOxygenProd          ! mgC/mgO2
         real(C_DOUBLE), intent(in) :: CarbonToOxygenResp          ! mgC/mgO2
         real(C_DOUBLE), intent(in) :: TminRespiration             ! degrees
         real(C_DOUBLE), intent(in) :: TminPhotosynthesis          ! degrees
         integer(C_INT), intent(in) :: NitrogenLimitation          ! nondimensional
         integer(C_INT), intent(in) :: PhosphorusLimitation        ! nondimensional
         integer(C_INT), intent(in) :: SilicaLimitation            ! nondimensional
         real(C_DOUBLE), intent(in) :: MaxSiCellQuota              ! mgSi/mgC
         real(C_DOUBLE), intent(in) :: MinSiCellQuota              ! mgSi/mgC
         real(C_DOUBLE), intent(in) :: minNSiRatio                 ! mgN/mgSi
         real(C_DOUBLE), intent(in) :: SiMaxUptake                 ! 1/h
         real(C_DOUBLE), intent(in) :: KSi                         ! microM
         real(C_DOUBLE), intent(in) :: KSiInternal                 ! mgSi/mgC 
         real(C_DOUBLE), intent(in) :: RedfieldSi                  ! gSi/gP
         integer(C_INT), intent(in) :: PIFunction                  ! nondimensional
         integer(C_INT), intent(in) :: NutLimType                  ! nondimensional
         END SUBROUTINE phytoplankton_new


         SUBROUTINE phytoplankton_go(PHYOBJ,Hz,dt)                      & 
         BIND(C, NAME='phytoplankton_go__')
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_INT, C_DOUBLE, C_LONG
         integer(C_LONG), intent(in) :: PHYOBJ
         real(C_DOUBLE), intent(in) ::  Hz, dt
         END SUBROUTINE phytoplankton_go


      SUBROUTINE phytoplankton_production(     PHYOBJ,               &
     &                                            TopLight,             & 
     &                                            BottomLight,          &
     &                                            KValue,               &
     &                                            temp, yday,           &
     &                                            GrossProduction,      &
     &                                            PhyN,PhyP,PhySi,Phyt, &
     &                                            PhyIS,                &
     &                                            Chl2Carbon,           &
     &                                            OxygenProduction,     &
     &                                            Line,Column,Layer,    &
     &                                            LayerThickness)       & 
         BIND(C,NAME='phytoplankton_production__')
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_INT, C_DOUBLE, C_LONG
         integer(C_LONG), intent(in) :: PHYOBJ
         real(C_DOUBLE), intent(in) :: TopLight
         real(C_DOUBLE), intent(in) :: BottomLight
         real(C_DOUBLE), intent(in) :: KValue
         real(C_DOUBLE), intent(in) :: temp
!         integer(C_INT), intent(in) :: casep
         real(C_DOUBLE), intent(in) :: yday
         real(C_DOUBLE), intent(inout) :: GrossProduction
         real(C_DOUBLE), intent(in) :: PhyN                ! Phytoplankton concentration in nitrogen units (mmol N / m3)
         real(C_DOUBLE), intent(in) :: PhyP                ! Phytoplankton concentration in phosphorus units (mmol P / m3)
         real(C_DOUBLE), intent(in) :: PhySi               ! Phytoplankton concentration in silica units (mmol P / m3)
         real(C_DOUBLE), intent(in) :: Phyt                ! Phytoplankton concentration in carbon units (mmol C / m3)
         real(C_DOUBLE), intent(in) :: PhyIS               ! m2/W
         real(C_DOUBLE), intent(in) :: Chl2Carbon
         real(C_DOUBLE), intent(inout) :: OxygenProduction
         integer(C_INT), intent(in) :: Line
         integer(C_INT), intent(in) :: Column
         integer(C_INT), intent(in) :: Layer
         real(C_DOUBLE), intent(in) :: LayerThickness
         END SUBROUTINE phytoplankton_production

      SUBROUTINE light_fortran_go( Dangle, Hangle,Rsolar, latr,lonr,    &
     &     cloud, Tair, Pair, Hair,  srflx)                             &  
      BIND(C, NAME="light_fort_go")
      USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE
      real(C_DOUBLE), intent(in) :: Dangle, Hangle, Rsolar
      real(C_DOUBLE), intent(in) :: cloud, latr, lonr, Tair, Pair, Hair
      real(C_DOUBLE), intent(out) :: srflx
      END SUBROUTINE light_fortran_go

      
         SUBROUTINE phytoplankton_nitrogen_uptake(    PHYOBJ,           &
     &                                             NH4,NO3,dumNitrite,  & 
     &                                             cffNH4, cffNO3NO2,   &
     &                                             PhyN,PhyP,Phyt)      &
         BIND(C,NAME='phytoplankton_nitrogen_uptake__')
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
         integer(C_LONG), intent(in) :: PHYOBJ
         real(C_DOUBLE), intent(in) :: NH4                  ! [millimole/m3]
         real(C_DOUBLE), intent(in) :: NO3                  ! [millimole/m3]
         real(C_DOUBLE), intent(in) :: dumNitrite
         real(C_DOUBLE), intent(inout) :: cffNH4, cffNO3NO2
         real(C_DOUBLE), intent(in) :: PhyN                 ! Phytoplankton concentration in nitrogen units (mmol N / m3)
         real(C_DOUBLE), intent(in) :: PhyP                 !Phytoplankton concentration in phosphorus units (mmol P / m3)
         real(C_DOUBLE), intent(in) :: Phyt                 ! Phytoplankton concentration in carbon units (mmol C / m3)         
         END SUBROUTINE phytoplankton_nitrogen_uptake


         SUBROUTINE phytoplankton_phosphorus_uptake(PHYOBJ,             &
     &                                             PO4,cffPO4,          &
     &                                             PhyN,PhyP,Phyt)      &
         BIND(C,NAME='phytoplankton_phosphorus_uptake__')
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
         integer(C_LONG), intent(in) :: PHYOBJ
         real(C_DOUBLE), intent(in) :: PO4                  ! [millimole/m3]
         real(C_DOUBLE), intent(inout) :: cffPO4
         real(C_DOUBLE), intent(in) :: PhyN                 ! Phytoplankton concentration in nitrogen units (mmol N / m3)
         real(C_DOUBLE), intent(in) :: PhyP                 ! Phytoplankton concentration in phosphorus units (mmol N / m3)
         real(C_DOUBLE), intent(in) :: Phyt                 ! Phytoplankton concentration in carbon units (mmol C / m3)         
         END SUBROUTINE phytoplankton_phosphorus_uptake

        SUBROUTINE phytoplankton_silica_uptake(PHYOBJ,                  &
     &                                             SiOH4,cffSiOH4,      &
     &                                             LphN,LphS,Lphy)      &

         BIND(C,NAME='phytoplankton_silica_uptake__')              
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
         integer(C_LONG), intent(in) :: PHYOBJ
         real(C_DOUBLE), intent(in) :: SiOH4                ![millimole/m3]
         real(C_DOUBLE), intent(inout) :: cffSiOH4
         real(C_DOUBLE), intent(in) :: LphN                 !Phytoplankton concentration in nitrogen units (mmol N / m3)
         real(C_DOUBLE), intent(in) :: LphS                 !Phytoplankton concentration in silica units (mmol N / m3)
         real(C_DOUBLE), intent(in) :: Lphy                 !Phytoplankton concentration in carbon units (mmol C / m3)
         END SUBROUTINE phytoplankton_silica_uptake
         

         SUBROUTINE phytoplankton_respiration(PHYOBJ,                   &
     &                                        temp,                     &
     &                                        cffCResp,                 &
     &                                        GrossProduction,          &
     &                                        Phyt,                     &
     &                                        Oxygen,                   &
     &                                        Chl2Carbon,               &
     &                                        OxygenConsumption)        &
   
         BIND(C,NAME='phytoplankton_respiration__')
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
         integer(C_LONG), intent(in) :: PHYOBJ
         real(C_DOUBLE), intent(in) :: temp
         real(C_DOUBLE), intent(inout) :: cffCResp
         real(C_DOUBLE), intent(in) :: GrossProduction
         real(C_DOUBLE), intent(in) :: Phyt                   ! Phytoplankton concentration in carbon units (mmol C / m3)  
         real(C_DOUBLE), intent(in) :: Oxygen       
         real(C_DOUBLE), intent(in) :: Chl2Carbon
         real(C_DOUBLE), intent(inout) :: OxygenConsumption
         END SUBROUTINE phytoplankton_respiration         


         SUBROUTINE phytoplankton_exudation(  PHYOBJ,                   &
     &                                        cffCExud,                 &
     &                                        GrossProduction,          &
     &                                        Phyt,                     &
     &                                        NCellQuota,               &
     &                                        PCellQuota)               &
         BIND(C,NAME='phytoplankton_exudation__')
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
         integer(C_LONG), intent(in) :: PHYOBJ
         real(C_DOUBLE), intent(inout) :: cffCExud
         real(C_DOUBLE), intent(in) :: GrossProduction
         real(C_DOUBLE), intent(in) :: Phyt                   ! Phytoplankton concentration in carbon units (mmol C / m3) 
         real(C_DOUBLE), intent(in) :: NCellQuota    
         real(C_DOUBLE), intent(in) :: PCellQuota             
         END SUBROUTINE phytoplankton_exudation    

         SUBROUTINE phytoplankton_external_nut_limitation(PHYOBJ,      &
     &                                            NH4,NO3,dumNitrite,  &
     &                                            PO4,Si,Limitation)   &
         BIND(C,NAME='phytoplankton_external_nut_limitation__')
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
         integer(C_LONG), intent(in) :: PHYOBJ
         real(C_DOUBLE), intent(in) :: NH4                  ![millimole/m3]
         real(C_DOUBLE), intent(in) :: NO3                  ![millimole/m3]
         real(C_DOUBLE), intent(in) :: dumNitrite           ![millimole/m3]
         real(C_DOUBLE), intent(in) :: PO4                  ![millimole/m3]
         real(C_DOUBLE), intent(in) :: Si                   ![millimole/m3]
         real(C_DOUBLE), intent(inout) :: Limitation        !dimensionless  
         END SUBROUTINE phytoplankton_external_nut_limitation


         SUBROUTINE dissobjt_new(DISSOBJ,                              &
     &                           NitriR,                               &
     &                           kdenit,                               &
     &                           knitO2,                               &
     &                           kdenitO2,                             &
     &                           kt,                                   &
     &                           minRate,                              &
     &                           DenitNH4,                             &
     &                           MinToNH4,                             &
     &                           I0,                                   &
     &                           KI)                                   &
         BIND(C,NAME='dissobjt_new__')
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_LONG, C_DOUBLE
         integer(C_LONG) :: DISSOBJ
         real(C_DOUBLE), intent(in) :: NitriR
         real(C_DOUBLE), intent(in) :: kdenit
         real(C_DOUBLE), intent(in) :: knitO2                   
         real(C_DOUBLE), intent(in) :: kdenitO2    
         real(C_DOUBLE), intent(in) :: kt 
         real(C_DOUBLE), intent(in) :: minRate   
         real(C_DOUBLE), intent(in) :: DenitNH4 
         real(C_DOUBLE), intent(in) :: MinToNH4  
         real(C_DOUBLE), intent(in) :: KI 
         real(C_DOUBLE), intent(in) :: I0           
         END SUBROUTINE dissobjt_new      

         SUBROUTINE dissobjt_go(DISSOBJ,                              &
     &                          LayerThickness,                       &
     &                          TimeStep)                             &
         BIND(C,NAME='dissobjt_go__')
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_LONG, C_DOUBLE
         integer(C_LONG), intent(in) :: DISSOBJ
         real(C_DOUBLE), intent(in) :: LayerThickness, TimeStep         
         END SUBROUTINE dissobjt_go   

         SUBROUTINE dissobjt_nitrification(DISSOBJ,                   &
     &                                     TopLight,                  &
     &                                     BottomLight,               &
     &                                     KValue,                    &
     &                                     LayerThickness,            &
     &                                     temp,                      &
     &                                     NH4,                       &
     &                                     oxygen,                    &
     &                                     NitrificationFlux,         &
     &                                     OxygenFlux)                &
         BIND(C,NAME='dissobjt_nitrification__')
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_LONG, C_DOUBLE
         integer(C_LONG), intent(in) :: DISSOBJ
         real(C_DOUBLE), intent(in) :: TopLight
         real(C_DOUBLE), intent(in) :: BottomLight
         real(C_DOUBLE), intent(in) :: KValue
         real(C_DOUBLE), intent(in) :: LayerThickness
         real(C_DOUBLE), intent(in) :: temp
         real(C_DOUBLE), intent(in) :: NH4
         real(C_DOUBLE), intent(in) :: oxygen
         real(C_DOUBLE), intent(inout) :: NitrificationFlux
         real(C_DOUBLE), intent(inout) :: OxygenFlux
         END SUBROUTINE dissobjt_nitrification
 
         SUBROUTINE dissobjt_denitrification(DISSOBJ,                 &
     &                                     temp,                      &
     &                                     NO3,                       &
     &                                     oxygen,                    &
     &                                     NH4Flux,                   &
     &                                     NO3Flux)                   &
         BIND(C,NAME='dissobjt_denitrification__')
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_LONG, C_DOUBLE
         integer(C_LONG), intent(in) :: DISSOBJ
         real(C_DOUBLE), intent(in) :: temp
         real(C_DOUBLE), intent(in) :: NO3
         real(C_DOUBLE), intent(in) :: oxygen
         real(C_DOUBLE), intent(inout) :: NH4Flux
         real(C_DOUBLE), intent(inout) :: NO3Flux
         END SUBROUTINE dissobjt_denitrification

      SUBROUTINE dissobjt_CarbonMineralization(DISSOBJ,               &
     &                                     temp,                      &
     &                                     POC,                       &
     &                                     oxygen,                    &
     &                                     POCFlux,                   &
     &                                     minRateC)                  &
         BIND(C,NAME='dissobjt_CarbonMineralization__')
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_LONG, C_DOUBLE
         integer(C_LONG), intent(in) :: DISSOBJ
         real(C_DOUBLE), intent(in) :: temp
         real(C_DOUBLE), intent(in) :: POC
         real(C_DOUBLE), intent(in) :: oxygen
         real(C_DOUBLE), intent(inout) :: POCFlux
         real(C_DOUBLE), intent(inout) :: minRateC
         END SUBROUTINE dissobjt_CarbonMineralization

    
      SUBROUTINE dissobjt_NitrogenMineralization(DISSOBJ,             &
     &                                     temp,                      &
     &                                     PON,                       &
     &                                     oxygen,                    &
     &                                     PONFlux,                   &
     &                                     OxygenFlux,                &
     &                                     minRateN)                  &
         BIND(C,NAME='dissobjt_NitrogenMineralization__')
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_LONG, C_DOUBLE
         integer(C_LONG), intent(in) :: DISSOBJ
         real(C_DOUBLE), intent(in) :: temp
         real(C_DOUBLE), intent(in) :: PON
         real(C_DOUBLE), intent(in) :: oxygen
         real(C_DOUBLE), intent(inout) :: PONFlux
         real(C_DOUBLE), intent(inout) :: OxygenFlux
         real(C_DOUBLE), intent(inout) :: minRateN
         END SUBROUTINE dissobjt_NitrogenMineralization   


      SUBROUTINE dissobjt_PhosphorusMineralization(DISSOBJ,           &
     &                                     temp,                      &
     &                                     POP,                       &
     &                                     oxygen,                    &
     &                                     POPFlux,                   &
     &                                     minRateP)                  &
         BIND(C,NAME='dissobjt_PhosphorusMineralization__')
         USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_LONG, C_DOUBLE
         integer(C_LONG), intent(in) :: DISSOBJ
         real(C_DOUBLE), intent(in) :: temp
         real(C_DOUBLE), intent(in) :: POP
         real(C_DOUBLE), intent(in) :: oxygen
         real(C_DOUBLE), intent(inout) :: POPFlux
         real(C_DOUBLE), intent(inout) :: minRateP
         END SUBROUTINE dissobjt_PhosphorusMineralization   


      ! Production-light functions to calculate light limitation

      REAL(C_DOUBLE) FUNCTION Platt1(PARtop,KValue,Depth, &
     & Pmax,beta,slope,EulerSteps)          &
       BIND(C,NAME='Platt1')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
       REAL(C_DOUBLE), intent(in),value :: PARtop
       REAL(C_DOUBLE), intent(in),value :: KValue, Depth
       REAL(C_DOUBLE), intent(in),value :: Pmax,beta,slope
       integer(C_LONG), intent(in),value:: EulerSteps
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION Platt2(PAR,    &
     & Pmax,beta,slope)          &
       BIND(C,NAME='Platt2')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
       REAL(C_DOUBLE), intent(in),value :: PAR
       REAL(C_DOUBLE), intent(in),value :: Pmax,beta,slope
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION Steele1(PARtop,KValue,Depth,PARopt) &
       BIND(C,NAME='Steele1')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
       REAL(C_DOUBLE), intent(in),value :: PARtop
       REAL(C_DOUBLE), intent(in),value :: KValue, Depth, PARopt
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION Steele2(PAR,PARopt) &
       BIND(C,NAME='Steele2')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
       REAL(C_DOUBLE), intent(in),value :: PAR
       REAL(C_DOUBLE), intent(in),value :: PARopt
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION EilersAndPeeters1(PARtop,   &
     & KValue,Depth,a,b,c,Pmax)          &
       BIND(C,NAME='EilersAndPeeters1')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
       REAL(C_DOUBLE), intent(in), value :: PARtop, Pmax
       REAL(C_DOUBLE), intent(in), value :: KValue, Depth, a, b, c
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION EilersAndPeeters2(PAR,a,b,c,Pmax)&
       BIND(C,NAME='EilersAndPeeters2')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
       REAL(C_DOUBLE), intent(in),value :: PAR
       REAL(C_DOUBLE), intent(in),value :: a, b, c, Pmax
      END FUNCTION

! End production-light functions

      ! Temperature limitation functions

      REAL(C_DOUBLE) FUNCTION TemperatureExponentialLimitation  &
     & (WaterTemperature,TemperatureAugmentationRate,Tmin) &
       BIND(C,NAME='TemperatureExponentialLimitation')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
       REAL(C_DOUBLE), intent(in),value :: WaterTemperature
       REAL(C_DOUBLE), intent(in),value :: TemperatureAugmentationRate
       REAL(C_DOUBLE), intent(in),value :: Tmin
      END FUNCTION


! End temperature limitation functions

      ! Nutrient limitation function
      REAL(C_DOUBLE) FUNCTION InternalNutrientLimitation     &
     & (CellQuota,MinCellQuota,HalfSaturation) &
       BIND(C,NAME='InternalNutrientLimitation')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
       REAL(C_DOUBLE), intent(in),value :: CellQuota
       REAL(C_DOUBLE), intent(in),value :: MinCellQuota
       REAL(C_DOUBLE), intent(in),value :: HalfSaturation
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION NitrateAndAmmoniumLimitation   &
     & (NH4,KNH4,NO3,KNO3,NO2)  &
       BIND(C,NAME='NitrateAndAmmoniumLimitation')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
       REAL(C_DOUBLE), intent(in),value :: NH4, KNH4, NO3
       REAL(C_DOUBLE), intent(in),value :: KNO3, NO2
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION MichaelisMentenLimitation(N,KN)&
       BIND(C,NAME='MichaelisMentenLimitation')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
       REAL(C_DOUBLE), intent(in),value :: N, KN
      END FUNCTION

! End nutrient limitation functions

      ! Grazing functions
      REAL(C_DOUBLE) FUNCTION Hollings(K,Prey,HollingsType)&
       BIND(C,NAME='Hollings')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE, C_LONG
       REAL(C_DOUBLE), intent(in),value :: K, Prey
       integer(C_LONG), intent(in),value:: HollingsType
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION IvlevFunction(Lambda,Prey) &
       BIND(C,NAME='IvlevFunction')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE
       REAL(C_DOUBLE), intent(in),value :: Lambda, Prey
      END FUNCTION
! End grazing functions

      ! Biogeochemical cycles functions
      REAL(C_DOUBLE) FUNCTION DenitrificationToNH4(NO3,Kdenit,&
     & TemperatureLimitation, OxygenLimitation)&
       BIND(C,NAME='DenitrificationToNH4')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE
       REAL(C_DOUBLE), intent(in),value :: NO3, Kdenit
       REAL(C_DOUBLE), intent(in),value :: TemperatureLimitation
       REAL(C_DOUBLE), intent(in),value :: OxygenLimitation
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION DenitrificationToN2 &
     & (DenitrificationToNH4, alfa)&
       BIND(C,NAME='DenitrificationToN2')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE
       REAL(C_DOUBLE), intent(in),value :: DenitrificationToNH4
       REAL(C_DOUBLE), intent(in),value :: alfa
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION Mineralization(minR, &
     & TemperatureLimitation,OxygenLimitation,Xorganic) &
       BIND(C,NAME='Mineralization')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE
       REAL(C_DOUBLE), intent(in),value :: minR
       REAL(C_DOUBLE), intent(in),value :: TemperatureLimitation
       REAL(C_DOUBLE), intent(in),value :: OxygenLimitation
       REAL(C_DOUBLE), intent(in),value :: Xorganic
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION Nitrification(NH4,Knit,&
     & TemperatureLimitation, OxygenLimitation,      &
     & LightLimitation) &
       BIND(C,NAME='Nitrification')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE
       REAL(C_DOUBLE), intent(in),value :: NH4, Knit
       REAL(C_DOUBLE), intent(in),value :: TemperatureLimitation
       REAL(C_DOUBLE), intent(in),value :: OxygenLimitation
       REAL(C_DOUBLE), intent(in),value :: LightLimitation
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION LightLimNitr(KI,I0,Light) &
       BIND(C,NAME='LightLimNitr')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE
       REAL(C_DOUBLE), intent(in),value :: KI, I0, Light
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION OrganicDissolution(dissR, &
     & TemperatureLimitation, Xorganic) &
       BIND(C,NAME='OrganicDissolution')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE
       REAL(C_DOUBLE), intent(in),value :: dissR
       REAL(C_DOUBLE), intent(in),value :: TemperatureLimitation
       REAL(C_DOUBLE), intent(in),value :: Xorganic
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION PhosphorusAdsorption &
     & (PO4InPoreWater,Pads,Pmax,OxygenInPoreWater,&
     & OxygenThreshold,Ka1,Ka2) &
       BIND(C,NAME='PhosphorusAdsorption')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE
       REAL(C_DOUBLE), intent(in),value :: PO4InPoreWater,Pads
       REAL(C_DOUBLE), intent(in),value :: Pmax,OxygenInPoreWater
       REAL(C_DOUBLE), intent(in),value :: OxygenThreshold,Ka1,Ka2
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION PhosphorusDesorption &
     & (Pads, Kd, Pmax) BIND(C,NAME='PhosphorusDesorption')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE
       REAL(C_DOUBLE), intent(in),value :: Pads,Kd,Pmax
      END FUNCTION

      REAL(C_DOUBLE) FUNCTION Respiration1 &
     & (Maintenance,GrossProduction,RespirationCoeff, &
     &  WaterTemperature,TemperatureAugmentationRate, &
     &  Tmin) &
       BIND (C,NAME='Respiration1')
       USE, INTRINSIC :: ISO_C_BINDING, ONLY: C_DOUBLE
       REAL(C_DOUBLE), intent(in),value :: Maintenance
       REAL(C_DOUBLE), intent(in),value :: GrossProduction
       REAL(C_DOUBLE), intent(in),value :: RespirationCoeff
       REAL(C_DOUBLE), intent(in),value :: WaterTemperature
       REAL(C_DOUBLE), intent(in),value :: TemperatureAugmentationRate
       REAL(C_DOUBLE), intent(in),value :: Tmin
      END FUNCTION
    

      ! End biogeochemical cycles functions

      END INTERFACE

      END MODULE ecodynamocpp_mod


