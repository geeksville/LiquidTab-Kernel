#/bin/bash +x
# temporary build script to save me some typing...I'll do a proper one later

cd "`dirname $0`"

export TOOLCHAIN=$HOME/CodeSourcery/arm-2009q3/bin
export TOOLCHAIN_PREFIX=arm-none-linux-gnueabi-
export LIQUIDTAB_DIR="`pwd`"

CC="$TOOLCHAIN/$TOOLCHAIN_PREFIX"
DEFCONFIG="p1_defconfig"
OUTNAME="p100kernel"

rm -f p100kernel.tar.md5 zImage recovery.bin

cd Kernel
make ARCH=arm CROSS_COMPILE=$CC mrproper
cd ..
