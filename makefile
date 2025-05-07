# Makefile created by Pedro for the DissObjt with _PORT_FORTRAN_

#define the C compiler to use
FC = ifort
CPPFLAGS = -P -traditional -D_GLIBCXX_USE_CXX11_ABI=0
CC = gcc
CXX = gcc
CFLAGS = -D_GLIBCXX_USE_CXX11_ABI=0
CXXFLAGS = -D_GLIBCXX_USE_CXX11_ABI=0
LDFLAGS =
AR = ar
ARFLAGS = r
#LIBS = -L/cluster/home/pduarte/models2/ecodynamo/ecolib -lBGCFunctions
#INCLUDE = -L/cluster/home/pduarte/models2/ecodynamo/ecolib/libBGCFunctions.so
#FFLAGS -mcmodel=large -xHOST #-Nmpi
#LIBRARIES = -L/cluster/home/pduarte/models2/ecodynamo/ecolib -lBGCFunctions
#SRC = Test1.f90 ecodynamo_cpp.f90

Test1.o:
	$(FC) -o Test1.exe $(SRC) Test1.f90 $(INCLUDES) ecodynamo_cpp.f90 $(LIBRARIES) /cluster/home/pduarte/pduarte8/EcodynamoLib/ecolib/libBGCFunctions.so 
#Dissobjt.o:
#	$(CC) $(CFLAGS) $(INCLUDE) -o ../../ecolib/libdissobjt.so $(SRC)	

#Dissobjt.so:
#	$(CC) -shared -o Dissobjt.so Dissobjt.o
#     clean:
#	rm -f core Dissobjt.o
