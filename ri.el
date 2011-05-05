;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; File path:     ri.el
;; Version:       0.1
;; Description:   Runs the Ruby ri program defaulting to symbol around cursor for input
;;                Some code excerpted from Phil Hagelberg's ri.el, and also from eshell.el
;;                as mentioned below,
;; Author:        Rick Charon <rickcharon@gmail.com>
;; Created at:    Sun Sep 19 11:50:41 2010
;; Modified at:   Sun Sep 19 13:28:53 2010
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


(defun ri()
  (interactive)
  (ri-command (get-ri-input)))

(defun get-ri-input()
  (interactive)
  (let ((ri-sym (read-from-minibuffer "RI: " (ri-symbol-at-point))))
    (concat "ri -T " ri-sym)))

(defun ri-symbol-at-point ()
  (interactive)
  (let ((ri-symbol (symbol-at-point)))
    (setq sap ri-symbol)
    (if ri-symbol
        (symbol-name ri-symbol)
      "")))

(defun ri-command (command)
  "* Thu Sep 16 09:36:39 2010 rpc -
Lifted (and butchered ala Dexter) from /usr/share/emacs/23.1/lisp/eshell/eshell.el::eshell-command
Execute the Eshell command string COMMAND.
With prefix ARG, insert output into the current buffer at point."
  (require 'esh-cmd)

  ;; redirection into the current buffer is achieved by adding an
  ;; output redirection to the end of the command, of the form
  ;; 'COMMAND >>> #<buffer BUFFER>'.  This will not interfere with
  ;; other redirections, since multiple redirections merely cause the
  ;; output to be copied to multiple target locations

  (save-excursion
    (let ((buf (set-buffer (generate-new-buffer " *eshell cmd*")))
          (eshell-non-interactive-p t))
      (eshell-mode)
      (let* ((proc (eshell-eval-command
                    (list 'eshell-commands
                          (eshell-parse-command command))))
             intr
             (bufname (if (and proc (listp proc))
                          "*EShell Async Command Output*"
                        (setq intr t)
                        (concat "**" command "**"))))
        (if (buffer-live-p (get-buffer bufname))
            (kill-buffer bufname))
        (rename-buffer bufname)
        ;; things get a little coarse here, since the desire is to
        ;; make the output as attractive as possible, with no
        ;; extraneous newlines
        (when intr
          (if (eshell-interactive-process)
              (eshell-wait-for-process (eshell-interactive-process)))
          (assert (not (eshell-interactive-process)))
          (goto-char (point-max))
          (while (and (bolp) (not (bobp)))
            (delete-backward-char 1)))
        (assert (and buf (buffer-live-p buf)))
        
        (let ((len (if (not intr) 2
                     (count-lines (point-min) (point-max)))))
          (cond
           ((= len 0)
            (message "(There was no command output)")
            (kill-buffer buf))
           ((= len 1)
            (message "%s" (buffer-string))
            (kill-buffer buf))
           (t
            (save-selected-window
              (select-window (display-buffer buf))
              (goto-char (point-min))
              ;; cause the output buffer to take up as little screen
              ;; real-estate as possible, if temp buffer resizing is
              ;; enabled
              (and intr temp-buffer-resize-mode
                   (resize-temp-buffer-window))))))))))

