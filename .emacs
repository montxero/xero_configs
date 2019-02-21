;;;; My .emacs file

;;; General Editor Settings
;; Set load path
(let ((default-directory "~/.emacs.d"))
  (normal-top-level-add-subdirs-to-load-path))

;; External package sources.See https://www.emacswiki.org/emacs/InstallingPackages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)

;; use only spaces (no tab character)
(setq-default indent-tabs-mode nil)

;; white-space settings
(setq whitespace-line-column 79) ;; limit line length
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)

(defun set-white-space-line-length (n)
  "Toggle line length, then set white-space-line-column to `n`.  My first elisp function!!!"
  (global-whitespace-mode -1)
  (setq whitespace-line-column n)
  (global-whitespace-mode 1))

(add-hook 'lisp-mode-hook (set-white-space-line-length 119))
(add-hook 'org-mode-hook (set-white-space-line-length 79))

;; Modes to be started automatically based on File types
(add-to-list 'auto-mode-alist '("\\.lisp\\'" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))
;(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;(add-to-list 'auto-mode-alist '("\\.sage\\'" . python-mode))


;;; Octave Settings
;; extra settings for octave mode
(add-hook 'inferior-octave-mode-hook
          (lambda ()
            (turn-on-font-lock)
            (define-key inferior-octave-mode-map [up]
                        'comint-previous-input)
            (define-key inferior-octave-mode-map [down]
                        'comint-next-input)))


;;; Sagemath settings
(require 'sage-shell-mode)
(setq sage-shell:sage-executable "/usr/local/bin/sage")
;; Run SageMath by M-x run-sage instead of M-x sage-shell:run-sage
(sage-shell:define-alias)

;; Turn on eldoc-mode in Sage terminal and in Sage source files
(add-hook 'sage-shell-mode-hook #'eldoc-mode)
(add-hook 'sage-shell:sage-mode-hook #'eldoc-mode)


;;; Org Mode Settings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switch)

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
  "Fontify sections of SLIME Description"
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


;; Paredit Settings
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook #'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'geiser-mode-hook #'enable-paredit-mode)

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (jedi vimish-fold ob-sagemath htmlize auto-complete flycheck markdown-mode proof-general elpy py-autopep8 auctex geiser paredit slime sicp sage-shell-mode org))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; AUCTex settings
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq reftex-plug-into-AUCTeX t)


;;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;;; Python
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i"
      python-shell-prompt-detect-faliure-warning nil)


;;; Jedi settings
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

;;; Org mode
(setq org-adapt-indentation nil)
(setq org-list-description-max-indent 5)
(setq org-src-fontify-natively t)
(org-babel-do-load-languages
 'org-babel-load-languages '((shell . t)
                             (python . t)
                             (lisp . t)
                             (scheme . t)
                             (octave . t)))

(provide '.emacs)
;;; .emacs ends here
