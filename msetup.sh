#! /bin/sh

target=i686-pc-os2-emx

d="$(dirname "$0")"

opts="
  --prefix=/@unixroot/usr/local
  -Dwith-system-includedir=\"/@unixroot/usr/include;/usr/include\"
  -Dwith-system-libdir=\"/@unixroot/usr/lib;/usr/lib\"
  --default-library=static
  --cross-file=$d/$target.txt
"

if [ -f meson.build ]; then
  blddir=build
else
  blddir=.
fi

[ -f "$blddir/build.ninja" ] && reconf=--reconfigure

eval 'meson setup "$blddir" "$d"' $opts '$reconf "$@"'
