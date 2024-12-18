;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq display-line-numbers-type t)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "qutebrowser")
(setq max-lisp-eval-depth 10000)

(use-package! doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
; (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t
        doom-themes-treemacs-theme "doom-atom")

(setq doom-font (font-spec :family "Mononoki Nerd Font" :size 12)
      doom-variable-pitch-font (font-spec :family "Mononoki Nerd Font" :size 12))
(setq nerd-icons-font-family "Mononoki Nerd Font")
(setq doom-emoji-font (font-spec :family "Twitter Color Emoji"))

;(setq doom-unicode-font (font-spec :family "TeX Gyre Termes Math"))

(setq doom-unicode-font (font-spec :family "JuliaMono-Regular"))

(add-to-list 'doom-emoji-fallback-font-families "Twitter Color Emoji")

(use-package! nerd-icons
  :custom
  (nerd-icons-font-family "Symbols Nerd Font Mono"))

(use-package! nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package! nerd-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode)
  :config
  (setq nerd-icons-ibuffer-icon t
        nerd-icons-ibuffer-color-icon t
        nerd-icons-ibuffer-icon-size 1.0
        nerd-icons-ibuffer-human-readable-size t
        inhibit-compacting-font-caches t)
  nerd-icons-ibuffer-formats)

(use-package! nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package! nerd-icons-corfu
; :config
; (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)
)

(beacon-mode 1)

(use-package! dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  :init
  (setq dashboard-items '((recents  . 15)
                         (bookmarks . 5)
                         (projects  . 5)
                         (agenda    . 5)
                         (registers . 5))
;       dashboard-startup-banner "~/mdata3912-tmp/doctordao.jpg"
        dashboard-item-shortcuts '((recents   . "r")
                                   (bookmarks . "m")
                                   (projects  . "p")
                                   (agenda    . "a")
                                   (registers . "e"))
        dashboard-display-icons-p t
        dashboard-icon-type 'nerd-icons
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
;       dashboard-banner-logo-title "good-better-best-never-let-it-rest"
        initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name))))

