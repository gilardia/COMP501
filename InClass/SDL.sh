#!/bin/bash

# Adapted from: http://www.animal-machine.com/blog/2010/04/a-haskell-adventure-in-windows/

# To run this, you must run Git Bash as administrator.
# In the start menu, right click on Git Bash -> Run As Administrator.

# FIXME: Support SDL-gfx (currently downloads it, but nothing else)

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

# Get SDL binaries for your system. Store in C:\SDL
download_and_extract /c/SDL <<URL
http://www.libsdl.org/release/SDL-devel-1.2.15-mingw32.tar.gz
http://www.libsdl.org/projects/SDL_ttf/release/SDL_ttf-devel-2.0.11-VC.zip
http://www.libsdl.org/projects/SDL_image/release/SDL_image-devel-1.2.12-VC.zip
http://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-devel-1.2.12-VC.zip
http://www.ferzkopp.net/Software/SDL_gfx-2.0/SDL_gfx-2.0.24.tar.gz
URL

# Get Haskell SDL bindings. Store temporarily in current directory.
download_and_extract . <<URL
http://hackage.haskell.org/package/SDL-0.6.5/SDL-0.6.5.tar.gz
http://hackage.haskell.org/package/SDL-ttf-0.6.2/SDL-ttf-0.6.2.tar.gz
http://hackage.haskell.org/package/SDL-image-0.6.1/SDL-image-0.6.1.tar.gz
http://hackage.haskell.org/package/SDL-mixer-0.6.1/SDL-mixer-0.6.1.tar.gz
http://hackage.haskell.org/package/SDL-gfx-0.6.0/SDL-gfx-0.6.0.tar.gz
URL

# Install Haskell SDL binding
PATH=$PATH:/c/SDL/SDL-1.2.15/bin
cd SDL-0.6.5
runghc Setup.lhs configure \
--extra-include-dirs=/c/SDL/SDL-1.2.15/include/SDL \
--extra-lib-dirs=/c/SDL/SDL-1.2.15/lib
runghc Setup.lhs build
runghc Setup.lhs install

# Install Haskell SDL-image binding
cd ..
cd SDL-image-0.6.1
patch -p1 <<PATCH
--- a/Graphics/UI/SDL/Image/Version.hsc
+++ b/Graphics/UI/SDL/Image/Version.hsc
@@ -1,4 +1,8 @@
 #include "SDL_image.h"
+#include "SDL.h"
+#ifdef main
+#undef main
+#endif
 module Graphics.UI.SDL.Image.Version
     ( compiledFor
     , linkedWith

PATCH
runghc Setup.lhs configure \
--extra-include-dirs=/c/SDL/SDL_image-1.2.12/include
runghc Setup.lhs build
runghc Setup.lhs install

cd ..
cd SDL-mixer-0.6.1
patch -p1 <<PATCH
--- a/Graphics/UI/SDL/Mixer/Version.hsc
+++ b/Graphics/UI/SDL/Mixer/Version.hsc
@@ -1,4 +1,8 @@
 #include "SDL_mixer.h"
+#include "SDL.h"
+#ifdef main
+#undef main
+#endif
 module Graphics.UI.SDL.Mixer.Version
     ( compiledFor
     , linkedWith

PATCH
runghc Setup.lhs configure \
--extra-include-dirs=/c/SDL/SDL_mixer-1.2.12/include
runghc Setup.lhs build
runghc Setup.lhs install


cd ..
cd SDL-ttf-0.6.2
patch -p1 <<PATCH
--- a/Graphics/UI/SDL/TTF/Version.hsc
+++ b/Graphics/UI/SDL/TTF/Version.hsc
@@ -1,4 +1,8 @@
 #include "SDL_ttf.h"
+#include "SDL.h"
+#ifdef main
+#undef main
+#endif
 module Graphics.UI.SDL.TTF.Version
     ( compiledFor
     , linkedWith

PATCH
runghc Setup.lhs configure \
--extra-include-dirs=/c/SDL/SDL_ttf-2.0.11/include
runghc Setup.lhs build
runghc Setup.lhs install

if [[ $PROCESSOR_ARCHITECTURE == "x86" ]]; then
CPU="x86"
else
CPU="x64"
fi

cp /c/SDL/SDL_image-1.2.12/lib/$CPU/*.dll /c/SDL/SDL-1.2.15/bin
cp /c/SDL/SDL_mixer-1.2.12/lib/$CPU/*.dll /c/SDL/SDL-1.2.15/bin
cp /c/SDL/SDL_ttf-2.0.11/lib/$CPU/*.dll /c/SDL/SDL-1.2.15/bin

cd ..
rm -rf SDL-* # Clean up Haskell bindings

printf ";C:\\SDL\\SDL-1.2.15\\\bin" > /dev/clipboard
echo 
echo
echo "Haskell SDL installation ALMOST COMPLETE."
echo "You need to add C:\\SDL\\SDL-1.2.15\\bin to the System Path"
echo
echo "I have already copied that path to the clipboard."
echo
echo "Step-by-step:"
echo "1. Go to Start -> Computer -> System properties -> Advanced system settings -> Environment variables..."
echo "2. Under system variables, select Path and click Edit..."
echo "3. Press the right arrow key to make sure nothing is selected."
echo "4. Press Ctrl-V. If you are certain that you added to the path, click OK."
echo "5. Come back here and press enter. More instructions await"
read

echo "I am cloning a tutorial for using SDL with Haskell."
echo "You can get to it by doing:"
echo
echo "    cd ~/LazyFooHaskell"
echo
echo "You can build each lesson by doing:"
echo
echo "    cd lessonXX"
echo "    ghc lessonXX.hs"
echo
echo "And then type:"
echo
echo "    lessonXX.exe"

cd
git clone https://github.com/snkkid/LazyFooHaskell.git
cd LazyFooHaskell
start .
