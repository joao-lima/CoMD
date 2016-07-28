/// \file
/// Frequently needed typedefs.

#ifndef __MYTYPE_H_
#define __MYTYPE_H_

/// \def SINGLE determines whether single or double precision is built
#ifdef SINGLE
typedef float real_t;  //!< define native type for CoMD as single precision
  #define FMT1 "%g"    //!< /def format argument for floats 
  #define EMT1 "%e"    //!< /def format argument for eng floats
#else
typedef double real_t; //!< define native type for CoMD as double precision
  #define FMT1 "%lg"   //!< \def format argument for doubles 
  #define EMT1 "%le"   //!< \def format argument for eng doubles 
#endif

#include<Kokkos_Core.hpp>

//typedef real_t real3[3]; //!< a convenience vector with three real_t 

struct real3 {
  real_t x[3];

  real_t& operator[](std::size_t i) { return x[i]; }
  const real_t& operator[](std::size_t i) const { return x[i]; }
};

typedef Kokkos::Serial device_type;
//typedef Kokkos::OpenMP device_type;
typedef Kokkos::View<real_t*, device_type> real_t_view;
typedef Kokkos::View<real3*, device_type> real3_view;

#if 1
static void zeroReal3(real3 a)
#else
static void zeroReal3(real3_view a, int ii)
#endif
{
#if 1
   a[0] = 0.0;
   a[1] = 0.0;
   a[2] = 0.0;
#else
   a(ii, 0) = 0.0;
   a(ii, 1) = 0.0;
   a(ii, 2) = 0.0;
#endif
}

#define screenOut stdout

#endif