;(page-break-lines-mode)
(use-package! page-break-lines
  :hook (dashboard-mode-hook . page-break-lines-mode))

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda ()
    (when (not (memq major-mode
                (list 'org-agenda-mode)))
     (rainbow-mode 1))))
(global-rainbow-mode 1 )

(setq! emojify-emojis-dir "~/.emacs.d/.local/cache/emojis")
(setq! emojify-download-emojis-p 'ask)
(setq! emojify-emoji-set "twemoji-color-font")

(use-package! hydra
  :defer)

(defhydra hydra/evil-window-resize (:hint nil :color red)
  "
         _k_
         ↑
    _h_ ←  o → _l_
         ↓
         _j_
  "
; ("l" evil-window-decrease-width "decrease width")
; ("k" evil-window-decrease-height "decrease height")
; ("j" evil-window-increase-height "increase height")
; ("h" evil-window-increase-width "increase width")
; ("q" nil "quit")
  ("l" evil-window-decrease-width)
  ("k" evil-window-decrease-height)
  ("j" evil-window-increase-height)
  ("h" evil-window-increase-width)
  ("q" nil))

(defhydra hydra/dired (:hint nil :color pink)
  "
_+_ mkdir          _v_iew           _m_ark             _(_ details        _i_nsert-subdir    wdired
_C_opy             _O_ view other   _U_nmark all       _)_ omit-mode      _$_ hide-subdir    C-x C-q : edit
_D_elete           _o_pen other     _u_nmark           _l_ redisplay      _w_ kill-subdir    C-c C-c : commit
_R_ename           _M_ chmod        _t_oggle           _g_ revert buf     _e_ ediff          C-c ESC : abort
_Y_ rel symlink    _G_ chgrp        _E_xtension mark   _s_ort             _=_ pdiff
_S_ymlink          ^ ^              _F_ind marked      _._ toggle hydra   \\ flyspell
_r_sync            ^ ^              ^ ^                ^ ^                _?_ summary
_z_ compress-file  _A_ find regexp
_Z_ compress       _Q_ repl regexp

T - tag prefix
"
  ("\\" dired-do-ispell)
  ("(" dired-hide-details-mode)
  (")" dired-omit-mode)
  ("+" dired-create-directory)
  ("=" diredp-ediff) ;; smart diff
  ("?" dired-summary)
  ("$" diredp-hide-subdir-nomove)
  ("A" dired-do-find-regexp)
  ("C" dired-do-copy) ;; Copy all marked files
  ("D" dired-do-delete)
  ("E" dired-mark-extension)
  ("e" dired-ediff-files)
  ("F" dired-do-find-marked-files)
  ("G" dired-do-chgrp)
  ("g" revert-buffer) ;; read all directories again (refresh)
  ("i" dired-maybe-insert-subdir)
  ("l" dired-do-redisplay) ;; relist the marked or singel directory
  ("M" dired-do-chmod)
  ("m" dired-mark)
  ("O" dired-display-file)
  ("o" dired-find-file-other-window)
  ("Q" dired-do-find-regexp-and-replace)
  ("R" dired-do-rename)
  ("r" dired-do-rsynch)
  ("S" dired-do-symlink)
; ("s" dired-sort-toggle-or-edit)
  ("s" cycle-dired-switches)
  ("t" dired-toggle-marks)
  ("U" dired-unmark-all-marks)
  ("u" dired-unmark)
  ("v" dired-view-file) ;; q to exit, s to search, = gets line #
  ("w" dired-kill-subdir)
  ("Y" dired-do-relsymlink)
  ("z" diredp-compress-this-file)
  ("Z" dired-do-compress)
  ("q" nil)
  ("." nil :color blue))

(map! :leader
       (:prefix ("y" . "hydra")
         (:prefix ("w" . "window")
          :desc "evil-window-resize" :n "r" #'hydra/evil-window-resize/body)
        :desc "dired" :n "d" #'hydra/dired/body))

(use-package! lsp-mode
  :defer t
  :commands (lsp lsp-deferred)
  :init
; (defun lsp-save-actions ()
;   "LSP actions before save."
;   (add-hook 'before-save-hook #'lsp-organize-imports t t)
;   (add-hook 'before-save-hook #'lsp-format-buffer t t))
  :hook ((lsp-mode . #'lsp-enable-which-key-integration)
;        (lsp-mode . #'lsp-save-actions)
         ((
           python-mode
           vimrc-mode
           css-mode
           html+-mode
           javascript-mode
           typescript-mode
           json-mode
           c-mode
           c++-mode
           sh-mode
          ) . lsp-deferred))
  :config
; (setq lsp-auto-guess-root t
;       lsp-headerline-breadcrumb-enable nil
;       lsp-keymap-prefix "C-c l"
;       lsp-log-io nil)
; (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
)

(use-package! lsp-ui
  :defer t
  :commands lsp-ui-mode
  :hook
  (lsp-mode . lsp-ui-mode)
  :config
; (setq lsp-enable-symbol-highlighting nil
;       lsp-ui-doc-enable nil
;       lsp-ui-doc-show-with-cursor nil
;       lsp-ui-doc-show-with-mouse nil
;       lsp-lens-enable nil
;       lsp-headerline-breadcrumb-enable nil
;       lsp-ui-sideline-enable nil
;       lsp-ui-sideline-show-code-actions nil
;       lsp-ui-sideline-enable nil
;       lsp-ui-sideline-show-hover nil
;       lsp-modeline-code-actions-enable nil
;       lsp-diagnostics-provider :none
;       lsp-ui-sideline-enable nil
;       lsp-ui-sideline-show-diagnostics nil
;       lsp-eldoc-enable-hover nil
;       lsp-modeline-diagnostics-enable nil
;       lsp-signature-auto-activate nil
;       lsp-signature-render-documentation nil
;       lsp-completion-provider :none
;       lsp-completion-show-detail nil
;       lsp-completion-show-kind nil
; )
)

(use-package! tree-sitter
  :defer t
  :config
  (global-tree-sitter-mode) ;; activate tree-sitter on any buffer containing code for which it has a parser available
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode) ;; you can easily see the difference tree-sitter-hl-mode makes for python, ts or tsx by switching on and off
; (setq +tree-sitter-hl-enabled-modes '(python-mode go-mode)
;       +tree-sitter-hl-enabled-modes '(not web-mode typescript-tsx-mode)
;       +tree-sitter-hl-enabled-modes t)
)

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)

;(setq org-directory "~/org/")

(setq org-link-file-path-type 'relative)
(setq org-id-locations-file "~/doctor-dao/.org-id-locations" )
(setq org-id-link-to-org-use-id 'use-existing)

(use-package! org-tempo
  :ensure nil
  :demand t
  :config
  (dolist (item '(("sh"      . "src sh")
                  ("el"      . "src emacs-lisp")
                  ("li"      . "src lisp")
                  ("sc"      . "src scheme")
                  ("ts"      . "src typescript")
                  ("py"      . "src python")
                  ("yaml"    . "src yaml")
                  ("json"    . "src json")
                  ("einit"   . "src emacs-lisp :tangle emacs/init.el")
                  ("emodule" . "src emacs-lisp :tangle emacs/modules/dw-MODULE.el")))
    (add-to-list 'org-structure-template-alist item)))

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))
(defun dt/insert-auto-tangle-tag ()
  "Insert auto-tangle tag in a literate config."
  (interactive)
  (evil-org-open-below 1)
  (insert "#+auto_tangle: t ")
  (evil-force-normal-state))
(map! :leader
      :desc "Insert auto_tangle tag" "i a" #'dt/insert-auto-tangle-tag)

(use-package! lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "pyright") ;; or basedpyright
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))  ; or lsp-deferred

(use-package! vimrc-mode
  :defer t
  :mode
  "\\.vim\\(rc\\)?\\'"
  "\\.vifm\\'"
  :config
  (setq evil-shift-width 2))

(after! lsp-volar
  ;; remove :system after lsp-volar loaded
  (lsp-dependency 'typescript
                  '(:npm :package "typescript"
                    :path "tsserver")))

(use-package! typescript-mode
  :after tree-sitter
  :config
  ;; we choose this instead of tsx-mode so that eglot can automatically figure out language for server
  ;; see https://github.com/joaotavora/eglot/issues/624 and https://github.com/joaotavora/eglot#handling-quirky-servers
  (define-derived-mode typescriptreact-mode typescript-mode
    "TypeScript TSX")
  ;; use our derived mode for tsx files
  (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescriptreact-mode))
  ;; by default, typescript-mode is mapped to the treesitter typescript parser
  ;; use our derived mode to map both .tsx AND .ts -> typescriptreact-mode -> treesitter tsx
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescriptreact-mode . tsx)))

(setq! delete-by-moving-to-trash t
       trash-directory "/tmp")

(defcustom list-of-dired-switches
; '("-l" "-la" "-lA" "-lA --group-directories-first")
; '("-lh" "-lha" "-lha --group-directories-first")
  '("-lh" "-lha")
  "List of ls switches for dired to cycle among.")
(defun cycle-dired-switches ()
  "Cycle through the list `list-of-dired-switches' of switches for ls"
  (interactive)
  (setq list-of-dired-switches
        (append (cdr list-of-dired-switches)
                (list (car list-of-dired-switches))))
  (dired-sort-other (car list-of-dired-switches)))

(after! dirvish
  (setq! dirvish-quick-access-entries
         `(("h" "~/"                "~")
           ("m" "~/mdata3912"       "mdata3912")
           ("t" "~/mdata3912-tmp"   "mdata3912-tmp")
           ("r" "~/mdata3912-trash" "trash")
           ("e" "~/.emacs.d"        "emacs-d")
           ("d" "~/.doom.d"         "doom-d"))))

(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(map! :leader
       (:prefix ("d" . "dired")
        :desc "Open dired" "d" #'dired
        :desc "Dired jump to current" "j" #'dired-jump)
       (:after dired
        (:map dired-mode-map
         :desc "Peep-dired image preview" "d p" #'peep-dired
         :desc "Dired view file" "d v" #'dired-view-file)))

(after! yasnippet
  (add-to-list 'yas-snippet-dirs "~/.doom.d/snippets"))
