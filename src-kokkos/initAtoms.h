/// \file
/// Initialize the atom configuration.

#ifndef __INIT_ATOMS_H
#define __INIT_ATOMS_H

#include <vector>
#include "mytype.h"

struct SimFlatSt;
struct LinkCellSt;

/// Atom data
typedef struct AtomsSt
{
   // atom-specific data
   int nLocal;    //!< total number of atoms on this processor
   int nGlobal;   //!< total number of atoms in simulation

   int* gid;      //!< A globally unique id for each atom
   int* iSpecies; //!< the species index of the atom

#if 1
   real3*  r;     //!< positions
//   std::vector<real3>  r;     //!< positions
   real3*  p;     //!< momenta of atoms
   real3*  f;     //!< forces 
   real_t* U;     //!< potential energy per atom
   
   real3_view  vr;     //!< positions
#else
   real3_view  p;     //!< momenta of atoms
   real3_view  f;     //!< forces 
   real_t_view U;     //!< potential energy per atom
#endif
} Atoms;


/// Allocates memory to store atom data.
Atoms* initAtoms(struct LinkCellSt* boxes);
void destroyAtoms(struct AtomsSt* atoms);

void createFccLattice(int nx, int ny, int nz, real_t lat, struct SimFlatSt* s);

void setVcm(struct SimFlatSt* s, real_t vcm[3]);
void setTemperature(struct SimFlatSt* s, real_t temperature);
void randomDisplacements(struct SimFlatSt* s, real_t delta);
#endif
