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
(setq doom-localleader-alt-key "M-\\")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


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


;; more evil
(after! evil
  (require 'evil-textobj-anyblock)
  (evil-define-text-object my-evil-textobj-anyblock-inner-quote
    (count &optional beg end type)
    "Select the closest outer quote."
    (let ((evil-textobj-anyblock-blocks
           '(("'" . "'")
             ("\"" . "\"")
             ("`" . "`")
             ("“" . "”"))))
      (evil-textobj-anyblock--make-textobj beg end type count nil)))

  (evil-define-text-object my-evil-textobj-anyblock-a-quote
    (count &optional beg end type)
    "Select the closest outer quote."
    (let ((evil-textobj-anyblock-blocks
           '(("'" . "'")
             ("\"" . "\"")
             ("`" . "`")
             ("“" . "”"))))
      (evil-textobj-anyblock--make-textobj beg end type count t)))
;; Allow multiple paste
(defun evil-paste-after-from-0 ()
  (interactive)
  (let ((evil-this-register ?0))
    (call-interactively 'evil-paste-after)))
(define-key evil-visual-state-map "p" 'evil-paste-after-from-0)

  (define-key evil-inner-text-objects-map "q" 'my-evil-textobj-anyblock-inner-quote)
  (define-key evil-outer-text-objects-map "q" 'my-evil-textobj-anyblock-a-quote)
  ;; Include _ in words.
  (add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
;; Limit the length of visual mode.
(add-hook 'visual-line-mode-hook #'visual-fill-column-mode)
(setq visual-fill-column-width 100)
(setq evil-split-window-below t
      evil-vsplit-window-right t)
)

(setq-hook! org-mode
  calendar-week-start-day 1
  org-agenda-block-separator (string-to-char "")
  org-agenda-breadcrumbs-separator " ❱ "
  org-agenda-compact-blocks t
  org-agenda-files (list "~/org/inbox.org"
                         "~/org/work.org"
                         "~/org/projects.org"
                         "~/org/chores.org"
                         "~/org/notes.org"
                         "~/org/home.org")
  ;; org-caldav-calendar-id "ovuticv96133cisuc0pm8f7d6g@group.calendar.google.com"
  ;; org-caldav-files '("~/Notes/appointments.org")
  ;; org-caldav-inbox "~/Notes/calendar-inbox.org"
  ;; org-caldav-oauth2-client-id "279358326453-ar2bfnerndjnnie90e59i9otuif9ut84.apps.googleusercontent.com"
  ;; org-caldav-oauth2-client-secret "SECRET"
  ;; org-caldav-url 'google
  org-clock-into-drawer t
  org-clock-persist t
  org-columns-default-format "%60ITEM(Task) %20TODO %10Effort(Effort){:} %10CLOCKSUM"
  org-confirm-babel-evaluate nil
  org-duration-format '((special . h:mm))
  org-ellipsis "…"
  org-fontify-done-headline t
  org-fontify-quote-and-verse-blocks t
  org-fontify-whole-heading-line t
  org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
                                ("STYLE_ALL" . "habit")))
  org-hide-emphasis-markers t
  org-icalendar-timezone "Europe/Oslo"
  org-image-actual-width '(700)
  org-log-done t
  org-modules (quote (org-protocol))
  org-refile-targets '((org-agenda-files :maxlevel . 2))
  org-time-clocksum-format (quote (:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))
  org-todo-keywords '((sequence "TODO(t!)" "WAITING(w!)" "INPROGRESS(p!)"  "|" "DONE(d!) OBSOLETE(o!)") (sequence "IDEA(i!)" "MAYBE(y!)" "STAGED(s!)" "WORKING(k!)" "|" "USED(u!/@)"))
  )

;; Org mode
(after! org
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

  (customize-set-value
    'org-agenda-category-icon-alist
    `(
      ("work" ,(list (all-the-icons-material "work" :height 1.2)) nil nil :ascent center)
      ("chore" ,(list (all-the-icons-material "repeat" :height 1.2)) nil nil :ascent center)
      ("events" ,(list (all-the-icons-faicon "calendar" :height 1.2)) nil nil :ascent center)
      ("inbox" ,(list (all-the-icons-material "check_box" :height 1.2)) nil nil :ascent center)
      ("blog" ,(list (all-the-icons-material "rss_feed" :height 1.2)) nil nil :ascent center)
      ("home" ,(list (all-the-icons-material "home" :height 1.2)) nil nil :ascent center)
      ("cooking" ,(list (all-the-icons-material "kitchen" :height 1.2)) nil nil :ascent center)
     ))
  (setq org-agenda-format-date 'my-org-agenda-format-date-aligned)
  (defun my-org-agenda-format-date-aligned (date)
  "Format a DATE string for display in the daily/weekly agenda, or timeline.
This function makes sure that dates are aligned for easy reading."
  (require 'cal-iso)
  (let* ((dayname (calendar-day-name date 1 nil))
         (day (cadr date))
         (day-of-week (calendar-day-of-week date))
         (month (car date))
         (monthname (calendar-month-name month 1))
         (year (nth 2 date))
         (iso-week (org-days-to-iso-week
                    (calendar-absolute-from-gregorian date)))
         (weekyear (cond ((and (= month 1) (>= iso-week 52))
                          (1- year))
                         ((and (= month 12) (<= iso-week 1))
                          (1+ year))
                         (t year)))
         (weekstring (if (= day-of-week 1)
                         (format " W%02d" iso-week)
                       "")))
         (format "%-2s. %2d %s"
            dayname day monthname)))

(setq org-agenda-custom-commands
      '(("o" "My Agenda"
         ((todo "INPROGRESS" (
                      (org-agenda-overriding-header "\n⚡ in progress:\n⎺⎺⎺⎺⎺⎺⎺⎺⎺")
                      (org-agenda-remove-tags t)
                      (org-agenda-prefix-format " %-2i %-15b")
                      (org-agenda-todo-keyword-format "")
                       ))
          (agenda "" (
                      (org-agenda-start-day "+0d")
                      (org-agenda-span 5)
                      (org-agenda-overriding-header "⚡ Schedule:\n⎺⎺⎺⎺⎺⎺⎺⎺⎺")
                      (org-agenda-repeating-timestamp-show-all nil)
                      (org-agenda-remove-tags t)
                      (org-agenda-prefix-format   "  %-3i  %-15b %t%s")
                      (org-agenda-todo-keyword-format " ☐ ")
                      (org-agenda-current-time-string "⮜┈┈┈┈┈┈┈ now")
                      (org-agenda-scheduled-leaders '("" ""))
                      (org-agenda-time-grid (quote ((daily today remove-match)
                                                    (0900 1200 1500 1800 2100)
                                                    "      " "┈┈┈┈┈┈┈┈┈┈┈┈┈")))
                       ))
          ))))

  (add-hook 'org-agenda-finalize-hook #'set-window-clean)
  (defun set-window-clean ()
    (interactive)
    (setq mode-line-format nil)
    (set-frame-parameter nil 'font "JetbrainsMono Nerd Font-16")
    (set-window-margins (frame-selected-window) 4))

  )


;; Cloudformation
(define-derived-mode cfn-mode yaml-mode
  "Cloudformation"
  "Cloudformation template mode.")

(add-to-list 'auto-mode-alist '("service\.yml\\'" . cfn-mode))
(after! flycheck
  (flycheck-define-checker cfn-lint
    "A Cloudformation linter using cfn-python-lint.

See URL 'https://github.com/awslabs/cfn-python-lint'."
    :command ("cfn-lint" "-f" "parseable" source)
    :error-patterns (
                     (warning line-start (file-name) ":" line ":" column
                              ":" (one-or-more digit) ":" (one-or-more digit) ":"
                              (id "W" (one-or-more digit)) ":" (message) line-end)
                     (error line-start (file-name) ":" line ":" column
                            ":" (one-or-more digit) ":" (one-or-more digit) ":"
                            (id "E" (one-or-more digit)) ":" (message) line-end)
                     )
    :modes (cfn-mode)
    )
    (add-to-list 'flycheck-checkers 'cfn-lint)
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
;;     ;; Populates only the EXPORT_FILE_NAME property in the inserted headline.
;;

(after! org
  (defun org-hugo-new-subtree-post-capture-template ()
    "Returns `org-capture' template string for new Hugo post.
See `org-capture-templates' for more information."
    (let* ((title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
           (fname (org-hugo-slug title))
           (slug (concat (format-time-string "%Y-%m-%d") "-" fname)))
      (mapconcat #'identity
                 `(
                   ,(concat "* TODO " title)
                   ":PROPERTIES:"
                   ,(concat ":EXPORT_FILE_NAME: " slug)
                   ":END:"
                   "%?\n")          ;Place the cursor here finally
                 "\n")))

  (add-to-list 'org-capture-templates
               '("h"                ;`org-capture' binding + h
                 "Hugo post"
                 entry
                 (file+olp "blog.org" "Posts")
                 (function org-hugo-new-subtree-post-capture-template)))

  (defun org-hugo-new-subtree-link-capture-template ()
    "Returns `org-capture' template string for new Hugo post.
See `org-capture-templates' for more information."
    (let* ((title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
           (link (read-from-minibuffer "Post Link: ")) ;Prompt to enter the post link
           (fname (org-hugo-slug title))
           (slug (concat (format-time-string "%Y-%m-%d") "-" fname)))
      (mapconcat #'identity
                 `(
                   ,(concat "* TODO "  title)
                   ":PROPERTIES:"
                   ,(concat ":EXPORT_FILE_NAME: " slug)
                   ,(concat ":EXPORT_HUGO_CUSTOM_FRONT_MATTER: :externalUrl " link)
                   ":END:"
                   "%?\n")          ;Place the cursor here finally
                 "\n")))

  (add-to-list 'org-capture-templates
               '("H"                ;`org-capture' binding + H
                 "Hugo link"
                 entry
                 (file+olp "blog.org" "Links")
                 (function org-hugo-new-subtree-link-capture-template))))


