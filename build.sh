## STANDALONE BUILD

KERNEL_DIR=""
CROSS_COMPILE_TOOLCHAIN="mipsel-linux-"

if [[ "$KERNEL_DIR" == "" ]]; then
	echo "Please edit this file and specify your kernel sources directory and toolchain"
	exit 1
fi

/usr/bin/make -j$(nproc) \
-C $KERNEL_DIR \
ARCH=mips \
CROSS_COMPILE=$CROSS_COMPILE_TOOLCHAIN \
KSRC=$KERNEL_DIR \
PWD=$(pwd) \
M=$(pwd)/. modules
