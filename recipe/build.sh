#!/bin/bash

# since we are doing cross compilation
# configure will fail

export CROSS_F77_SIZEOF_INTEGER=4

./configure --prefix=$PREFIX \
            --disable-dependency-tracking \
            --enable-cxx \
            --enable-fortran

make -j$CPU_COUNT
make install

if [[ $OSTYPE != darwin* ]]; then
    cp $RECIPE_DIR/../check-glibc.sh .
    bash check-glibc.sh $PREFIX/lib/ || exit 1
fi
