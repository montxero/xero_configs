#!/bin/sh


TEMP_DIR=$(mktemp -d)
cd "${TEMP_DIR}" || exit
curl --remote-name https://beta.quicklisp.org/quicklisp.lisp
sbcl --load quicklisp.lisp\
     --eval '(quicklisp-quickstart:install)'\
     --eval '(ql-dist:install-dist "http://dist.tymoon.eu/shirakumo.txt")'\
     --quit
rm -rf "${TEMP_DIR}"
