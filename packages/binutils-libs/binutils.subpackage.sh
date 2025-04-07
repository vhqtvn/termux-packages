TERMUX_SUBPKG_INCLUDE="
bin/$TERMUX_HOST_PLATFORM-*
bin/addr2line
bin/ar
bin/c++filt
bin/dwp
bin/ld
bin/nm
bin/objcopy
bin/objdump
bin/ranlib
bin/readelf
bin/size
bin/strings
bin/strip
share/binutils/
"
TERMUX_SUBPKG_DESCRIPTION="GNU Binutils (metapackage)"
# TERMUX_SUBPKG_DEPEND_ON_PARENT=false # TODO: subpkg of specific needed?
TERMUX_SUBPKG_DEPENDS="binutils-bin"
TERMUX_SUBPKG_CONFLICTS="binutils-is-llvm"
