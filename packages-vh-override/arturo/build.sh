save_function termux_step_pre_configure termux_step_pre_configure_orig

termux_step_pre_configure() {
    termux_step_pre_configure_orig "$@"
    sed -i \
        's/^proc GC_setStrategy(strategy: GC_Strategy) = discard$/when declared(GC_Strategy):\n  proc GC_setStrategy(strategy: GC_Strategy) = discard/' \
        "$TERMUX_PKG_SRCDIR/src/extras/mimalloc.nim"
}