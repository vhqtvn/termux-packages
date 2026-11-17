
#!/usr/bin/env bash

case "$(uname -s)" in
    Darwin*) INPLACE_OPT=(-i ''); ;;
    *)       INPLACE_OPT=(-i''); ;;
esac

SCOPED_REPLACE=
if [[ -n "${REPLACE_ROOT_DIR:-}" ]]; then
	SCOPED_REPLACE=1
else
	REPLACE_ROOT_DIR="$(pwd)"
fi

# Run all relative operations from REPLACE_ROOT_DIR.
if ! cd -- "$REPLACE_ROOT_DIR"; then
    echo "Error: Cannot access directory: $REPLACE_ROOT_DIR" >&2
    exit 1
fi

do_replace() {
    local tmp_file
    tmp_file="$(mktemp "${TMPDIR:-/tmp}/mtime.XXXXXXXX")" || return 1

    find . \
        \( -path './debs' \
        -o -path './debs-bk' \
        -o -path './.git' \
        -o -path './.github' \
        -o -iname 'vh-tmp-*' \) -prune \
        -o -type f -print0 |
    while IFS= read -r -d '' f; do
        touch -r "$f" "$tmp_file" || continue

        LC_ALL=C sed "${INPLACE_OPT[@]}" -e "$1" "$f" 2>&1 || true

        touch -r "$tmp_file" "$f"
    done

    rm -f "$tmp_file"
}

if [[ "${1:-}" == "--reverse" ]] || [[ "${1:-}" == "-r" ]]; then
    echo "* Replace vsc->termux in $PWD"

	if [[ -n "$SCOPED_REPLACE" ]]; then
		rm -f "${HOME}/.termuxrc"

		if [[ -f repo.json.~ ]]; then
			cp repo.json.~ repo.json
		fi

		if [[ -f scripts/build/termux_step_setup_variables.sh ]]; then
			if [[ -f scripts/build/termux_step_setup_variables.sh.~ ]]; then
				cp scripts/build/termux_step_setup_variables.sh.~ \
				scripts/build/termux_step_setup_variables.sh
			fi
		fi

		for ff in \
			scripts/build/termux_download_deb_pac.sh \
			scripts/build/termux_get_repo_files.sh; do

			if [[ -f "$ff" && -f "$ff.~" ]]; then
				cp "$ff.~" "$ff"
			fi
		done
	fi

    do_replace 's#vn[.]vhn[.]vsc#com.t''ermux#g'
    do_replace 's#csv[.]nhv[.]nv#xumre''t.moc#g'

    # if [[ -f scripts/vh-patches.php ]]; then
    #     php scripts/vh-patches.php patch --reverse
    # fi
else
    TMPK="vn.vh""n.vsc"
    echo "* Replace termux->vsc in $PWD"

	if [[ -n "$SCOPED_REPLACE" ]]; then
	    cat <<OVERRIDE > "${HOME}/.termuxrc"
TERMUX_REPO_PACKAGE="$TMPK"

# Termux repo urls.
TERMUX_REPO_URL=(
    https://vsc.vhn.vn/termux-packages-24
)

TERMUX_REPO_DISTRIBUTION=(
    stable
)

TERMUX_REPO_COMPONENT=(
    main
)
OVERRIDE

		# if [[ -f scripts/vh-patches.php ]]; then
		#     php scripts/vh-patches.php patch
		# fi

		if [[ -f scripts/build/termux_step_setup_variables.sh ]]; then
			if [[ ! -f scripts/build/termux_step_setup_variables.sh.~ ]]; then
				cp scripts/build/termux_step_setup_variables.sh \
				scripts/build/termux_step_setup_variables.sh.~
			fi

			LC_ALL=C sed \
				-e "s#TERMUX_BUILD_TUPLE=#TERMUX_REPO_URL=(\nhttps://vsc.vhn.vn/termux-packages-24\n)\nTERMUX_REPO_DISTRIBUTION=(\nstable\n)\nTERMUX_REPO_COMPONENT=(\nmain\n)\nTERMUX_BUILD_TUPLE=#g" \
				< scripts/build/termux_step_setup_variables.sh.~ \
				> scripts/build/termux_step_setup_variables.sh
		fi

		for ff in \
			scripts/build/termux_download_deb_pac.sh \
			scripts/build/termux_get_repo_files.sh; do

			if [[ -f "$ff" ]]; then
				if [[ ! -f "$ff.~" ]]; then
					cp "$ff" "$ff.~"
				fi

				LC_ALL=C sed \
					-e "s#get_hash_from_file#vh_get_hash_single_from_file#g" \
					< "$ff.~" > "$ff"
			fi
		done

		if [[ -f repo.json ]] && [[ ! -f repo.json.~ ]]; then
			cp repo.json repo.json.~
			cat <<OVERRIDE > repo.json
{
  "pkg_format": "debian",
  "packages": {
    "name": "termux-main",
    "distribution": "stable",
    "component": "main",
    "url": "https://vsc.vhn.vn/termux-packages-24"
  }
}
OVERRIDE
		fi
	fi

    do_replace 's#com[.]termux#vn.vh''n.vsc#g'
    do_replace 's#xumret[.]moc#csv.nh''v.nv#g'
fi
