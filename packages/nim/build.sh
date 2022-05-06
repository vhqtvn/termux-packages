TERMUX_PKG_HOMEPAGE=https://nim-lang.org/
TERMUX_PKG_DESCRIPTION="Nim programming language compiler"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_LICENSE_FILE="copying.txt"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.6.6
TERMUX_PKG_SRCURL=https://nim-lang.org/download/nim-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=67b111ce6f3861503b9fcc1cae59fc34d0122566d3ecfef3a064a2174121a452
TERMUX_PKG_DEPENDS="clang, git, libandroid-glob, openssl-1.1"
TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_BUILD_IN_SRC=true

_NIM_TOOLS="
koch
dist/nimble/src/nimble
nimpretty/nimpretty
nimsuggest/nimsuggest
testament/testament
tools/nimgrep
"

termux_step_host_build() {
	cp -r ../src/* ./
	make -j $TERMUX_MAKE_PROCESSES CC=gcc LD=gcc
}

termux_step_make() {
	if [ $TERMUX_ARCH = "x86_64" ]; then
		export	NIM_ARCH=amd64
	elif [ $TERMUX_ARCH = "i686" ]; then
		export	NIM_ARCH=i386
	elif [ $TERMUX_ARCH = "aarch64" ]; then
		export NIM_ARCH=arm64
	else
		export NIM_ARCH=arm
	fi
	LDFLAGS+=" -landroid-glob"
	sed -i "s%\@CC\@%${CC}%g"  config/nim.cfg
	sed -i "s%\@CFLAGS\@%${CFLAGS}%g" config/nim.cfg
	sed -i "s%\@LDFLAGS\@%${LDFLAGS}%g" config/nim.cfg
	sed -i "s%\@CPPFLAGS\@%${CPPFLAGS}%g" config/nim.cfg

	find -name "stdlib_osproc.nim.c" | xargs -n 1 sed -i 's',"/system/bin/sh\"\,\ 14","${TERMUX_PREFIX}/bin/sh\"\,\ 38",'g'
	PATH=$TERMUX_PKG_HOSTBUILD_DIR/bin:$PATH

	if [ $NIM_ARCH = "amd64" ]; then
		sed -i 's/arm64/amd64/g' makefile
	fi
	export CFLAGS=" $CPPFLAGS $CFLAGS  -w  -fno-strict-aliasing"
	make LD=$CC uos=linux mycpu=$NIM_ARCH myos=android  -j $TERMUX_MAKE_PROCESSES useShPath=$TERMUX_PREFIX/bin/sh
	cp config/nim.cfg ../host-build/config

	for cmd in $_NIM_TOOLS; do
		pushd $(dirname $cmd)
		case $cmd in
			koch) nim_flags="--opt:size" ;;
			*) nim_flags= ;;
		esac
		nim --cc:clang --clang.exe=$CC --clang.linkerexe=$CC $nim_flags --define:termux -d:release -d:sslVersion=1.1 --os:android --cpu:$NIM_ARCH  -t:"$CPPFLAGS $CFLAGS" -l:"$LDFLAGS -landroid-glob" -d:tempDir:$TERMUX_PREFIX/tmp c $(basename $cmd).nim
		popd
	done
}

termux_step_make_install() {
	./install.sh $TERMUX_PREFIX/lib
	ln -sfr $TERMUX_PREFIX/lib/nim/bin/nim $TERMUX_PREFIX/bin/
	for cmd in $_NIM_TOOLS; do
		cp $cmd $TERMUX_PREFIX/lib/nim/bin/
		ln -sfr $TERMUX_PREFIX/lib/nim/bin/$(basename $cmd) $TERMUX_PREFIX/bin/
	done
	mkdir -p $TERMUX_PREFIX/lib/nim/tools
	cp -r tools/dochack $TERMUX_PREFIX/lib/nim/tools/
}
