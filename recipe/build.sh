#!/bin/bash

# since we are doing cross compilation
# configure will fail
if [[ $OSTYPE == darwin* ]]; then
    export LDFLAGS="$LDFLAGS -Wl,-rpath,${CONDA_PREFIX}/lib"
fi

export FCFLAGS="$FFLAGS"

./configure --prefix=$PREFIX \
            --disable-dependency-tracking \
            --enable-cxx \
            --enable-f77 \
            --enable-fc #\
#            --with-cross=$RECIPE_DIR/cross.conf

make -j$CPU_COUNT
make install

if [[ $OSTYPE != darwin* ]]; then
    cp $RECIPE_DIR/../check-glibc.sh .
    bash check-glibc.sh $PREFIX/lib/ || exit 1
fi
