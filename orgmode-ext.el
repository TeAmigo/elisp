;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; File path:     /share/elisp/orgmode-ext.el
;; Version:       0.01
;; Description:   Add some  personal likes and extensionsto org-mode
;; Author:        Rick Charon <rickcharon@gmail.com>
;; Created at:    Fri Nov  5 18:22:21 2010
;; Modified at:   Tue May  3 14:29:03 2011
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

;;General stuff.
(setq org-agenda-include-diary t)
(setq org-hide-leading-stars t)
(setq org-odd-levels-only t)
(setq org-log-done t)
(require 'org-publish)

(setq org-publish-project-alist
      '(
        ("practice-notes"
         :base-directory "/share/mywebsites/practice/"
         :auto-sitemap t
         :base-extension "org"
         :index-filename "index.org"
         :index-title "Index"
         :publishing-directory "/share/mywebsites/practice/html/"
         :recursive t
         :num nil
         :publishing-function org-publish-org-to-html
         :headline-levels 6            ; Just the default for this project.
         :auto-preamble t
         :author "TeAmigo"
         
         )
        ("practice-static"
         :base-directory "/share/mywebsites/practice/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "/share/mywebsites/practice/html/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("practice" :components ("practice-notes" "practice-static"))
    
      ("B-inherit"
       :base-directory "~/org/"
       :recursive t
       :base-extension "css\\|js"
       :publishing-directory "~/public_html/B/"
       :publishing-function org-publish-attachment
       )

      ("B-org"
       :base-directory "~/B/"
       :auto-index t
       :index-filename "sitemap.org"
       :index-title "Sitemap"
       :recursive t
       :base-extension "org"
       :publishing-directory "~/public_html/B/"
       :publishing-function org-publish-org-to-html
       :headline-levels 3
       :auto-preamble t
       )
      ("B-static"
       :base-directory "~/B/"
       :recursive t
       :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
       :publishing-directory "~/public_html/B/"
       :publishing-function org-publish-attachment)

      ("B" :components ("B-inherit" "B-org" "B-static"))))


(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

;; <2010-11-15 Mon 10:53> rpc - This is a customized var, so is in list in .emacs
;; customizations, don't want to clobber it, see info:org mode: agenda files for ways to change
;; (setq org-agenda-files  (list "/share/notes/notes-orgmode"
;;                              "/share/notes/notes-emacs" 
;;                              "/share/notes/notes-elisp"
;;                              "/share/notes/notes-ruby"
;;                              "/share/notes/notes-petrasys"
;;                              "/share/notes/notes-sage"
;;                              "/share/notes/notes-conkeror"
;;                              "/share/notes/notes-YogaOfTheMystical"
;;                              "/share/notes/notes-trading"
;;                              "/share/notes/notes-charonenterprises"
;;                              "/share/notes/notes-undertakings"
;;                              "/share/notes/notes-postgresql"
;;                              "/share/notes/notes-household"))


;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "IN-PROGRESS(i)" "|" "DONE(d)")
;;         (sequence "|" "CANCELED(c)")
;;         (sequence "FUTURE(f)" "|")
;;         (sequence "NOTE(n)" "|" )
;;         (sequence "COMMAND(o)" "|" )
;;         (sequence "REFERENCE(q)" "|" )        
;;         (sequence "CONTEMPLATION(m)" "PREPAREANDOPTIMIZE(p)" "WRITE(w)" "ENGAGE(e)" "RECORD(r)" "|")))
;; (setq org-todo-keyword-faces
;;       '(("CANCELED"  . (:foreground "blue" :weight bold))
;;         ("FUTURE" . (:foreground "dark green" :weight bold))
;;         ("CONTEMPLATION" . (:foreground "deep sky blue" :weight bold))
;;         ("REFERENCE" . (:foreground "blue violet" :weight bold))        
;;         ("NOTE"  . (:foreground "orange" :weight bold))))



(defun inactive-timestamp ()
  "Insert a timestamp for the current time at point."
  (interactive)
  (save-excursion
    (org-insert-time-stamp nil t t nil nil nil)))

(defun active-timestamp ()
  "Insert a timestamp for the current time at point."
  (interactive)
  (save-excursion
    (org-insert-time-stamp nil t nil nil nil nil)))

(add-hook 'org-after-todo-state-change-hook
          (lambda ()
            (unless (or (string= state "DONE")
                        (string= state "CANCELED"))
              ;;(org-return-indent)
              (let ((str1 "- " )) ;;(concat "@" (downcase state))))
                (insert str1)
                (active-timestamp)
                ;;(previous-line)
                (end-of-line)
                (insert " - ")))))

(defun org-todo2 (&optional arg)
  "Calls org-todo, but the hook 'org-after-todo-state-change-hook'
isn't able to set the cursor to end-of-line, so need this."
  (interactive "P")
  (org-todo arg)
  (end-of-line))


