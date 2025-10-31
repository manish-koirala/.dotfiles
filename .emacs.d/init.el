;; Emacs Startup Configuration File
;; Author: Manish Koirala
;; Date: October 30

;; Sane Defaults
(setq inhibit-startup-message t) ; Disable the tutorial screen during startup
(setq make-backup-files nil) ; Disable creating backup files with # extension
(setq auto-save-default nil) ; Disable creating backup files with ~ extension
(menu-bar-mode -1) ; Disable the menu bar
(tool-bar-mode -1) ; Disable the tool bar
(scroll-bar-mode -1) ; Disable scroll bar
(add-to-list 'default-frame-alist '(font . "JetBrainsMonoNerdFontMono-12")) ; Default font
(add-hook 'prog-mode-hook 'display-line-numbers-mode) ; Display line numbers in programming modes.

;; Add melpa to package archives.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Install and load a default theme.
(progn 
  (unless (package-installed-p 'spacemacs-theme)
    (package-install 'spacemacs-theme))
  (unless (package-installed-p 'doom-themes)
    (package-install 'doom-themes))
  (load-theme 'doom-dark+ t)
  )

;; Web mode for web development.
(use-package web-mode
  :ensure t
  :mode (("\\.js\\'" . web-mode)
         ("\\.jsx\\'" . web-mode)
         ("\\.ts\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.html\\'" . web-mode)
         ("\\.css\\'" . web-mode)))

;; Some useful packages.
(use-package yasnippet ; Snippets Plugin
  :ensure t
  :config
  (yas-global-mode 1))

(use-package magit ; Git Integration
  :ensure t)

(use-package org-bullets ; UTF-8 Bullets Decoration for Org-mode
  :ensure t
  :hook org-mode)

(use-package vertico ; Vertical mini-buffer completion
  :ensure t
  :init
  (vertico-mode))

(use-package markdown-mode ; Markdown mode
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(doom-themes magit markdown-mode org-bullets spacemacs-theme vertico
		 web-mode yasnippet zenburn-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )







