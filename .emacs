;;;; My .emacs file
;;;; Author Xero

;; quick lisp for slime
(load (expand-file-name "~/quicklisp/slime-helper.el"))

;; setup prefered inferior lisp for slime
(setq inferior-lisp-program "sbcl")

;; use only spaces (no tab character)
(setq-default indent-tabs-mode nil)

;; External package sources.See https://www.emacswiki.org/emacs/InstallingPackages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))


;; extra settings for octave mode
(add-hook 'inferior-octave-mode-hook
          (lambda ()
            (turn-on-font-lock)
            (define-key inferior-octave-mode-map [up]
                        'comint-previous-input)
            (define-key inferior-octave-mode-map [down]
                        'comint-next-input)))
