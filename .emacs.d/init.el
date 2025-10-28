;; Emacs Startup Configuration File
;; Author: Manish Koirala

;; Disable the startup message
(setq inhibit-startup-message t)

;; Disable some default modes.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Default face
(add-to-list 'default-frame-alist '(font . "JetBrainsMonoNerdFontMono-12"))

;; Set visible bell
(setq visible-bell t)

;; Disable backupfiles.
(setq make-backup-files nil)

;; Fill column
(setq fill-column 80)

;; Add melpa to the package archives.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Default theme
(unless (package-installed-p 'spacemacs-theme)
  (package-install 'spacemacs-theme))
(load-theme 'spacemacs-dark t)

;; Set up treesitter for emacs.
(setq treesit-language-source-alist
      '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
      (markdown "https://github.com/ikatyang/tree-sitter-markdown")
      (json "https://github.com/tree-sitter/tree-sitter-json")
      (css "https://github.com/tree-sitter/tree-sitter-css")
      (html "https://github.com/tree-sitter/tree-sitter-html")
      (bash "https://github.com/tree-sitter/tree-sitter-bash")
      (python "https://github.com/tree-sitter/tree-sitter-python")))

(setq major-mode-remap-alist
 '((bash-mode . bash-ts-mode)
   (js2-mode . js-ts-mode)
   (typescript-mode . typescript-ts-mode)
   (json-mode . json-ts-mode)
   (css-mode . css-ts-mode)
   (python-mode . python-ts-mode)))


;; Useful packages
(use-package "magit" ;; Git Integration
  :ensure t)
(use-package "yasnippet" ;; Snippets Support
  :ensure t
  :config
  (yas-global-mode t))
(use-package "corfu" ;; Completions Framework
  :ensure t)
(use-package "ido-vertical-mode" ;; Completions for Minibuffer
  :ensure t
  :config
  (ido-mode 1)
  (ido-vertical-mode 1))
(use-package "dashboard" ;; Startup Screen
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents   . 5)
                        (bookmarks . 5)
                        (projects  . 5)))
  (setq dashboard-item-shortcuts '((recents   . "r")
                                   (bookmarks . "m")
                                   (projects  . "p"))))
(use-package "typit" ;; Typing Practise Plugin
  :ensure t)

(use-package "markdown-mode" ;; Ensure markdown mode is there.
  :ensure t)




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(corfu dashboard ido-vertical-mode magit markdown-mode
	   spacemacs-theme typit yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
