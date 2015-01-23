CMAKE_BUILD_TYPE=$1
if [ "-$CMAKE_BUILD_TYPE" = "-" ]; then
    CMAKE_BUILD_TYPE=Release
fi
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR_TO=$DIR/build_android
rm -rf $DIR_TO

function build()
{
    ABI=$1
    DIR_ABI=$DIR_TO/$ABI
    mkdir -p $DIR_ABI
    cd $DIR_ABI && cd $_
    cmake -DCMAKE_TOOLCHAIN_FILE=../../android.toolchain.cmake -DANDROID_ABI=$ABI -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE ../..
    make -j8
}

build armeabi
build armeabi-v7a
build x86
