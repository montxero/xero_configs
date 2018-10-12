;;;; My .emacs file


;; Set load path
(let ((default-directory "~/.emacs.d"))
  (normal-top-level-add-subdirs-to-load-path))


;; External package sources.See https://www.emacswiki.org/emacs/InstallingPackages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))


;;; Commonlisp settings
(setq common-lisp-hyperspec-root (expand-file-name "~/.emacs.d/pkgs/commonlisp-hyperspec/HyperSpec/"))
;; SLIME settings
;; quick lisp for slime
;;(load (expand-file-name "~/quicklisp/slime-helper.el"))
;;replaced quicklisp slime with one straight from emacs repo

;; set prefered inferior lisp for slime
(setq inferior-lisp-program "sbcl")


(setq slime-contribs '(slime-fancy))


(defun slime-description-fontify ()
  "Fintify sections of SLIME Description"
  (with-current-buffer "*SLIME Description*"
    (highlight-regexp
     (concat "^Function:\\|"
             "^Macro-function:\\|"
             "^Its associated name.+?) is \\|"
             "^The .+'s arguments are:\\|"
             "^Function documentation:$\\|"
             "^Its.+\\(is\\|are\\):\\|"
             "^On.+ was compiled from:$")
     'hi-green-b)))


(defadvice slime-show-description (after slime-description-fontify activate)
  "Fontify sections of SLIME Description"
  (slime-description-fontify))



;; Modes to be started automatically based on File types
(add-to-list 'auto-mode-alist '("\\.lisp\\'" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.sage\\'" . python-mode))

;; use only spaces (no tab character)
(setq-default indent-tabs-mode nil)



;; extra settings for octave mode
(add-hook 'inferior-octave-mode-hook
          (lambda ()
            (turn-on-font-lock)
            (define-key inferior-octave-mode-map [up]
                        'comint-previous-input)
            (define-key inferior-octave-mode-map [down]
                        'comint-next-input)))


;; Paredit Settings
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook #'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))

;; Paredit + Eldoc
(require 'eldoc) ; if not already loaded
(eldoc-add-command
 'paredit-backward-delete
 'paredit-close-round)

;; Paredit + Slime
;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))

(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)
