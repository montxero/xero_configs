#!/bin/sh

sbcl --eval '(ql:update-client)'\
     --eval '(ql:update-dist "quicklisp")'\
     --eval '(ql:update-dist "http://dist.tymoon.eu/shirakumo.txt")'\
     --quit
