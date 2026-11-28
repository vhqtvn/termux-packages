TERMUX_PKG_HOMEPAGE=https://www.gnustep.org
TERMUX_PKG_DESCRIPTION="The GNUstep makefile package"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="2.9.4"
TERMUX_PKG_SRCURL=https://github.com/gnustep/tools-make/archive/refs/tags/make-${TERMUX_PKG_VERSION//./_}.tar.gz
TERMUX_PKG_SHA256=0c523b3c6e2db4520e35248efcd81b58097ac160099afade63189cb37f50ffac
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_VERSION_REGEXP='(?<=make-)\d+\_\d+\_\d+'
TERMUX_PKG_DEPENDS="libobjc2"

termux_step_pre_configure() {
	export OBJCXX="$CXX"
}
