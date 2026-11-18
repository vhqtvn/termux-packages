save_function termux_step_host_build termux_step_host_build_orig

termux_step_host_build() {
    export CFLAGS="${CFLAGS:+$CFLAGS }-std=gnu99"
    termux_step_host_build_orig "$@"
}