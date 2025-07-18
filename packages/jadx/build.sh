TERMUX_PKG_HOMEPAGE=https://github.com/skylot/jadx
TERMUX_PKG_DESCRIPTION="Dex to Java decompiler"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_LICENSE_FILE="LICENSE, NOTICE"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.5.2"
TERMUX_PKG_SRCURL=https://github.com/skylot/jadx/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=2e6c6e9919c1dfd2c060ffb719ae8fe3aae8d1f1cc783798475d7e01d561b7d8
TERMUX_PKG_DEPENDS="openjdk-21"
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true

termux_step_make() {
	export JADX_VERSION="$TERMUX_PKG_VERSION"
	./gradlew clean dist

	sed -i "s#CLASSPATH=\$APP_HOME/lib/jadx-$TERMUX_PKG_VERSION-all.jar#CLASSPATH=$TERMUX_PREFIX/share/java/jadx-$TERMUX_PKG_VERSION-all.jar#g" "$TERMUX_PKG_SRCDIR"/build/jadx/bin/jadx
}

termux_step_make_install() {
	install -Dm755 -t $TERMUX_PREFIX/bin build/jadx/bin/jadx
	install -Dm755 -t $TERMUX_PREFIX/bin build/jadx/bin/jadx-gui

	rm -rf "$TERMUX_PREFIX/share/java/jadx-$TERMUX_PKG_VERSION-all.jar"
	mkdir -p $TERMUX_PREFIX/share/java/
	install -Dm700 -t $TERMUX_PREFIX/share/java build/jadx/lib/*
}
