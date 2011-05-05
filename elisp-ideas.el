;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; File path:     /share/elisp/elisp-ideas.el
;; Version:       
;; Description:   Just foolin around...
;; Author:        Rick Charon <rickcharon@gmail.com>
;; Created at:    Mon Nov 15 19:06:25 2010
;; Modified at:   Thu Jan  6 16:42:46 2011
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun dummy2()
  (interactive)
  (insert 
   (eval (car (cdr (cdr '("filepath" "File path:" (buffer-file-name))))))))

(defun dummy()
  (interactive)
  (insert 
   (eval (car (cdr (cdr '("filepath" "File path:" (header-get-filepath))))))))

(buffer-file-name)
(mapcar 'header-insert-field header-field-list)
(header-insert-field 'filepath)
(completing-read "Field: " header-fields)

;; * Mon Oct 25 13:53:06 2010 rpc - Going to put generally useful ideas here,

;;This could be a handy debug tool, put a message in existing code to print out
;;variable values.


;;Really cool use of ido stuff!
(defun interact1 ()
  (interactive)
  (setq mylist (list "red" "blue" "yellow" "clear" "i-dont-know"))
  (let ((colorchoice (ido-completing-read "What, ... is your favorite color? " mylist)))
    (cond ((equalp colorchoice "red") (message "You chose red"))
          ((equalp colorchoice "blue") (message "You chose blue"))
          ((equalp colorchoice "yellow") (message "You chose yellow")))))




(let ((zebra 'stripes)
      (tiger 'fierce))
  (message "One kind of animal has %s and another is %s."
           zebra tiger))


(shell-command "ls" t) ;;This will put output right here



;; From http://nflath.com/
;; org-mode hacks
;;Checkout the latest version of org mode, if I don't already have it.
(unless (file-exists-p "~/.emacs.d/elisp/org-mode/")
  (let ((default-directory "~/.emacs.d/elisp/"))
    (shell-command "git clone git://repo.or.cz/org-mode.git")
    (shell-command "make -C org-mode/")
    (normal-top-level-add-subdirs-to-load-path)))
(add-to-list 'load-path "~/.emacs.d/elisp/org-mode/lisp/")
(add-to-list 'load-path "~/.emacs.d/elisp/org-mode/contrib/lisp/")
(require 'org-install)


(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d!)")
        (sequence "|" "CANCELED(c@/!)")
        (sequence "|" "STALLED(s@/!)")
        (sequence "FUTURE(f)" "|")
        (sequence "PENDING(p@/!)" "|" )))
(setq org-todo-keyword-faces
      '(("CANCELED"  . (:foreground "blue" :weight bold))
        ("STALLED"  . (:foreground "RED" :weight bold))
        ("FUTURE" . (:foreground "dark green" :weight bold))
        ("PENDING"  . (:foreground "orange" :weight bold))))

(defun bh/insert-inactive-timestamp ()
  "Insert a timestamp for the current time at point."
  (interactive)
  (save-excursion
    (insert "\n")
    (org-cycle)
    (org-insert-time-stamp nil t t nil nil nil)))

(define-key org-mode-map (kbd "<left>") 'org-promote-subtree)
(define-key org-mode-map (kbd "C-t") 'org-todo)
(define-key org-mode-map (kbd "<right>") 'org-demote-subtree)
(global-set-key (kbd "C-c i") 'bh/insert-inactive-timestamp)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cl" 'org-store-link)
(define-key global-map "\C-cr" 'org-remember)

(setq org-habit-graph-column 60)
(add-to-list 'org-modules 'org-habit)


(defun testit()
  (interactive)
  (insert (substring (buffer-file-name) 1)))


(defun append-to-buffer (buffer start end)
  "Append to specified buffer the text of the region.
It is inserted into that buffer before its point.
When calling from a program, give three arguments:
BUFFER (or buffer name), START and END.
START and END specify the portion of the current buffer to be copied."
  (interactive
   (list (read-buffer "Append to buffer: " (other-buffer (current-buffer) t))
         (region-beginning) (region-end)))
    (let ((oldbuf (current-buffer)))
      (save-excursion
        (let* ((append-to (get-buffer-create buffer))
               (windows (get-buffer-window-list append-to t t))
               point)
          (set-buffer append-to)
          (setq point (point))
          (barf-if-buffer-read-only)
          (insert-buffer-substring oldbuf start end)
          (dolist (window windows)
            (when (= (window-point window) point)
              (set-window-point window (point))))))))

(defun foo (arg buf)
  "Doc string"
  (interactive "Ffile:\nBbuffer: ")
   (if arg (insert arg))
   (insert "\t")
   (insert buf)) ;; output, /share/elisp/pond_do	*Help*, file pond_do, *Help* was prev visited buffer,


(defun foo (arg buf)
  "Doc string"
  (interactive "Ffile:\nPbuffer: ")
   (if arg (insert arg) (insert "no arg"))
   (insert "\t")
   (if buf (insert buf) (insert "no buf")))
;; with C-u 65 - /share/elisp/pond_do	A
;; with no C-u arg - /share/elisp/pond_do	no buf

(defun foo (file buf)
  "Doc string"
  (interactive "Ffile:\nbbuffer: ")
  (if file (insert file) (insert "no file"))
  (if buf (insert buf) (insert "no buf")))
;; Small "b" gives current buffer, "B" gives prev buffer /share/elisp/pond_doelisp-ideas.el







