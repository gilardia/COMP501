#!/bin/bash

# Adapted from: http://www.animal-machine.com/blog/2010/04/a-haskell-adventure-in-windows/

# To run this, you must run Git Bash as administrator.
# In the start menu, right click on Git Bash -> Run As Administrator.

# FIXME: Support SDL-gfx (currently downloads it, but nothing else)

# Determine CPU
if [[ $PROCESSOR_ARCHITECTURE == "x86" ]]; then
CPU="x86"
else
CPU="x64"
fi

# SDL folders
SDL=/c/SDL
BIN=$SDL/bin
LIB=$SDL/lib
INCLUDE=$SDL/include
PATH=$PATH:$BIN:$LIB

# This function reads URLs from standard in, then downloads and extracts them.
# It accepts a parameter to specify the directory to extract to.
function download_and_extract {
	mkdir -p $1
	while read -r url; do
		if [[ $url == *tar.gz ]]; then
			curl $url | gunzip | tar -x -C $1
		elif [[ $url == *zip ]]; then
			curl $url > ${url##*/}
			unzip -o ${url##*/} -d $1
			rm ${url##*/}
		fi
	done
}

# This function makes patches to Haskell SDL bindings.
function make_patch {
cd $1
lower=`printf $2 | tr [:upper:] [:lower:]`
patch -p1 <<PATCH
--- a/Graphics/UI/SDL/$2/Version.hsc
+++ b/Graphics/UI/SDL/$2/Version.hsc
@@ -1,4 +1,8 @@
 #include "SDL_$lower.h"
+#include "SDL.h"
+#ifdef main
+#undef main
+#endif
 module Graphics.UI.SDL.$2.Version
     ( compiledFor
     , linkedWith

PATCH
cd ..
}

# Get SDL binaries for your system. Store in SDL folder
if [[ ! -e $SDL ]]; then
download_and_extract $SDL <<URL
http://www.libsdl.org/release/SDL-devel-1.2.15-mingw32.tar.gz
http://www.libsdl.org/projects/SDL_ttf/release/SDL_ttf-devel-2.0.11-VC.zip
http://www.libsdl.org/projects/SDL_image/release/SDL_image-devel-1.2.12-VC.zip
http://www.ferzkopp.net/Software/SDL_gfx-2.0/SDL_gfx-2.0.24.tar.gz
http://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-devel-1.2.12-VC.zip
URL

# Move disparate SDL libs/includes to one folder
mkdir -p $LIB
mkdir -p $INCLUDE
mkdir -p $BIN

# Copy main SDL to standard location
cp $SDL/SDL-1.2.15/bin/sdl-config $BIN
cp $SDL/SDL-1.2.15/bin/SDL.dll $LIB
cp $SDL/SDL-1.2.15/lib/* $LIB
cp --recursive $SDL/SDL-1.2.15/include/* $INCLUDE

# Copy add-on libraries to standard location
for dir in $SDL/SDL_* ; do
	cp --recursive $dir/include/* $INCLUDE 2> /dev/null
	cp --recursive $dir/lib/$CPU/* $LIB 2> /dev/null
done

rm -rf $SDL/SDL*
fi


# Get Haskell SDL bindings. Store temporarily in current directory.
download_and_extract . <<URL
http://hackage.haskell.org/package/SDL-0.6.5/SDL-0.6.5.tar.gz
http://hackage.haskell.org/package/SDL-ttf-0.6.2/SDL-ttf-0.6.2.tar.gz
http://hackage.haskell.org/package/SDL-image-0.6.1/SDL-image-0.6.1.tar.gz
http://hackage.haskell.org/package/SDL-mixer-0.6.1/SDL-mixer-0.6.1.tar.gz
http://hackage.haskell.org/package/SDL-gfx-0.6.0/SDL-gfx-0.6.0.tar.gz
URL

# Got to patch add-on libraries for Windows
make_patch SDL-image-0.6.1 Image
make_patch SDL-mixer-0.6.1 Mixer
make_patch SDL-ttf-0.6.2 TTF

# Install Haskell SDL binding
for dir in SDL-*; do
	cd $dir
	runghc Setup.lhs configure --extra-include-dirs=$INCLUDE --extra-include-dirs=$INCLUDE/SDL --extra-lib-dirs=$LIB
	runghc Setup.lhs build
	runghc Setup.lhs install
	cd ..
done

exit

cd ..
rm -rf SDL-* # Clean up Haskell bindings

printf ";C:\\SDL\\lib" > /dev/clipboard

cat <<INSTRUCTIONS


The Haskell SDL installation is ALMOST complete.
You need to add C:\SDL\lib to the System Path.

Lucky you, I have already copied that path to the clipboard.

Here's what you need to do, step-by-step:

1. Go to Start -> Computer -> System properties -> Advanced system settings
2. Select Environment variables...
3. Under system variables, select Path and click Edit...
4. Press the right arrow key to make sure nothing is selected.
5. Press Ctrl-V. If you are certain that you added to the path, click OK.
6. Come back here and press enter. More instructions await.
INSTRUCTIONS

echo "You did add C:\\SDL\\lib to the System path, right?"
read

cat <<INSTRUCTIONS
Okay, I was just checking.

All right, now I am cloning a tutorial for using SDL with Haskell.
You can get to it by doing:

    cd ~/LazyFooHaskell

You can build each lesson by doing:

    cd lessonXX
    ghc lessonXX.hs

And then type:

    lessonXX.exe
INSTRUCTIONS

cd
git clone https://github.com/snkkid/LazyFooHaskell.git
cd LazyFooHaskell
start .
