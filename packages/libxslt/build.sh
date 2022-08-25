TERMUX_PKG_HOMEPAGE=http://xmlsoft.org/libxslt/
TERMUX_PKG_DESCRIPTION="XSLT processing library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
_MAJOR_VERSION=1.1
TERMUX_PKG_VERSION=${_MAJOR_VERSION}.36
TERMUX_PKG_SRCURL=https://download.gnome.org/sources/libxslt/${_MAJOR_VERSION}/libxslt-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=12848f0a4408f65b530d3962cd9ff670b6ae796191cfeff37522b5772de8dc8e
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--without-python"
TERMUX_PKG_DEPENDS="libxml2, libgcrypt, libgpg-error, zlib"
TERMUX_PKG_BREAKS="libxslt-dev"
TERMUX_PKG_REPLACES="libxslt-dev"
