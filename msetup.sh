#! /bin/sh

d="$(dirname "$0")"

target=i686-pc-os2-emx

export LDFLAGS=-Zhigh-mem

opts="
    --prefix=/@unixroot/usr/local
    --default-library=static
    -Dwith-system-includedir=\"/@unixroot/usr/include;/usr/include\"
    -Dwith-system-libdir=\"/@unixroot/usr/lib;/usr/lib\"
"

if [ -n "$1" ] && [ "${1#-}" = "$1" ]; then
    # $1 is a build dir
    [ -f "$1/meson.build" ] \
        && { echo "BUILD dir should be different from SOURCE dir!!!"; exit 1; }

    blddir="$1"
    shift
else
    # $1 is empty or an option. Determine the build dir with meson.build
    [ -f meson.build ] && blddir=build || blddir=.
fi

srcdir="$d"

[ -z "$OS2_SHELL" ] && opts="$opts \"--cross-file=$d/$target.txt\""
[ -f "$blddir/build.ninja" ] && opts="$opts --reconfigure"

eval 'meson setup "$blddir" "$srcdir"' $opts '"$@"'
