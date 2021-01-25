;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; Cooking with org mode :)
(package! org-chef
  :recipe (:host github :repo "Chobbes/org-chef"))

(package! terraform-doc)
(package! jsonnet-mode)

(package! jenkinsfile-mode
  :recipe (:host github :repo "john2x/jenkinsfile-mode"
           :files ("jenkinsfile-mode.el")))

(package! visual-fill-column)
(package! jenkins)
(package! cheat-sh)

;; Screencasts
(package! keycast)
(package! gif-screencast)

;; Perl setup
(package! helm-perldoc)
(package! perltidy
  :recipe (:host github :repo "zakame/perltidy.el"))
;; REPL
(package! reply
  :recipe (:host github :repo "syohex/emacs-reply"))

;;Completion
(package! company-ctags
  :recipe (:host github :repo "redguardtoo/company-ctags"))


(package! slack)

(package! kubernetes)
(package! kubernetes-evil)

(package! jq-mode
  :recipe (:host github :repo "ljos/jq-mode"))

(package! rego-mode)

(package! speed-type)

(package! github-browse-file)
(package! github-review)
