save_function termux_step_pre_configure termux_step_pre_configure_orig

termux_step_pre_configure() {
    # GMime 3.2.15 rejects newer host Autotools versions.
    sed -i \
        -e 's/1\.4\*|1\.5\*|2\.2\*|2\.4\*)/1.4*|1.5*|2.2*|2.4*|2.5*)/' \
        -e 's/1\.15 1\.16; do/1.15 1.16 1.17 1.18; do/' \
        "$TERMUX_PKG_SRCDIR/autogen.sh"

    termux_step_pre_configure_orig "$@"
}