TERMUX_PKG_SRCURL="https://downloadcontent2.opensuse.org/source/distribution/leap/15.6/repo/oss/src/xmppc-0.1.2-bp156.2.7.src.rpm"

# SHA256 of the outer source RPM, not the original tar.gz.
TERMUX_PKG_SHA256="f732243a20e0fed3e4c1a7705947bb8d0acb4a9d0a329d1efd89acbd7781ebc3"

termux_extract_src_archive() {
    local rpm="$TERMUX_PKG_CACHEDIR/$(basename "$TERMUX_PKG_SRCURL")"
    local archive="$TERMUX_PKG_TMPDIR/0.1.2.tar.gz"

    # Extract the source tarball from the source RPM.
    bsdtar -xOf "$rpm" 0.1.2.tar.gz > "$archive" ||
        termux_error_exit "Failed to extract xmppc source from RPM"

    echo "Embedded source SHA256: $(sha256sum "$archive")"

    mkdir -p "$TERMUX_PKG_SRCDIR"
    tar -xzf "$archive" \
        -C "$TERMUX_PKG_SRCDIR" \
        --strip-components=1
}