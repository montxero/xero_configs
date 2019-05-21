;;; package --- Xero's Emacs init file
;;; Commentary:
;;; init.el
;;; Code:

(org-babel-load-file "~/.emacs.d/emacsconfig.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (web-mode vimish-fold slime sicp sage-shell-mode reftex py-autopep8 paredit org ob-sagemath markdown-mode jedi geiser flycheck elpy auto-complete auctex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
