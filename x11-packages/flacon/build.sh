TERMUX_PKG_HOMEPAGE=https://flacon.github.io/
TERMUX_PKG_DESCRIPTION="Extracts individual tracks from one big audio file and saves them as separate audio files"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=9.4.0
TERMUX_PKG_SRCURL=https://github.com/flacon/flacon/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=c26830e866023086d022f1a5ba01c13336693b0799ba1ed313359e553a99456a
TERMUX_PKG_DEPENDS="libc++, libuchardet, qt5-qtbase, taglib"
TERMUX_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
