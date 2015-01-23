CMAKE_BUILD_TYPE=$1
if [ "-$CMAKE_BUILD_TYPE" = "-" ]; then
    CMAKE_BUILD_TYPE=Release
fi
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

DIR_ALL=$DIR/build_all
rm -rf $DIR_ALL
mkdir -p $DIR_ALL

DIR_INCLUDE=$DIR_ALL/include
DIR_PREBUILT=$DIR_ALL/prebuilt

LIB_NAME=libzip.a

function build()
{
    PLATFORM=$1
    ./build_${PLATFORM}.sh $CMAKE_BUILD_TYPE
    DIR_TO=$DIR_PREBUILT/$PLATFORM
    mkdir -p $DIR_TO
    cp $DIR/build_$PLATFORM/$LIB_NAME $DIR_TO/
}

build mac
build ios

./build_android.sh $CMAKE_BUILD_TYPE
DIR_TO_ANDROID=$DIR_PREBUILT/android
function build_android()
{
    ABI=$1
    DIR_TO=$DIR_TO_ANDROID/$ABI
    mkdir -p $DIR_TO
    cp $DIR/build_android/$ABI/$LIB_NAME $DIR_TO/
}

build_android armeabi
build_android armeabi-v7a
build_android x86

cp $DIR/Android.mk $DIR_TO_ANDROID/

function copy_include()
{
    PLATFORM=$1
    mkdir -p $DIR_INCLUDE/$PLATFORM
    find ../lib/ -name '*.h' -maxdepth 1 -exec cp {} $DIR_INCLUDE/$PLATFORM/ \;
    if [ "$PLATFORM" = "win32" ]; then
        find ../win32/ -name '*.h' -maxdepth 1 -exec cp {} $DIR_INCLUDE/$PLATFORM/ \;
    else
        find ../xcode/ -name '*.h' -maxdepth 1 -exec cp {} $DIR_INCLUDE/$PLATFORM/ \;
    fi
}

cd $DIR
copy_include mac
copy_include ios
copy_include android
copy_include win32

rm -rf $DIR/build_mac
rm -rf $DIR/build_ios
rm -rf $DIR/build_android
