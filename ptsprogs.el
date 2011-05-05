;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; File path:     /share/elisp/ptsprogs.el
;; Version:       
;; Description:   Run the Perfect Trader System programs in Eshell buffer
;;                PtsCharts ->     java -jar /share/JavaDev/ptscharts/dist/ptscharts.jar
;;                PtsUpdater ->    java -jar /share/JavaDev/ptsupdater/dist/ptsupdater.jar
;; Author:        Rick Charon <rickcharon@gmail.com>
;; Created at:    Thu Jan 20 15:01:31 2011
;; Modified at:   Fri Feb  4 17:03:08 2011
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defgroup ptsprogs nil
  "This group consists of ptscharts and ptsupdater, both run java
programs for my trading <2011-02-03 Thu 18:13> Rick"
  :group 'applications)

(defvar ptscharts-buffer-name)
(defsubst ptscharts-add-to-window-buffer-names ()
  "Add `eshell-buffer-name' to `same-window-buffer-names'."
  (add-to-list 'same-window-buffer-names ptscharts-buffer-name))

(defsubst ptscharts-remove-from-window-buffer-names ()
  "Remove `ptscharts-buffer-name' from `same-window-buffer-names'."
  (setq same-window-buffer-names
        (delete ptscharts-buffer-name same-window-buffer-names)))

(defcustom ptscharts-buffer-name "*PtsCharts*"
  "The basename used for Eshell buffers."
  :set (lambda (symbol value)
	 ;; remove the old value of `ptscharts-buffer-name', if present
	 (if (boundp 'ptscharts-buffer-name)
	     (ptscharts-remove-from-window-buffer-names))
	 (set symbol value)
	 ;; add the new value
	 (ptscharts-add-to-window-buffer-names)
	 value)
  :type 'string
  :group 'ptsprogs)


(defvar ptsupdater-buffer-name)
(defsubst ptsupdater-add-to-window-buffer-names ()
  "Add `eshell-buffer-name' to `same-window-buffer-names'."
  (add-to-list 'same-window-buffer-names ptsupdater-buffer-name))

(defsubst ptsupdater-remove-from-window-buffer-names ()
  "Remove `ptsupdater-buffer-name' from `same-window-buffer-names'."
  (setq same-window-buffer-names
        (delete ptsupdater-buffer-name same-window-buffer-names)))


(defcustom ptsupdater-buffer-name "*PtsUpdater*"
  "The basename used for Eshell buffers."
  :set (lambda (symbol value)
	 ;; remove the old value of `ptsupdater-buffer-name', if present
	 (if (boundp 'ptsupdater-buffer-name)
	     (ptsupdater-remove-from-window-buffer-names))
	 (set symbol value)
	 ;; add the new value
	 (ptsupdater-add-to-window-buffer-names)
	 value)
  :type 'string
  :group 'ptsprogs)

(defun ptscharts()
  "Insert text of current line in eshell and execute."
  (interactive)
  (require 'eshell)
  (let ((buf (get-buffer-create ptscharts-buffer-name)))
    ;; Simply calling `pop-to-buffer' will not mimic the way that
    ;; shell-mode buffers appear, since they always reuse the same
    ;; window that that command was invoked from.  To achieve this,
    ;; it's necessary to add the buffer name to the variable
    ;; `same-window-buffer-names', which is done when ? is loaded
    (assert (and buf (buffer-live-p buf)))
    (pop-to-buffer buf)
    (unless (eq major-mode 'eshell-mode)
      (eshell-mode)))
  (end-of-buffer)
  (eshell-kill-input)
  (insert "java -jar /share/JavaDev/ptscharts/dist/ptscharts.jar")
  (eshell-send-input)
  (end-of-buffer))
  ;;(switch-to-buffer-other-window buf))




(defun ptsupdater ()
  "Insert text of current line in eshell and execute."
  (interactive)
  (require 'eshell)
  (let ((buf (get-buffer-create "*PtsUpdater*")))
    ;; Simply calling `pop-to-buffer' will not mimic the way that
    ;; shell-mode buffers appear, since they always reuse the same
    ;; window that that command was invoked from.  To achieve this,
    ;; it's necessary to add the buffer name to the variable
    ;; `same-window-buffer-names', which is done when ? is loaded
    (assert (and buf (buffer-live-p buf)))
    (pop-to-buffer buf)
    (unless (eq major-mode 'eshell-mode)
      (eshell-mode)))
  (end-of-buffer)
  (eshell-kill-input)
  (insert "java -jar /share/JavaDev/ptsupdater/dist/ptsupdater.jar")
  (eshell-send-input)
  (end-of-buffer))
;;  (switch-to-buffer-other-window buf))

;; (defun ptsupdater ()
;;   "Insert text of current line in eshell and execute."
;;   (interactive)
;;   (require 'eshell)
;;   (let ((buf (current-buffer)))
;;     (eshell)
;;     (rename-buffer "*PtsUpdater*")
;;     (display-buffer "*PtsUpdater*" t)
;;     (switch-to-buffer-other-window "*PtsUpdater*")
;;     (end-of-buffer)
;;     (eshell-kill-input)
;;     (insert "java -jar /share/JavaDev/ptsupdater/dist/ptsupdater.jar")
;;     (eshell-send-input)
;;     (end-of-buffer)
;;     (switch-to-buffer-other-window buf)))


;; (defun ptscharts-orig ()
;;   "Insert text of current line in eshell and execute."
;;   (interactive)
;;   (require 'eshell)
;;   (let ((buf (current-buffer)))
;;     (eshell)
;;     (rename-buffer "*PtsCharts*")
;;     (display-buffer "*PtsCharts*" t)
;;     (switch-to-buffer-other-window "*PtsCharts*")
;;     (end-of-buffer)
;;     (eshell-kill-input)
;;     (insert "java -jar /share/JavaDev/ptscharts/dist/ptscharts.jar")
;;     (eshell-send-input)
;;     (end-of-buffer)
;;     (switch-to-buffer-other-window buf)))
