#!/bin/sh

LIBS=$1

sbcl --eval '(let ((lib-file (merge-pathnames "sources/xero_configs/cl-libs"
                                              (user-homedir-pathname))))
               (if (probe-file lib-file)
                   (with-open-file (in lib-file)
                     (do ((line (read-line in nil) (read-line in nil)))
                         ((null line) t)
                       (ql:quickload line)))
                   (format t "Library files not found.~%")))'\
    --quit
