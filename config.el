;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Enrico Tolotto"
      user-mail-address "etolotto@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(if (eq system-type 'windows-nt)
    (setq doom-font (font-spec :family "Hack" :size 16 :weight 'semi-light)
          doom-variable-pitch-font (font-spec :family "sans" :size 14))
)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; Spacemacs Themes
(setq doom-theme 'spacemacs-dark)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;;
(if (eq system-type 'windows-nt)
    (progn (setq org-roam-directory "W:/home/ento/Dropbox/org/roam/")
           (setq org-directory "W:/home/ento/Dropbox/org/"))
    (setq org-roam-directory "~/org/roam/")
    (setq org-directory "~/org/"))

;; Magit or rather git is extreamlly slow on Windows, the only solution is to use
;; a redefined status-buffer
;; https://emacs.stackexchange.com/questions/19440/magit-extremely-slow-in-windows-how-do-i-optimize
(use-package! magit
  :config
  (if (eq system-type 'windows-nt)
      (progn
        (setq exec-path (add-to-list 'exec-path "C:/Program Files (x86)/Git/bin"))
        (setenv "PATH" (concat "C:\\Program Files (x86)\\Git\\bin;" (getenv "PATH")))
        (define-derived-mode magit-staging-mode magit-status-mode "Magit staging"
          "Mode for showing staged and unstaged changes."
          :group 'magit-status)
        (defun magit-staging-refresh-buffer ()
          (magit-insert-section (status)
          (magit-insert-untracked-files)
          (magit-insert-unstaged-changes)
          (magit-insert-staged-changes)))
        (defun magit-staging ()
          (interactive)
          (magit-mode-setup #'magit-staging-mode)))))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(setq fill-column 120)

;; Orgmode
;;
(setq org-agenda-files '("~/org/thesis.org"))
(use-package! org-fancy-priorities
  :hook (org-mode . org-fancy-priorities-mode)
  :config (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

;; PlantUml
;;
(use-package! plantuml-mode
  :after org
  :config
  (setq plantuml-default-exec-mode 'jar)
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t))))


;; LSP settings
(setq lsp-enable-file-watchers t)

;; CCLS settings
;;
(use-package! ccls
  :init
  (if (eq system-type 'windows-nt)
      (progn (setq ccls-executable "ccls.exe")
              (setq ccls-initialization-options
                    `(:cache (:directory "..\ccls-cache"))))))

;; Splash Image
(setq fancy-splash-image nil)

;; Python mode
;;
(use-package! python
  :config
  (setq python-shell-interpreter "python3"))

;; add python as a org language
(use-package! org
  :config
  (org-babel-do-load-languages 'org-bable-load-languages '((python. t))))

;; Dired
;; Add dired+ after dired is load :-)
(after! dired
  (use-package! dired+))

;; Org auto tangle
;;
(use-package! org-auto-tangle
  :hook (org-mode . org-auto-tangle-mode))

;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
