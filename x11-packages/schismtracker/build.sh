TERMUX_PKG_HOMEPAGE=https://schismtracker.org/
TERMUX_PKG_DESCRIPTION="A free and open-source reimplementation of Impulse Tracker, a program used to create high quality music"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="20250728"
TERMUX_PKG_SRCURL=https://github.com/schismtracker/schismtracker/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=adbf92c2690e59e177868d88a823802891d47fffab496a0a726864a0363d2bb1
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libflac, libx11, libxv, sdl2 | sdl2-compat, utf8proc"
TERMUX_PKG_BUILD_DEPENDS="xorgproto"
TERMUX_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_prog_WINDRES=
ac_cv_prog_ac_ct_WINDRES=
"

termux_step_pre_configure() {
	autoreconf -fi -I$TERMUX_PREFIX/share/aclocal
}

termux_step_post_configure() {
	mkdir -p auto
}
