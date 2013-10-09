#!/bin/bash

# Adapted from: http://www.animal-machine.com/blog/2010/04/a-haskell-adventure-in-windows/

# To run this, you must:
# 1. Exit Haskell, if it is running.
# 2. Running Git Bash as administrator. Start -> right click on Git Bash -> Run As Administrator.

# FIXME: Support for SDL-mixer, SDL-ttf.
# Something's wrong with those libraries on Windows.
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
INSTALL="`which ghc | sed -e s/ghc//`" # Where to install stuff
INCLUDE=$SDL/include
PATH=$PATH:$BIN # :$LIB

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

# Download, extract, and organize SDL binaries and bindings
if [[ ! -e $SDL/.git ]]; then
download_and_extract $SDL <<URL
http://www.libsdl.org/release/SDL-devel-1.2.15-mingw32.tar.gz
http://www.libsdl.org/projects/SDL_ttf/release/SDL_ttf-devel-2.0.11-VC.zip
http://www.libsdl.org/projects/SDL_image/release/SDL_image-devel-1.2.12-VC.zip
http://www.ferzkopp.net/Software/SDL_gfx-2.0/SDL_gfx-2.0.24.tar.gz
http://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-devel-1.2.12-VC.zip
URL

# Move disparate SDL bin/libs/includes to one folder
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

download_and_extract $SDL/haskell <<URL
http://hackage.haskell.org/package/SDL-0.6.5/SDL-0.6.5.tar.gz
http://hackage.haskell.org/package/SDL-ttf-0.6.2/SDL-ttf-0.6.2.tar.gz
http://hackage.haskell.org/package/SDL-image-0.6.1/SDL-image-0.6.1.tar.gz
http://hackage.haskell.org/package/SDL-mixer-0.6.1/SDL-mixer-0.6.1.tar.gz
http://hackage.haskell.org/package/SDL-gfx-0.6.0/SDL-gfx-0.6.0.tar.gz
URL

# rm -rf $SDL/SDL*

cd $SDL/haskell

# Got to patch add-on libraries for Windows
make_patch SDL-image-0.6.1 Image
make_patch SDL-mixer-0.6.1 Mixer
make_patch SDL-ttf-0.6.2 TTF

# Take a snapshot of the work we did for debugging.
cd ..
git init
git add bin haskell include lib 2> /dev/null
git commit -m "Checkpoint." > /dev/null
fi

# Install SDL
cp $LIB/* "$INSTALL"

# Install Haskell SDL binding
cd $SDL/haskell

for dir in SDL-*; do
	cd $dir
	runghc Setup.lhs configure --extra-include-dirs=$INCLUDE --extra-include-dirs=$INCLUDE/SDL --extra-lib-dirs="$INSTALL"
	runghc Setup.lhs build
	runghc Setup.lhs install
	cd ..
done

# Haskell SDL tutorial
cd
git clone https://github.com/snkkid/LazyFooHaskell.git
cd LazyFooHaskell
start .

cat <<INSTRUCTIONS

Now I am cloning a tutorial for using SDL with Haskell.
You can get to it by doing:

    cd ~/LazyFooHaskell

You can build each lesson by typing this (not literally):

    cd lessonXX
    ghc lessonXX.hs

And then type:

    lessonXX.exe
INSTRUCTIONS

