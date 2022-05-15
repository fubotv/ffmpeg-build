#!/bin/bash -e

echo "OSTYPE: $OSTYPE"
if [[ "$OSTYPE" == "darwin"* ]]; then

    realpath() { # there's no realpath command on macosx 
        [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
    }
fi
CURRENT_DIR_PATH=$(dirname $(realpath $0))
PROJECT_ROOT_PATH=${CURRENT_DIR_PATH}/../../


source ${CURRENT_DIR_PATH}/options.sh

# enter build foler
cd ${PROJECT_ROOT_PATH}/srt
mkdir -p build
cd build

# build
cmake .. -DENABLE_DEBUG=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=${PROJECT_ROOT_PATH}/build -DENABLE_STDCXX_SYNC=ON -DENABLE_SHARED=OFF -DBUILD_SHARED_LIBS=OFF
make ${MAKE_PARALLEL} && make install

# go back
cd ${PROJECT_ROOT_PATH}

