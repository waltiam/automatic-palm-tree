apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y cmake build-essential

git clone --recursive https://github.com/WebAssembly/wabt /tmp/wabt
cd /tmp/wabt
git submodule update --init

mkdir build
cd build
cmake ..
cmake --build .

mv /tmp/wabt/bin /usr/bin/wabt
cp /tmp/library-scripts/wabt-path.sh /etc/profile.d/
