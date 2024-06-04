;; Emacs Startup Configuration

(setq inhibit-startup-message t)

(add-to-list 'default-frame-alist
             '(font . "JetBrainsMono-12"))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(fido-vertical-mode t) 
(icomplete-vertical-mode t)


(load-theme 'spacemacs-dark t)
(use-package "magit"
  :ensure t)
(use-package "corfu"
  :ensure t
  :config
  (global-corfu-mode 1))
