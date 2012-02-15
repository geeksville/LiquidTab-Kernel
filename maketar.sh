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

# Temp work-around: .git folder causes kernel not to boot...we will revisit this soon
mv .git RENAME_ME.git

cd Kernel
make -j4 ARCH=arm CROSS_COMPILE=$CC mrproper
make -j4 ARCH=arm CROSS_COMPILE=$CC $DEFCONFIG
make -j4 ARCH=arm CROSS_COMPILE=$CC
cd ..

# Temp work-around: .git folder causes kernel not to boot...we will revisit this soon
mv RENAME_ME.git .git

# Make Odin flashable .tar.md5 for now
cp Kernel/arch/arm/boot/zImage zImage
cp Kernel/arch/arm/boot/zImage recovery.bin
tar -H ustar -c zImage recovery.bin > $OUTNAME.tar
md5sum -t $OUTNAME.tar >> $OUTNAME.tar
mv $OUTNAME.tar $OUTNAME.tar.md5
