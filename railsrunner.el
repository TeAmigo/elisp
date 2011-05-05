;; /*                             -***-   /share/elisp/railsrunner.el  -***-

;;  * * Tue Sep 14 03:58:55 2010 rpc - 
;;  * This is help for running Ruby Rails, rinari already does a lot, but has problems
;;  * with some things,
;; */

(require 'eshell)

(defcustom rails-root
  "/share/ruby/RailsProjects/demo_app"
  "Path to Rails project root directory."
  :group 'railsrunner)

;; * Tue Oct 19 15:34:08 2010 rpc - Changing to use regular shell, eshell is not aware of
;;   full environment,
;; (defun rails-server()
;;   "Start up the rails server in an eshell."
;;   (interactive)
;;   (shell "*Rails Server*")
;;   (insert "cd ")
;;   (insert rails-root)
;;   (comint-send-input)
;;   ;;(shell-cd rails-root)
;;   (insert "rails server")
;;   (comint-send-input))

;;Works with rails 3.0, but not 2.3
(defun rails-server()
  "Start up the rails server in an eshell."
  (interactive)
  (setq oldbufname eshell-buffer-name)
  (setq eshell-buffer-name "*Rails Server*")
  (setq old-buf (current-buffer))
  (eshell)
  (cd rails-root)
  (insert "rails server")
  (eshell-send-input)
  (setq eshell-buffer-name oldbufname))



