;;; gnus.el --- GNUS configuration for Emacs
;;; commentary:
;;; code:

(setq-default gnus-save-newsrc-file t
              gnus-read-newsrc-file t 
              gnus-read-active-file t)

(use-package gnus
  :config
  (setq gnus-select-method '(nnnil "")
        nntp-authinfo-file (expand-file-name "~/.local/state/doom/nix/authinfo.gpg")
        nnimap-authinfo-file (expand-file-name "~/.local/state/doom/nix/authinfo.gpg")
        smtpmail-auth-credentials nil
        gnus-secondary-select-methods
        '(
          (nnimap "dominic.rodriguez@rodriguez.org.uk"
                  (nnimap-address "127.0.0.1")
                  (nnimap-server-port 143)
                  (nnimap-user "dominic.rodriguez@rodriguez.org.uk")
                  (nnimap-stream plain))
          (nnimap "shymega@shymega.org.uk"
                  (nnimap-stream plain)
                  (nnimap-address "127.0.0.1")
                  (nnimap-server-port 143)
                  (nnimap-user "shymega@shymega.org.uk"))
          (nntp "nntp-shymega"
                (nntp-port-number 1119)
                (nntp-address "127.0.0.1"))
          (nnimap "rnet@rodriguez.org.uk"
                  (nnimap-stream plain)
                  (nnimap-server-port 143)
                  (nnimap-user "rnet@rodriguez.org.uk")
                  (nnimap-address "127.0.0.1")))))

(setq mm-text-html-renderer 'w3m)

(setq gnus-use-cache t)

(defun get-sig-from-mutt (acc)
  "Return account's signature specifed by ACC in $HOME/.mutt/accounts/%s.sig."
  (with-temp-buffer
    (insert-file-contents
     (expand-file-name (format "%s/.config/neomutt/conf.d/accounts.d/%s.sig"
                               (getenv "HOME") acc)))
    (buffer-string)))

(setq gnus-posting-styles
      '(("dominic.rodriguez@rodriguez.org.uk"
         (signature (get-sig-from-mutt "dominic.rodriguez@rodriguez.org.uk"))
         (name "Dom Rodriguez")
         (address "dominic.rodriguez@rodriguez.org.uk"))
        ("rnet@rodriguez.org.uk"
         (signature (get-sig-from-mutt "rnet@rodriguez.org.uk"))
         (name "RNET Administrators")
         (address "rnet@rodriguez.org.uk"))
        ("shymega@shymega.org.uk"
         (signature (get-sig-from-mutt "shymega@shymega.org.uk"))
         (name "Dom Rodriguez")
         (address "shymega@shymega.org.uk"))
        ("nntp-shymega"
         (signature (get-sig-from-mutt "shymega@shymega.org.uk"))
         (name "Dom Rodriguez")
         (address "shymega@shymega.org.uk"))))

(setq mm-discouraged-alternatives '("text/html" "text/richtext"))

(setq gnus-read-active-file 'some)

(setq gnus-summary-thread-gathering-function 'gnus-gather-threads-by-subject)

(setq gnus-thread-hide-subtree t)
(setq gnus-thread-ignore-subject t)

(setq gnus-use-correct-string-widths nil)

(setq gnus-thread-sort-functions
      '((not gnus-thread-sort-by-date)
        (not gnus-thread-sort-by-number)))

;;; send emails with msmtp-enqueue
;;; I've set up a script to perform checks on the queue and deal with them as needed, depending on connectivity.

(setq smtpmail-default-smtp-server "127.0.0.1")

(setq message-send-mail-function 'message-send-mail-with-sendmail
      mail-specify-envelope-from t
      message-sendmail-f-is-evil nil
      mail-envelope-from 'header
      message-sendmail-envelope-from 'header)

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(setq gnus-topic-topology '(("Gnus" visible)
                            (("dominic.rodriguez@rodriguez.org.uk" visible nil nil))
                            (("shymega@shymega.org.uk" visible nil nil))
                            (("rnet@rodriguez.org.uk" visible nil nil))))

(provide 'shy-gnus)
;;; gnus.el ends here
