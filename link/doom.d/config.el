;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Marcus Ramberg"
      user-mail-address "marcus.ramberg@gmail.com")

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
(setq doom-font "JetbrainsMono Nerd Font-16")


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)


(setq doom-localleader-key "\\")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(setq deft-directory org-directory)

(setq projectile-project-search-path '("~/Source" "~/Source/DNB"))

;; Include _ in words.
(add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

;; Allow multiple paste
(defun evil-paste-after-from-0 ()
  (interactive)
  (let ((evil-this-register ?0))
    (call-interactively 'evil-paste-after)))
(define-key evil-visual-state-map "p" 'evil-paste-after-from-0)

;; Org mode
(after! org
  (setq org-agenda-files (list "~/org/inbox.org"
                               "~/org/work.org"
                               "~/org/projects.org"
                               "~/org/home.org")
        org-refile-targets '((org-agenda-files :maxlevel . 2))
        org-modules (quote (org-protocol))
        calendar-week-start-day 1)

  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/org/inbox.org" "Tasks") "* TODO %?\n %i\n %a")
          ("j" "Journal" entry (file+olp+datetree "~/org/journal.org") "* %?\nEntered on %U\n %i\n %a")
          ("p" "Protocol" entry (file+headline "~/org/inbox.org" "Bookmarks")
           "* %? [[%:link][%:description]]\n#+begin_quote\n%i\n:+end_quote\nCaptured On: %U"
           :empty-lines 1)
          ("L" "Protocol Link" entry (file+headline "~/org/inbox.org" "Bookmarks")
           "* %? [[%:link][%:description]]\nCaptured On: %U"
           :empty-lines 1)
          ("K" "Cliplink capture task" entry (file "")
           "* TODO %(org-cliplink-capture) \n  SCHEDULED: %t\n" :empty-lines 1)
          ("c" "Cookbook" entry (file+headline "~/org/cooking.org" "Inbox")
           "%(org-chef-get-recipe-from-url)"
           :empty-lines 1)
          ("M" "Manual Cookbook" entry (file+headline "~/org/cooking.org" "Inbox")
           "* %^{Recipe title: }\n  :PROPERTIES:\n  :source-url:\n  :servings:\n  :prep-time:\n  :cook-time:\n  :ready-in:\n  :END:\n** Ingredients\n   %?\n** Directions\n\n")
          ))

  (setq org-todo-keywords
        '((sequence "TODO(t!)" "WAITING(w!)" "INPROGRESS(p!)"  "|" "DONE(d!) OBSOLETE(o!)")

          (sequence "IDEA(i!)" "MAYBE(y!)" "STAGED(s!)" "WORKING(k!)" "|" "USED(u!/@)")
          ))
  )


;; Cloudformation
(after! yaml
  (when (featurep 'yaml-mode)

    (define-derived-mode cfn-mode yaml-mode
      "Cloudformation"
      "Cloudformation template mode.")

    (add-to-list 'magic-mode-alist
                 '("\\(---\n\\)?AWSTemplateFormatVersion:" . cfn-mode))

    (when (featurep 'flycheck)
      (flycheck-define-checker cfn-lint
        "AWS CloudFormation linter using cfn-lint.



Install cfn-lint first: pip install cfn-lint

See `https://github.com/aws-cloudformation/cfn-python-lint'."

        :command ("cfn-lint" "-f" "parseable" source)
        :error-patterns ((warning line-start (file-name) ":" line ":" column
                                  ":" (one-or-more digit) ":" (one-or-more digit) ":"
                                  (id "W" (one-or-more digit)) ":" (message) line-end)
                         (error line-start (file-name) ":" line ":" column
                                ":" (one-or-more digit) ":" (one-or-more digit) ":"
                                (id "E" (one-or-more digit)) ":" (message) line-end))
        :modes (cfn-mode))

      (add-to-list 'flycheck-checkers 'cfn-lint)
      (add-hook 'cfn-mode-hook 'flycheck-mode)))
  )

;; Enable auto save
(auto-save-visited-mode +1)


;; Configure jsonnet to use grafonnet
(setq jsonnet-enable-debug-print t)
(setq jsonnet-library-search-directories "grafonnet-lib")


(setq HUGO_BASE_DIR "~/Source/blog")

;;(eval-after-load 'auth-source
;;  '(when (member window-system '(mac ns))
;;     (add-to-list 'auth-sources 'macos-keychain-internet)
;;     (add-to-list 'auth-sources 'macos-keychain-generic)))
