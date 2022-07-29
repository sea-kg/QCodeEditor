#!/bin/bash

check_ret() {
    if [ $1 -ne 0 ]; then
        echo ""
        echo "!!! FAIL: $2"
        echo "********************************************************************************"
        echo ""
        exit $1
    else
        echo ""
        echo "*** SUCCESS: $2"
        echo "********************************************************************************"
        echo ""
    fi
}

BUILD_DIR="cmake-build-release"
if [ -d $BUILD_DIR ]; then
    rm -rf $BUILD_DIR
fi

echo "cmake configure"
cmake -H. -B./$BUILD_DIR \
    -DBUILD_EXAMPLE=On \
    -DCMAKE_VERBOSE_MAKEFILE=OFF \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DCMAKE_BUILD_TYPE=Release
check_ret $? "cmake configure"

cmake --build ./$BUILD_DIR --config Release
check_ret $? "cmake build"

cd ./$BUILD_DIR
check_ret $? "cd ./$BUILD_DIR"

echo "cmake install"
cmake --install . --config Release --prefix ../artifacts
check_ret $? "cmake install"
