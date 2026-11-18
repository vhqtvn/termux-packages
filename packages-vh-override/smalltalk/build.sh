save_function termux_step_host_build termux_step_host_build_orig

termux_step_host_build() {
    export CFLAGS="${CFLAGS:+$CFLAGS }-std=gnu99 -Wno-error=incompatible-pointer-types"
    termux_step_host_build_orig "$@"
}