;;(setq mac-option-key-is-meta nil
;;      mac-command-key-is-meta t
;;      mac-command-modifier 'meta
;;      mac-option-modifier 'none)

(setq mac-option-key-is-meta t)
(setq mac-right-option-modifier nil)

(after! lsp
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("/Users/marcus/Downloads/terraform-ls" "serve"))
                    :major-modes '(terraform-mode)
                    :server-id 'terraform-ls))
  (make-lsp-client :new-connection (lsp-stdio-connection '("perl" "-M Perl::LanguageServer"))
                    :major-modes '(cperl-mode)
                    :server-id 'perl-ls)
  (add-hook 'terraform-mode-hook #'lsp))

(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-plus-contrib lsp-origami cheat-sh jenkins-watch elscreen jenkins)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq jenkins-api-token "invalid"
      jenkins-url "https://jenkins.tech.dnb.no/jenkinsssl/"
      jenkins-username "marcus.ramberg"
      jenkins-viewname "Favorites") ;; if you're not using views skip this line
;;
;; Perl
(defalias 'perl-mode 'cperl-mode)
(setq flycheck-perlcritic-theme "freenode"
      cperl-electric-keywords t)

(defun zakame/reply-sentinel (process event)
  (if (memq (process-status process) '(signal exit))
      (let ((buffer (process-buffer process)))
        (kill-buffer buffer))))
(defadvice run-reply (around reply-set-process-sentinel activate)
  ad-do-it
  (set-process-sentinel (get-process "reply") 'zakame/reply-sentinel))
(ad-activate 'run-reply)
(defun reply-other-window ()
  "Run `reply' on other window."
  (interactive)
  (switch-to-buffer-other-window (get-buffer-create "*reply*"))
  (run-reply "reply"))
(after! helm-perldoc
  (helm-perldoc:setup))

  (map! (:localleader  ; Use local leader
         (:map (cperl-mode-map)
          (:prefix ("r" . "repl")
          "r" #'run-reply ; Add which-key description
          "s" #'reply-send-region
          "o" #'reply-other-window)
          (:prefix ("t" . "tidy")
          "r" #'perltidy-region
          "b" #'perltidy-buffer
          "s" #'perltidy-subroutine
          "t" #'perltidy-dwim-safe)
          "p" #'helm-perldoc
        )))

(after! company-ctags
  (add-to-list 'company-backends 'company-ctags)
  (add-hook 'cperl-mode-hook 'company-mode))

(set-email-account! "marcus.ramberg"
  '((mu4e-sent-folder       . "/Lissner.net/Sent Mail")
    (mu4e-drafts-folder     . "/Lissner.net/Drafts")
    (mu4e-trash-folder      . "/Lissner.net/Trash")
    (mu4e-refile-folder     . "/Lissner.net/All Mail")
    (smtpmail-smtp-user     . "henrik@lissner.net")
    (user-mail-address      . "henrik@lissner.net")    ;; only needed for mu < 1.4
    (mu4e-compose-signature . "---\nHenrik Lissner"))
  t)


(after! slack
  (setq slack-buffer-emojify t) ;; if you want to enable emoji, default nil
  (setq slack-prefer-current-team t)
  (slack-register-team
        :name "dnb"
        :token (auth-source-pick-first-password
                :host "dnb-it.slack.com"
                :user "marcus.ramberg@dnb.no")
        :subscribed-channels '((apitribe apitribe-private)))
  (evil-define-key 'normal slack-info-mode-map
    ",u" 'slack-room-update-messages)
  (evil-define-key 'normal slack-mode-map
    ",c" 'slack-buffer-kill
    ",ra" 'slack-message-add-reaction
    ",rr" 'slack-message-remove-reaction
    ",rs" 'slack-message-show-reaction-users
    ",pl" 'slack-room-pins-list
    ",pa" 'slack-message-pins-add
    ",pr" 'slack-message-pins-remove
    ",mm" 'slack-message-write-another-buffer
    ",me" 'slack-message-edit
    ",md" 'slack-message-delete
    ",u" 'slack-room-update-messages
    ",2" 'slack-message-embed-mention
    ",3" 'slack-message-embed-channel
    "\C-n" 'slack-buffer-goto-next-message
    "\C-p" 'slack-buffer-goto-prev-message)
   (evil-define-key 'normal slack-edit-message-mode-map
    ",k" 'slack-message-cancel-edit
    ",s" 'slack-message-send-from-buffer
    ",2" 'slack-message-embed-mention
    ",3" 'slack-message-embed-channel))
;; Autoload jq.
(add-to-list 'auto-mode-alist '("\\.jq$" . jq-mode))
