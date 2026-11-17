save_function termux_step_make termux_step_make_bk
termux_step_make() {
    sed -i'' 's/-lpthread//g' "$TERMUX_PKG_BUILDDIR/build.ninja"
	termux_step_make_bk
}
