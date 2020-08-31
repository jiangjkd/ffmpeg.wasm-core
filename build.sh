#!/bin/bash -x

# verify Emscripten version
emcc -v

# configure FFmpeg with Emscripten
FLAGS=(
  --disable-x86asm
  --enable-cross-compile  # enable cross compile
  --disable-inline-asm    # disable inline asm
  # --disable-hwaccels      # disable all hardware accelerations
  # --disable-doc           # disable document generation
  --nm="llvm-nm -g"
  --ar=emar
  --as=llvm-as
  --ranlib=llvm-ranlib
  --cc=emcc
  --cxx=em++
  --objcc=emcc
  --dep-cc=emcc
)
emconfigure ./configure "${FLAGS[@]}"

# build FFmpeg.wasm
emmake make -j
