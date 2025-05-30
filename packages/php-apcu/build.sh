# Contributor: @ian4hu
TERMUX_PKG_HOMEPAGE=http://php.net/apcu
TERMUX_PKG_DESCRIPTION="APCu - APC User Cache"
TERMUX_PKG_LICENSE="PHP-3.01"
TERMUX_PKG_LICENSE_FILE=LICENSE
TERMUX_PKG_MAINTAINER="ian4hu <hu2008yinxiang@163.com>"
TERMUX_PKG_VERSION="5.1.24"
TERMUX_PKG_SRCURL="https://github.com/krakjoe/apcu/archive/refs/tags/v$TERMUX_PKG_VERSION.tar.gz"
TERMUX_PKG_DEPENDS="php"
TERMUX_PKG_SHA256=8b16f76dba51ec14263212ee1f618b06e132246a98ce3ed6961104585b773c94
TERMUX_PKG_AUTO_UPDATE=true

termux_step_pre_configure() {
	$TERMUX_PREFIX/bin/phpize
	LDFLAGS+=" -landroid-shmem"
}
