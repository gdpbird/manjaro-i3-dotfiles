;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; ----------------mdata3912---------------- ;;

;; +-----------+
;; | doom-font |
;; +-----------+

(setq doom-font (font-spec :family "Mononoki Nerd Font" :size 12)
      doom-variable-pitch-font (font-spec :family "Mononoki Nerd Font" :size 12))
;(setq doom-font (font-spec :family "Sarasa Mono SC" :size 12)
;      doom-variable-pitch-font (font-spec :family "Sarasa Mono SC" :size 13))
;(setq doom-font (font-spec :family "Sarasa Term SC Nerd" :size 12)
;      doom-variable-pitch-font (font-spec :family "Sarasa Term SC Nerd" :size 13))

;; +-----------+
;; | nerd-font |
;; +-----------+

(setq nerd-icons-font-family "Mononoki Nerd Font")
(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)
(add-hook 'ibuffer-mode-hook #'nerd-icons-ibuffer-mode)
(add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup)
(with-eval-after-load 'corfu
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; +--------+
;; | beacon |
;; +--------+

(beacon-mode 1)

;; +-------+
;; | dired |
;; +-------+

;; +---------------------------------+
;; | dired#delete-by-moving-to-trash |
;; +---------------------------------+

;; Windows shared folder report error:
;; file-error: Copying permissions to: Operation not permitted, /home/md/mdata3912-trash/1.txt.~1~
;(setq! delete-by-moving-to-trash t
;       trash-directory "~/mdata3912-trash")
(setq! delete-by-moving-to-trash t
       trash-directory "/tmp")
;(setq! dired-listing-switches "-ahl -v")

;; +---------------+
;; | dired#dirvish |
;; +---------------+

(after! dirvish
  (setq! dirvish-quick-access-entries
         `(("h" "~/"                           "~")
           ("m" "~/mdata3912"                  "mdata3912")
           ("t" "~/mdata3912-tmp"              "mdata3912-tmp")
           ("r" "~/mdata3912-trash"            "trash")
           ("e" "~/.emacs.d"                   "emacs-d")
           ("d" "~/.doom.d"                    "doom-d"))))

;; +------------------+
;; | dired#peep-dired |
;; +------------------+

(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; Add the key binding SPC d p to toggle peep-dired-mode while in dired (you can add the key binding you like)
(map! :leader
       (:prefix ("d" . "dired")
        :desc "Open dired" "d" #'dired
        :desc "Dired jump to current" "j" #'dired-jump)
       (:after dired
        (:map dired-mode-map
         :desc "Peep-dired image preview" "d p" #'peep-dired
         :desc "Dired view file" "d v" #'dired-view-file)))

;; +---------+
;; | browser |
;; +---------+

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "qutebrowser")

;; +----------------+
;; | doom-dashboard |
;; +----------------+

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

;; +-------+
;; | hydra |
;; +-------+

;; +--------------+
;; | hydra#window |
;; +--------------+

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

;; +-------------+
;; | hydra#dired |
;; +-------------+

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

;; +------------------+
;; | page-break-lines |
;; +------------------+

(page-break-lines-mode)
;(global-page-break-lines-mode 1)

;; +-----------+
;; | dashboard |
;; +-----------+

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  :init
  (setq dashboard-items '((recents  . 5)
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
        dashboard-banner-logo-title "good-better-best-never-let-it-rest"
        initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name))))

;; +----------+
;; | org-mode |
;; +----------+

(setq org-link-file-path-type 'relative)
