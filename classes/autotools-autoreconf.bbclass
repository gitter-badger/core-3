inherit autotools

EXTRA_AUTORECONF = ""
acpaths = "__default__"

pkgltdldir = "${STAGE_DIR}/cross${stage_datadir}/libtool"
pkgltdldir_recipe-native    = "${STAGE_DIR}/native${stage_datadir}/libtool"
pkgltdldir_recipe-cross     = "${STAGE_DIR}/native${stage_datadir}/libtool"
pkgltdldir_recipe-sdk-cross = "${STAGE_DIR}/native${stage_datadir}/libtool"

addtask autoreconf after do_patch before do_configure
do_autoreconf[dirs] = "${S}"

do_autoreconf () {

    for ac in `find ${S} -name configure.in -o -name configure.ac`; do
        rm -f `dirname $ac`/configure
    done

    if [ -e ${S}/configure.in -o -e ${S}/configure.ac ]; then
        if [ "${acpaths}" = "__default__" ]; then
            acpaths=
            for i in `find ${S} -maxdepth 2 -name \*.m4|grep -v 'aclocal.m4'| \
                grep -v 'acinclude.m4' | sed -e 's,\(.*/\).*$,\1,'|sort -u`
            do
                acpaths="$acpaths -I $i"
            done
        else
            acpaths="${acpaths}"
        fi

        install -d ${TARGET_SYSROOT}${datadir}/aclocal
        acpaths="$acpaths -I${TARGET_SYSROOT}${datadir}/aclocal"
        install -d ${STAGE_DIR}/cross${stage_datadir}/aclocal
        acpaths="$acpaths -I${STAGE_DIR}/cross${stage_datadir}/aclocal"
        oenote acpaths=$acpaths

        # autoreconf is too shy to overwrite aclocal.m4 if it doesn't look
        # like it was auto-generated.  Work around this by blowing it away
        # by hand, unless the package specifically asked not to run aclocal.
        if ! echo ${EXTRA_AUTORECONF} | grep -q "aclocal"; then
            rm -f aclocal.m4
        fi

        if [ -e configure.in ]; then
            CONFIGURE_AC=configure.in
        else
            CONFIGURE_AC=configure.ac
        fi

        if grep "^[[:space:]]*AM_GLIB_GNU_GETTEXT" $CONFIGURE_AC >/dev/null; then
            if grep "sed.*POTFILES" $CONFIGURE_AC >/dev/null; then
                : do nothing -- we still have an old unmodified configure.ac
            else
                oenote Executing glib-gettextize --force --copy
                echo "no" | glib-gettextize --force --copy
            fi
        elif grep "^[[:space:]]*AM_GNU_GETTEXT" $CONFIGURE_AC >/dev/null; then
            if [ -e ${TARGET_SYSROOT}${datadir}/gettext/config.rpath ]; then
                cp ${TARGET_SYSROOT}${datadir}/gettext/config.rpath ${S}/
            else
                oenote config.rpath not found. gettext is not installed.
            fi
        fi

        mkdir -p m4

        if [ -d "${pkgltdldir}" ] ; then
            export _lt_pkgdatadir="${pkgltdldir}"
        fi
        oenote Executing autoreconf
        autoreconf --verbose --install --force \
            ${EXTRA_AUTORECONF} $acpaths \
            || oefatal "autoreconf execution failed."
        if grep "^[[:space:]]*[AI][CT]_PROG_INTLTOOL" $CONFIGURE_AC >/dev/null; then
            oenote Executing intltoolize
            intltoolize --copy --force --automake
        fi
    fi
}
