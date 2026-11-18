save_function termux_step_pre_configure termux_step_pre_configure_orig

termux_step_pre_configure() {
    termux_step_pre_configure_orig "$@"

    # Host flex 2.6.4 generates code incompatible with FlexLexer.h 2.6.16.
    # Yosys bundles the matching FlexLexer.h from flex 2.6.4.
    CXXFLAGS+=" -I$TERMUX_PKG_SRCDIR/libs/flex"
}