TERMUX_PKG_HOMEPAGE=https://github.com/Bhupesh-V/ugit
TERMUX_PKG_DESCRIPTION="ugit helps you undo your last git command with grace. Your damage control git buddy"
TERMUX_PKG_LICENSE=MIT
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="5.9"
TERMUX_PKG_SRCURL=$TERMUX_PKG_HOMEPAGE/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=f93d9d4bb0d6fd676704e45733190413885c859ff2807b84cc8113bf674fc063
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_DEPENDS='bash, fzf, ncurses-utils'
TERMUX_PKG_PLATFORM_INDEPENDENT=true

termux_step_make_install() {
	local bin="$(basename $TERMUX_PKG_HOMEPAGE)"
	install -D "$bin" -t "$TERMUX_PREFIX/bin"
	ln -sf "$TERMUX_PREFIX/bin/$bin"  "$TERMUX_PREFIX/bin/gitundo"
}
