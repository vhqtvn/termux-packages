TERMUX_PKG_HOMEPAGE=https://fly.io
TERMUX_PKG_DESCRIPTION="Command line tools for fly.io services"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@termux.dev>"
TERMUX_PKG_VERSION="0.3.104"
TERMUX_PKG_SRCURL=https://github.com/superfly/flyctl/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=2e7444dc4dddae10d3c21d858df19985fd191874b4967785ee9c582e00d10419
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXCLUDED_ARCHES="i686, arm"

termux_step_post_get_source() {
	termux_setup_golang
	go mod tidy
	go mod vendor
}

termux_step_make() {
	go build -o bin/flyctl
}

termux_step_make_install() {
	install -Dm700 -t "$TERMUX_PREFIX"/bin "$TERMUX_PKG_SRCDIR/bin/flyctl"
}
