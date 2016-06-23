KOKKOS_PATH = ${HOME}/kokkos-tutorial/kokkos
KOKKOS_DEVICES = "OpenMP"
EXE_NAME = "CoMD-kokkos"

SRC = $(wildcard *.cpp)

default: build
	echo "Start Build"

# double precision (ON/OFF)
DOUBLE_PRECISION = OFF

CXX = g++
EXE = ${EXE_NAME}.host
KOKKOS_ARCH = "SNB"

CXXFLAGS = -O3 -g -fopenmp
LINK = ${CXX} 
LINKFLAGS = -g -fpermissive -Wwrite-strings

DEPFLAGS = -M

OBJ = $(SRC:.cpp=.o)
LIB = -lm

include $(KOKKOS_PATH)/Makefile.kokkos

BIN_DIR=../bin/

# Check for double precision
ifeq ($(DOUBLE_PRECISION), ON)
CXXFLAGS += -DDOUBLE
else
CXXFLAGS += -DSINGLE
endif

build: $(EXE)

$(EXE): $(BIN_DIR) CoMD_info.h $(OBJ) $(KOKKOS_LINK_DEPENDS)
	$(LINK) $(KOKKOS_LDFLAGS) $(LINKFLAGS) $(EXTRA_PATH) $(OBJ) $(KOKKOS_LIBS) $(LIB) -o $(BIN_DIR)$(EXE)

clean: kokkos-clean 
	rm -f *.o *.cuda *.host

# Compilation rules

%.o:%.cpp $(KOKKOS_CPP_DEPENDS)
	$(CXX) $(KOKKOS_CPPFLAGS) $(KOKKOS_CXXFLAGS) $(CXXFLAGS) $(EXTRA_INC) -c $<

CoMD_info.h: Makefile
	./generate_info_header ${CoMD_VARIANT} "$(CXX)" "$(CXXFLAGS)" "$(LDFLAGS)"

$(BIN_DIR):
	@if [ ! -d ${BIN_DIR} ]; then mkdir -p ${BIN_DIR} ; fi
