(add-to-list 'load-path (format "%s/elisp" (file-name-directory doom-user-dir)))

(setq doom-theme 'doom-zenburn)

(require 'shy-core)
(require 'shy-elfeed)
(require 'shy-gnus)
(require 'shy-magit)
(require 'shy-org)
(require 'shy-tramp-mode)
(require 'shy-erc)

(use-package! direnv
  :config
  (direnv-mode))
