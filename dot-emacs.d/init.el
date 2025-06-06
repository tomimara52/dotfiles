(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(require 'use-package)

(use-package undo-fu
	:ensure t)

(use-package evil
	:ensure t
	:init
	(setq evil-want-keybinding nil)
	:config
	(evil-mode 1)
	(evil-set-undo-system 'undo-fu))

(use-package general
        :ensure t
        :after (evil projectile dashboard org magit lsp-mode)
        :config
        (general-create-definer my-leader-def
                :prefix "SPC")

        (my-leader-def
                :states '(normal motion)
                :keymaps 'override
                "fb" 'find-file
                "f4" 'find-file-other-window
                "bl" 'list-buffers
                "bb" 'switch-to-buffer
                "b4" 'switch-to-buffer-other-window
                "br" 'revert-buffer
                "bk" 'kill-buffer
                "be" 'eval-buffer
                "wl" 'evil-window-right
                "wh" 'evil-window-left
                "wk" 'evil-window-up
                "wj" 'evil-window-down
                "wb" 'split-window-below
                "wr" 'split-window-right
                "wds" 'delete-window
                "wda" 'delete-other-windows
                "ms" 'magit-status
                "mcc" 'with-editor-finish
                "mck" 'with-editor-cancel
                "db" 'dired
                "d4" 'dired-other-window 
                "rs" 'point-to-register
                "rj" 'jump-to-register
                "rc" 'copy-to-register
                "rp" 'insert-register
                "hh" 'hs-hide-block
                "hs" 'hs-show-block
                "Bs" 'bookmark-set
                "Bj" 'bookmark-jump
                "Bl" 'list-bookmarks
                "Bd" 'bookmark-delete
                "^" 'enlarge-window
                "}" 'enlarge-window-horizontally
                "{" 'shrink-window-horizontally
                "=" 'balance-windows)

        (my-leader-def
                :states 'normal
                :keymaps 'dashboard-mode-map
                "dr" 'dashboard-jump-to-recents 
                "dB" 'dashboard-jump-to-bookmarks
                "dp" 'dashboard-jump-to-projects)

        (my-leader-def
                :states 'normal
                :keymaps 'org-mode-map
                "oi" 'org-toggle-inline-images
                "ot" 'org-babel-tangle
                "ol" 'org-latex-preview
                "on" 'org-next-visible-heading
                "op" 'org-previous-visible-heading
                "of" 'org-forward-heading-same-level
                "ob" 'org-backward-heading-same-level
                "ou" 'outline-up-heading
                "RET" 'org-return
                "TAB" 'org-cycle)

        (my-leader-def
                :states 'normal
                :keymaps 'xref--xref-buffer-mode-map
                "RET" 'xref-quit-and-goto-xref)

        (my-leader-def
                :states '(normal motion)
                :keymaps 'projectile-mode-map
                "p" 'projectile-command-map)

        (my-leader-def
                :states 'normal
                :keymaps 'rust-mode-map
                "r r" 'lsp-rust-analyzer-run)

        (general-def lsp-mode-map
                "C-l" lsp-command-map)
)

(use-package evil-collection
	:ensure t
	:after evil
	:config
	(evil-collection-init '(magit dired)))

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package doom-themes
:ensure t
:config
	(setq doom-themes-enable-bold t
	      doom-themes-enable-italic t)
	(load-theme 'doom-acario-dark t)
	(doom-themes-org-config))

(use-package projectile
	:ensure t
	:config
	(projectile-mode +1))

(use-package dashboard
  :ensure t
  :init
  ;(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-icon-type 'all-the-icons)
  (setq dashboard-center-content t)
  (setq dashboard-startup-banner 'official)
  (setq dashboard-show-shortcuts nil)
  (setq dashboard-items '((recents  . 4)
                          (projects . 3)
                          (bookmarks . 5)))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  :config
  (dashboard-setup-startup-hook))

(use-package magit
	:ensure t)

(use-package org
  :ensure t)
;(setq org-hide-emphasis-markers t)
(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.3))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
)
(add-hook 'org-mode-hook 'visual-line-mode)
(setq org-return-follows-link t)
(setq org-format-latex-options '(
  :foreground default
  :background default
  :scale 1.5
  :html-foreground "Black"
  :html-background "Transparent"
  :html-scale 1.0
  :matchers
    ("begin" "$1" "$" "$$" "\\(" "\\[")))

(use-package markdown-mode
  :ensure t
  :config
    (setq markdown-command '("markdown_py" "--extension=tables"))
)

(use-package company
  :ensure t
  :config
    (setq company-minimum-prefix-length 1
          company-idle-delay 0.1) 
)

(use-package yasnippet
  :ensure t
  :after (lsp-mode) 
  :config
    (add-hook 'lsp-mode-hook #'yas-minor-mode))

(use-package php-mode
  :ensure t
)

(use-package rust-mode
  :ensure t
)

(use-package web-mode
  :ensure t
)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(use-package emmet-mode
  :ensure t
)
(add-hook 'web-mode-hook 'emmet-mode)

(use-package lsp-haskell
  :ensure t
)

(use-package haskell-mode
  :ensure t
)

(use-package lsp-java
  :ensure t
)

(setenv "PATH" (concat (getenv "PATH") ":/home/tomi/.ghcup/bin"))

(defun set-compilation-input ()
  (comint-mode)
  (read-only-mode 0)
  (evil-normal-state)
)

(add-hook 'compilation-mode-hook 'set-compilation-input)

(use-package lsp-mode
  :ensure t
  :hook (
    (c-mode . lsp)
    (c++-mode . lsp)
    (python-mode . lsp)
    (js-mode . lsp)
    (php-mode . lsp)
    (web-mode . lsp)
    (rust-mode . lsp)
    (haskell-mode . lsp)
    (java-mode . lsp)
    (css-mode . lsp)
  )
  :init
    (setq lsp-keymap-prefix "C-l")
  :config
    (setq lsp-pylsp-server-command "/home/tomi/.local/bin/pylsp")
    (setq lsp-pylsp-plugins-pydocstyle-add-ignore '("D100" "D101" "D102" "D103" "D104" "D105" "D106" "D107"))
    (setq lsp-pyls-plugins-pycodestyle-enabled nil)
    (setq lsp-rust-analyzer-lens-debug-enable nil)
    (setq exec-path (append exec-path '("/home/tomi/.ghcup/bin")))
    (lsp-register-client
       (make-lsp-client
        :new-connection (lsp-stdio-connection "texlab")
        :major-modes '(org-mode)
        ))

  :commands lsp
) 

(add-hook 'web-mode-hook 'company-mode)
(add-hook 'css-mode-hook 'company-mode)

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

(use-package ivy
	:ensure t
	:config
		(ivy-mode 1)
)

(setq gdb-many-windows t)
(setq gdb-restore-window-configuration-after-quit t)

;(set-face-attribute 'default nil :font "JetBrains Mono" :weight 'semi-bold)
;(set-frame-font "JetBrains Mono SemiBold" 11)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(global-display-line-numbers-mode)

(setq line-number-mode t)
(setq column-number-mode t)

(defun disable-tabs (width)
    (general-define-key
    :states 'insert
    :keymaps 'local
    "TAB" 'tab-to-tab-stop)
    (setq indent-tabs-mode nil)
    (setq tab-width width)
    (setq evil-shift-width width))

(defun enable-tabs (width)
    (general-define-key
    :states 'insert
    :keymaps 'local
    "TAB" 'tab-to-tab-stop)
    (setq indent-tabs-mode t)
    (setq tab-width width)
    (setq evil-shift-width width))

(add-hook 'emacs-lisp-mode-hook (lambda () (disable-tabs 2)))
(add-hook 'org-mode-hook (lambda () (disable-tabs 2)))
(add-hook 'haskell-mode-hook (lambda () (disable-tabs 2)))
(add-hook 'c-mode-hook (lambda () 
    (disable-tabs 4)
    (setq c-default-style "linux"
      c-basic-offset 4)))

(add-hook 'c++-mode-hook (lambda () 
    (disable-tabs 4)
    (setq c-default-style "linux"
      c-basic-offset 4)))

(add-hook 'js-mode-hook (lambda () 
    (disable-tabs 4)))

(add-hook 'asm-mode-hook (lambda () (disable-tabs 4)))

(add-hook 'python-mode-hook (lambda () (disable-tabs 4)))

(add-hook 'web-mode-hook (lambda () (disable-tabs 4)))

(add-hook 'rust-mode-hook (lambda () (disable-tabs 4)))

(add-hook 'java-mode-hook (lambda () (disable-tabs 4)))

(setq scroll-conservatively 1)

(setq make-backup-files nil)

(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'haskell-mode-hook 'hs-minor-mode)

;(defun activate-column (col)
;  (display-fill-column-indicator-mode 1)
;  (setq fill-column col))

;(add-hook 'rust-mode-hook (lambda ()
;                            (activate-column 75)
;                          ))

;(add-hook 'c++-mode-hook (lambda ()
;                            (activate-column 75)
;                          ))

;(add-hook 'c-mode-hook (lambda ()
;                            (activate-column 75)
;                          ))

;(add-hook 'php-mode-hook (lambda ()
;                            (activate-column 75)
;                          ))

;(add-hook 'python-mode-hook (lambda ()
;                            (activate-column 75)
;                          ))
