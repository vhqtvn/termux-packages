# Avoid the obsolete aeson-0.8.0.2 selected by Cabal with GHC 9.12.
save_function termux_step_post_configure termux_step_post_configure_orig

termux_step_post_configure() {
    termux_step_post_configure_orig "$@"
    echo 'constraints: aeson >= 2.0' >> cabal.project.local
}