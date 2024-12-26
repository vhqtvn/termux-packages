TERMUX_PKG_HOMEPAGE=https://docs.xfce.org/apps/ristretto/start
TERMUX_PKG_DESCRIPTION="The Ristretto Image Viewer is an application that can be used to view, and scroll through images."
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="0.13.3"
TERMUX_PKG_SRCURL=https://archive.xfce.org/src/apps/ristretto/${TERMUX_PKG_VERSION%.*}/ristretto-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=5b9172ef704ae192a5338df6bee4e91a59edc65618c375bb4433ffb38e2126cb
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="file, gdk-pixbuf, glib, gtk3, libcairo, libexif, libx11, libxfce4ui, libxfce4util, pango, xfconf"
TERMUX_PKG_RECOMMENDS="tumbler"
