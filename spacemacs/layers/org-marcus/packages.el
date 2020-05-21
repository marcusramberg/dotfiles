(defconst org-marcus-packages
  '(
    org-chef
    org-roam
    ))


(defun org-marcus/init-org-chef ()
  (use-package org-chef
    ))

(defun org-marcus/init-org-roam ()
  (use-package org-roam
    :hook
    (after-init . org-roam-mode)
    :custom
    (org-roam-directory "~/org")
    :bind (:map org-roam-mode-map
                (("C-c n l" . org-roam)
                 ("C-c n f" . org-roam-find-file)
                 ("C-c n g" . org-roam-show-graph))
                :map org-mode-map
                (("C-c n i" . org-roam-insert))))
  )
