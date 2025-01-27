;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ivo Murrell"
      user-mail-address "ivoivo@hey.com")

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "JetBrains Mono" :size 12))
(setq doom-variable-pitch-font (font-spec :family "Source Sans Pro" :size 20))
(add-hook! 'writeroom-mode-hook
  (if writeroom-mode (setq line-spacing 0) (kill-local-variable 'line-spacing)))
(add-hook! 'writeroom-mode-hook
  (setq display-line-numbers (not writeroom-mode)))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-shades-of-purple)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


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

;; Way too slow to be useable.
;; (setq mac-mouse-wheel-smooth-scroll t)

;; (setq find-function-C-source-directory "~/Documents/dev/emacs-mac/src")

;; Treat underscores as part of a word in Rust
(add-hook! 'rustic-mode-hook (modify-syntax-entry ?_ "w"))
(setq lsp-rust-analyzer-proc-macro-enable t)
(setq lsp-rust-analyzer-cargo-watch-command "clippy")
(setq lsp-rust-cfg-test t)
(setq lsp-rust-all-features t)
(setq lsp-modeline-diagnostics-enable nil)

(setq doom-modeline-lsp nil
      doom-modeline-indent-info t
      doom-modeline-major-mode-icon t
      doom-modeline-default-eol-type 0
      doom-modeline-github t
      mode-line-percent-position nil)

(use-package! vertico-directory
  :config
  (map! :map vertico-map "C-l" #'vertico-directory-enter))

;; NEOtree
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; treemacs
(setq +treemacs-git-mode 'deferred)

;; Allow hash and en-dash to be entered
(global-set-key (kbd "M-3") #'(lambda () (interactive) (insert "#")))
(global-set-key (kbd "M--") #'(lambda () (interactive) (insert "–")))
;; For some reason the left ALT key on my external keyboard reports as the right
(setq mac-right-option-modifier 'left)

;; isepell
(setq ispell-dictionary "en_GB")

;; Automatically wrap lines when typing in text modes
(add-hook 'text-mode-hook #'turn-on-auto-fill)

;; vterm
(map! :map vterm-mode-map :g "C-c C-d" #'vterm-send-C-d)
;; evil-multiedit
;; Use command key instead of alt
(map!
 :v  "R"     #'evil-multiedit-match-all
 :n  "s-d"   #'evil-multiedit-match-symbol-and-next
 :n  "s-D"   #'evil-multiedit-match-symbol-and-prev
 :v  "s-d"   #'evil-multiedit-match-and-next
 :v  "s-D"   #'evil-multiedit-match-and-prev
 :nv "C-s-d" #'evil-multiedit-restore
 (:after evil-multiedit
  (:map evil-multiedit-state-map
   "s-d" #'evil-multiedit-match-and-next
   "s-D" #'evil-multiedit-match-and-prev
   "RET" #'evil-multiedit-toggle-or-restrict-region)
  (:map (evil-multiedit-state-map evil-multiedit-insert-state-map)
   "C-n" #'evil-multiedit-next
   "C-p" #'evil-multiedit-prev)))

;; scroll-on-jump
(after! scroll-on-jump
  (after! evil
    (scroll-on-jump-advice-add evil-undo)
    (scroll-on-jump-advice-add evil-redo)
    (scroll-on-jump-advice-add evil-jump-item)
    (scroll-on-jump-advice-add evil-jump-forward)
    (scroll-on-jump-advice-add evil-jump-backward)
    (scroll-on-jump-advice-add evil-ex-search-next)
    (scroll-on-jump-advice-add evil-ex-search-previous)
    (scroll-on-jump-advice-add evil-forward-paragraph)
    (scroll-on-jump-advice-add evil-backward-paragraph)
    (scroll-on-jump-advice-add evil-goto-mark)

    ;; Actions that themselves scroll.
    (scroll-on-jump-with-scroll-advice-add evil-goto-line)
    (scroll-on-jump-with-scroll-advice-add evil-goto-first-line)
    (scroll-on-jump-with-scroll-advice-add evil-scroll-down)
    (scroll-on-jump-with-scroll-advice-add evil-scroll-up)
    (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-center)
    (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-top)
    (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-bottom)
    (scroll-on-jump-with-scroll-advice-add magit-jump-to-diffstat-or-diff))
  (scroll-on-jump-advice-add +lookup--jump-to)
  (setq scroll-on-jump-duration 0.25))

;; evil
;; Let you move to the next line with h, l etc
(setq evil-cross-lines t)
;; evil-snipe
;; Mirror vim-sneak
(setq evil-snipe-scope 'buffer)

;; Start emacs in fullscreen mode
(add-to-list 'default-frame-alist '(fullscreen . fullscreen))

;; Don't ask to confirm quitting Emacs if all buffers are saved
(setq confirm-kill-emacs nil)
;; Also don't complain about vterm being open
;; TODO maybe find a way to not have vterm listed as an active process when it's
;; not running anything
(setq confirm-kill-processes nil)

;; Don't need to see the ./ directory
(setq ivy-extra-directories '("../"))

;; Useful keymap alternatives
(map! :leader :desc "ibuffer for workspace" :g "b I"
      #'+ibuffer/open-for-current-workspace)
(map! :leader :desc "Visualise undo-tree" :g "o u" #'undo-tree-visualize)
(map! :leader :desc "Find file in other window" :g "g f F"
      #'magit-find-file-other-window)
(map! :map git-commit-mode-map "C-c C-a" #'git-commit-co-authored)
(map! :n "z X" #'kill-buffer-and-window)
(map! :leader :desc "Diff hunk" :g "g d" #'git-gutter:popup-hunk)
(map! :leader :desc "Auto Fill mode" :g "t W" #'auto-fill-mode)
(map! :leader :desc "Format on save" :g "t S" #'format-all-mode)
(map! :leader :desc "Subword mode" :g "t s" #'subword-mode)
(map! :map ivy-minibuffer-map
      "M-j" #'ivy-next-history-element
      "M-k" #'ivy-previous-history-element
      "M-SPC" #'ivy-restrict-to-matches)

(setq highlight-indent-guides-method 'bitmap)
(setq highlight-indent-guides-responsive 'top)

;; (setq org-hide-emphasis-markers t)
(setq org-footnote-auto-adjust t)

(after! smartparens (require 'smartparens-org))

(setq +vc-gutter-default-style nil)

(setq which-key-idle-delay 0.4)

(add-to-list '+format-on-save-enabled-modes 'yaml-mode t)
;; We want to use prettier when a config file is defined
(add-hook!
 '(typescript-mode-hook rjsx-mode-hook yaml-mode-hook json-mode-hook)
 (if (= 0
        (car
         (doom-call-process
          "prettier" "--find-config-path" (buffer-file-name))))
     (setq-local +format-with-lsp nil)))

(add-to-list '+lookup-provider-url-alist '("NPM" "https://www.npmjs.com/search?q=%s"))

;; Use flycheck-posframe instead
(setq lsp-ui-sideline-enable nil)

(after! magit
  ;; Set remote branches as the upstream so we can see when others have pushed
  ;; changes to, e.g., main as soon as we fetch
  (setq magit-prefer-remote-upstream t))

(after! lispyville
  ;; Enable additional lispville themes (additional-wrap and text-objects)
  (lispyville-set-key-theme
   '((operators normal)
     c-w
     (prettify insert)
     (atom-movement t)
     slurp/barf-lispy
     additional
     additional-insert
     additional-wrap
     text-objects)))
