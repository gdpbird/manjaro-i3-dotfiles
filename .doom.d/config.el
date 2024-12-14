;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq display-line-numbers-type t)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "qutebrowser")

(setq max-lisp-eval-depth 10000)

(setq doom-theme 'doom-one)
(setq doom-font (font-spec :family "Mononoki Nerd Font" :size 12)
      doom-variable-pitch-font (font-spec :family "Mononoki Nerd Font" :size 12))
(setq nerd-icons-font-family "Mononoki Nerd Font")



(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)

(add-hook 'ibuffer-mode-hook #'nerd-icons-ibuffer-mode)

(add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup)

(with-eval-after-load 'corfu
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(beacon-mode 1)

;(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "刀客的刀DoctorDao")))

;(defun my-weebery-is-always-greater ()
;  (let* ((banner '(" ██████╗  ██████╗  ██████╗ ██████╗        ██████╗ ███████╗████████╗████████╗███████╗██████╗        ██████╗ ███████╗███████╗████████╗"
;                   "██╔════╝ ██╔═══██╗██╔═══██╗██╔══██╗       ██╔══██╗██╔════╝╚══██╔══╝╚══██╔══╝██╔════╝██╔══██╗       ██╔══██╗██╔════╝██╔════╝╚══██╔══╝"
;                   "██║  ███╗██║   ██║██║   ██║██║  ██║       ██████╔╝█████╗     ██║      ██║   █████╗  ██████╔╝       ██████╔╝█████╗  ███████╗   ██║   "
;                   "██║   ██║██║   ██║██║   ██║██║  ██║       ██╔══██╗██╔══╝     ██║      ██║   ██╔══╝  ██╔══██╗       ██╔══██╗██╔══╝  ╚════██║   ██║   "
;                   "╚██████╔╝╚██████╔╝╚██████╔╝██████╔╝▄█╗    ██████╔╝███████╗   ██║      ██║   ███████╗██║  ██║▄█╗    ██████╔╝███████╗███████║   ██║██╗"
;                   " ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝ ╚═╝    ╚═════╝ ╚══════╝   ╚═╝      ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝    ╚═════╝ ╚══════╝╚══════╝   ╚═╝╚═╝"))
;         (longest-line (apply #'max (mapcar #'length banner))))
;    (put-text-property
;     (point)
;     (dolist (line banner (point))
;       (insert (+doom-dashboard--center
;                +doom-dashboard--width
;                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
;               "\n"))
;     'face 'doom-dashboard-banner)))
;(setq +doom-dashboard-ascii-banner-fn #'my-weebery-is-always-greater)

(use-package! hydra
  :defer
  :config
  (defhydra hydra/evil-window-resize (:hint nil :color red)
    "
           _k_
           ↑
           |
     _h_ ←-- ◌ --→ _l_
           |
           ↓
           _j_
    "
;   ("l" evil-window-decrease-width "decrease width")
;   ("k" evil-window-decrease-height "decrease height")
;   ("j" evil-window-increase-height "increase height")
;   ("h" evil-window-increase-width "increase width")
;   ("q" nil "quit")
    ("l" evil-window-decrease-width)
    ("k" evil-window-decrease-height)
    ("j" evil-window-increase-height)
    ("h" evil-window-increase-width)
    ("q" nil)))
(map! :leader
      :prefix ("w" . "window")
      :n "z" #'hydra/evil-window-resize/body)

(defhydra hydra-dired (:hint nil :color pink)
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
  ("s" dired-sort-toggle-or-edit)
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
      :prefix ("d" . "dired")
      :n "h" #'hydra-dired/body)

;(global-page-break-lines-mode 1)
(page-break-lines-mode)

(use-package dashboard
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

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda ()
    (when (not (memq major-mode
                (list 'org-agenda-mode)))
     (rainbow-mode 1))))
(global-rainbow-mode 1 )



(use-package! lsp-mode
  :defer t
  :commands (lsp lsp-deferred)
; :init
; (defun lsp-save-actions ()
;   "LSP actions before save."
;   (add-hook 'before-save-hook #'lsp-organize-imports t t)
;   (add-hook 'before-save-hook #'lsp-format-buffer t t))
  :hook ((lsp-mode . #'lsp-enable-which-key-integration)
;        (lsp-mode . #'lsp-save-actions)
         ((python-mode
           vimrc-mode
           css-mode
           html+-mode
           javascript-mode
           typescript-mode
           json-mode
           sh-mode) . lsp-deferred))
; :config
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
  (setq
;  lsp-enable-symbol-highlighting t
;  lsp-lens-enable t
;  lsp-headerline-breadcrumb-enable t
;  lsp-completion-show-kind t
  )
)

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

(setq org-directory "~/org/")

(setq org-link-file-path-type 'relative)

(use-package! org-tempo
  :ensure nil
  :demand t
  :config
  (dolist (item '(("sh" . "src sh")
                  ("el" . "src emacs-lisp")
                  ("li" . "src lisp")
                  ("sc" . "src scheme")
                  ("ts" . "src typescript")
                  ("py" . "src python")
                  ("yaml" . "src yaml")
                  ("json" . "src json")
                  ("einit" . "src emacs-lisp :tangle emacs/init.el")
                  ("emodule" . "src emacs-lisp :tangle emacs/modules/dw-MODULE.el")))
    (add-to-list 'org-structure-template-alist item)))

;(setq! delete-by-moving-to-trash t
;       trash-directory "~/mdata3912-trash")
(setq! delete-by-moving-to-trash t
       trash-directory "/tmp")

(setq! dired-listing-switches "-ahl -v")

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
