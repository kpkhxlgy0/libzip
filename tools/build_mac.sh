CMAKE_BUILD_TYPE=$1
if [ "-$CMAKE_BUILD_TYPE" = "-" ]; then
    CMAKE_BUILD_TYPE=Release
fi
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR_TO=$DIR/build_mac
rm -rf $DIR_TO
mkdir -p $DIR_TO
cd $DIR_TO && cd $_
cmake -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE ..
make -j8
