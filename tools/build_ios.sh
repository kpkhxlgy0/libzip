defaults write com.apple.Xcode PBXNumberOfParallelBuildSubtasks 8
CMAKE_BUILD_TYPE=$1
if [ "-$CMAKE_BUILD_TYPE" = "-" ]; then
    CMAKE_BUILD_TYPE=Release
fi
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DIR_TO=$DIR/build_ios
rm -rf $DIR_TO
mkdir -p $DIR_TO

LIB_NAME=zip

function build()
{
    PLATFORM=$1
    DIR_PLATFORM_TO=$DIR_TO/$PLATFORM
    mkdir -p $DIR_PLATFORM_TO
    cd $DIR_PLATFORM_TO && cd $_
    cmake -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake -DIOS_PLATFORM=$PLATFORM -GXcode -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE ../..
    xcodebuild -target $LIB_NAME -configuration $CMAKE_BUILD_TYPE
}

build SIMULATOR
build OS

DIR_SIM_TO=$DIR_TO/SIMULATOR
DIR_OS_TO=$DIR_TO/OS

cd $DIR_TO && cd $_
lipo -create $DIR_SIM_TO/${CMAKE_BUILD_TYPE}-iphonesimulator/lib${LIB_NAME}.a $DIR_OS_TO/${CMAKE_BUILD_TYPE}-iphoneos/lib${LIB_NAME}.a -output ./lib${LIB_NAME}.a
