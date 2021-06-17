;;; package --- init
;;; Commentary:
;;; Code:
;; -----------------------------------------------------------------
;; basic setting
;; -----------------------------------------------------------------
(setq
 backup-by-copying t ; don't clobber symlinks
 backup-directory-alist '(("." . "~/.emacs.d/backup/")) ; don't litter my fs tree
 )
(global-hl-line-mode 1) ; show cursor line
(setq inhibit-startup-screen t) ; No startup screen
(add-hook 'prog-mode-hook 'display-line-numbers-mode) ; show line number
(setq column-number-mode t) ; show column number
(transient-mark-mode t) ;
(setq shift-select-mode t) ; shift select on
(global-set-key (kbd "C-c C-c b") 'windmove-left)
(global-set-key (kbd "C-c C-c f") 'windmove-right)
(global-set-key (kbd "C-c C-c p") 'windmove-up)
(global-set-key (kbd "C-c C-c n") 'windmove-down)
(global-set-key (kbd "C-c c") 'company-complete)

;; -----------------------------------------------------------------
;; package setting
;; -----------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package ivy
  :diminish (ivy-mode . "")
  :init (ivy-mode 1); globally at startup
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 20)
  (setq ivy-count-format "%d/%d ")
  )

;; Override the basic Emacs commands
(use-package counsel
  :bind* ; load when pressed
  (("C-s" . swiper)
   ("C-c i" . indent-region)
   ("C-x C-f" . counsel-find-file)
   ("C-x C-r" . counsel-recentf)
   ("C-c C-/" . counsel-ag)
   ("C-c C-c d" . counsel-describe-function)
   ("C-c C-c v" . counsel-describe-variable)
   ("C-c C-c l" . counsel-find-library)
   ("C-c C-c i" . counsel-info-lookup-symbol)
   ("C-x l" . counsel-locate)
   ("C-x x" . counsel-M-x)
   ("C-c C-r" . ivy-resume)
   ))

(use-package which-key
  :init (which-key-mode))

(use-package projectile
  :init (projectile-global-mode))

(use-package helm-projectile
  :ensure t
  :config (helm-mode 1)
  :bind (("C-c C-p f" . helm-projectile-find-file)
	 ("C-c C-p p" . helm-projectile-switch-project)
	 ("C-c C-p b" . helm-projectile-switch-to-buffer)
	 ("C-c C-p g" . helm-projectile-grep)
         ("C-c p" . helm-projectile)
	 ;("C-x x" . helm-M-x)
	 ;("C-x C-f" . helm-find-files)
	 ("C-x C-b" . helm-buffers-list)
	 )
  )

(use-package smartparens
  :hook
  (lisp-mode-hook . smartparens-strict-mode)
  (scala-mode . smartparens-mode)
  )

;; (use-package company
;;   :config
;;   (setq company-show-numbers t)
;;   (setq company-tooltip-align-annotations t)
;;   :bind (("C-c c" . company-complete))
;;   )

(use-package helm-company
  :after helm-projectile
  :bind (("C-c C" . helm-company)))

(use-package yasnippet
  :demand t
  :diminish yas-minor-mode
  :commands yas-minor-mode
  :config
  (yas-reload-all)
  (yas-global-mode 1)
  )
;; (use-package yasnippet-snippets
;;   :after yasnippet
;;   :ensure t
;;   )

(use-package eyebrowse)
(eyebrowse-mode)

(use-package smart-comment
  :bind ("M-;" . smart-comment))

(use-package magit
  :bind ("C-x g" . magit-status)
  )

(use-package format-all)
(use-package json-mode)
(use-package toml-mode)

;; ============================================================================
;;  PKG - Prettifying Emacs                                                  
;; ============================================================================
  ;; ------------------------
  ;; Dashboard 
  ;; ------------------------
 
    (use-package dashboard
      :ensure t
      :config
      (setq dashboard-items '((recents  . 5)
                              (bookmarks . 5)
                              (projects . 5)
                              (agenda . 5)
                              (registers . 5)))
      (dashboard-setup-startup-hook)
      (setq dashboard-set-navigator t)
      (setq dashboard-center-content t))

  ;; ------------------------
  ;; smart-mode-line
  ;; ------------------------
    ;; (use-package smart-mode-line
    ;;   :config
    ;;   (setq sml/no-confirm-load-theme t
    ;;         sml/theme 'dark
    ;; 	    )
    ;;   (sml/setup))

  ;; ------------------------
  ;; hl-line 
  ;; ------------------------
 
    (use-package hl-line
      ;; visible current line
      :disabled
      :ensure t
      :diminish global-hl-line-mode
      :config (global-hl-line-mode))
 
  ;; ------------------------
  ;; highlight-parentheses
  ;; ------------------------
 
    (use-package highlight-parentheses
      :ensure t
      :diminish highlight-parentheses-mode
      :commands highlight-parentheses-mode)
 
  ;; ------------------------
  ;; highlight multiple occurences
  ;; ------------------------
 
    (use-package highlight-symbol 
      :ensure t
      :config
        (set-face-attribute 'highlight-symbol-face nil
                            :background "default"
                            :foreground "#33FF5D")
        (setq highlight-symbol-idle-delay 0)
        (setq highlight-symbol-on-navigation-p t)
      :hook
        (prog-mode . highlight-symbol-mode)
        (prog-mode . highlight-symbol-nav-mode))
 
  ;; ------------------------
  ;; Highlight-Indentation-for-Emacs
  ;; ------------------------
 
    (use-package highlight-indentation
      :ensure t)
 
  ;; ------------------------
  ;; color scheme - gruvbox theme
  ;; ------------------------

    ;; (use-package gruvbox-theme
    ;;   :ensure t
    ;;   :config
    ;;     (load-theme 'gruvbox-dark-hard t))

  ;; ------------------------
  ;; nyan cat mode
  ;; ------------------------
 
    ;; (use-package nyan-mode
    ;;   :config
    ;;   (nyan-mode 1))
 
  ;; ------------------------
  ;; htmlize - syntax highlight for HTML export
  ;; ------------------------
 
    (use-package htmlize
      :ensure t)
 
  ;; ------------------------
  ;; powerline
  ;; ------------------------
 
    ;; (use-package powerline
    ;;   :ensure t
    ;;   :config 
    ;;   (powerline-default-theme))

(use-package powerline
  :ensure t
  :config
  (use-package moe-theme
    :init
    ;; Show highlighted buffer-id as decoration. (Default: nil)
    ;; (setq moe-theme-highlight-buffer-id t)
    :config
    (moe-dark)
    ;; highlight block with matching parens
    ;; (show-paren-mode t)
    ;; (setq show-paren-style 'expression)
    (powerline-moe-theme)
    (powerline-reset)
    )
  )

  ;; ------------------------
  ;; rainbow-delimiters 
  ;; ------------------------
 
    (use-package rainbow-delimiters
      :ensure t)
 
  ;; ------------------------
  ;; rainbow-blocks
  ;; ------------------------
 
    (use-package rainbow-blocks
      :ensure t)
 
  ;; ------------------------
  ;; hl-todo
  ;; ------------------------
 
    ;; (use-package hl-todo
    ;;   :ensure t
    ;;   :config
    ;;   (setq hl-todo-keyword-faces
    ;;   '(("TODO"   . "#FF0000")
    ;;     ("FIXME"  . "#FF0000")
    ;;     ("DEBUG"  . "#A020F0")
    ;;     ("GOTCHA" . "#FF4500")
    ;;     ("STUB"   . "#1E90FF"))))

;; -----------------------------------------------------------------
;; BEGIN: scala metals
;; copy and paste from https://scalameta.org/metals/docs/editors/emacs.html
;; download company-lsp:
;;   $ cd  ~/.emacs.d/
;;   $ git clone https://github.com/tigersoldier/company-lsp
;; -----------------------------------------------------------------
;; Enable defer and ensure by default for use-package
;; Keep auto-save/backup files separate from source code:  https://github.com/scalameta/metals/issues/1027
(setq use-package-always-defer t
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      )

;; Enable scala-mode for highlighting, indentation and motion commands
(use-package scala-mode
  :interpreter
    ("scala" . scala-mode))

;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false"))
)

;; Enable nice rendering of diagnostics like compile errors.
(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c C-l")
  ;; Optional - enable lsp-mode automatically in scala files
  :hook  ((scala-mode . lsp)
	  (lsp-mode . lsp-lens-mode)
	  (lsp-mode . lsp-enable-which-key-integration))
  :config
  ;; Uncomment following section if you would like to tune lsp-mode performance according to
  ;; https://emacs-lsp.github.io/lsp-mode/page/performance/
  ;;       (setq gc-cons-threshold 100000000) ;; 100mb
  ;;       (setq read-process-output-max (* 1024 1024)) ;; 1mb
  ;;       (setq lsp-idle-delay 0.500)
  ;;       (setq lsp-log-io nil)
  ;;       (setq lsp-completion-provider :capf)
  (setq lsp-prefer-flymake nil))

;; Add metals backend for lsp-mode
(use-package lsp-metals
  :bind (("C-c m t" . lsp-metals-treeview)
	 ("C-c m h" . lsp-metals-treeview--hide-window))
  ; :config (setq lsp-metals-treeview-show-when-views-received t)
  )

;; Enable nice rendering of documentation on hover
;;   Warning: on some systems this package can reduce your emacs responsiveness significally.
;;   (See: https://emacs-lsp.github.io/lsp-mode/page/performance/)
;;   In that case you have to not only disable this but also remove from the packages since
;;   lsp-mode can activate it automatically.
(use-package lsp-ui)

;; lsp-mode supports snippets, but in order for them to work you need to use yasnippet
;; If you don't want to use snippets set lsp-enable-snippet to nil in your lsp-mode settings
;;   to avoid odd behavior with snippets and indentation
(use-package yasnippet)

;; Add company-lsp backend for metals.
;;   (depending on your lsp-mode version it may be outdated see:
;;    https://github.com/emacs-lsp/lsp-mode/pull/1983)
(use-package company-lsp
  :ensure nil
  :load-path "~/.emacs.d/company-lsp"
  :bind ("C-:" . helm-company)
  )

;; Use the Debug Adapter Protocol for running tests and debugging
(use-package posframe
  ;; Posframe is a pop-up tool that must be manually installed for dap-mode
  )
(use-package dap-mode
  :hook
  (lsp-mode . dap-mode)
  (lsp-mode . dap-ui-mode)
  )
;; -----------------------------------------------------------------
;; END: scala metals
;; -----------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(moe-theme powerline yasnippet which-key use-package smart-comment scala-mode sbt-mode lsp-ui lsp-metals helm-projectile helm-company flycheck eyebrowse)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
