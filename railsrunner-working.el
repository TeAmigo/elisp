;; /*                         -***-   /share/elisp/railsrunner-working.el  -***-
;;    SEE FILE WITHOUT THE WORKING APPENDED for real deal,
;;  * * Tue Sep 14 06:09:51 2010 rpc - 
;;  * This is help for running Ruby Rails, rinari already does a lot, but has problems
;;  * with some things,
;; */

(require 'eshell)

(defcustom rails-root
  "/var/www/railsdemo"
  "Path to Rails project root directory."
  :group 'railsrunner)

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
;;  (cd curdir)
;;  (insert "cd /var/www\r\n")
  (setq eshell-buffer-name oldbufname))

  (insert "ls\n")

(rails-server)

(setq eshell-buffer-name oldbufname)

;;From /usr/share/emacs/23.1/lisp/eshell/esh-mode.el
	(process-send-string (eshell-interactive-process)
			     (concat str "\n"))
(message "Warning: text will be echoed"))))

(with-temp-buffer
    (shell (current-buffer))
    (process-send-string nil "ls")


(defun ri()
  "Run ri in a buffer"
  (interactive)
  (set-variable 'prefix-arg "test")
  (eshell)
  (rename-buffer "**RI OUTPUT**")
  (insert "ri -T respond_to")
  (eshell-send-input)
  (beginning-of-buffer))
(ri)


(eshell-command "ri -T File.open")

(format " >>> #<buffer %s>"
			    (buffer-name (current-buffer)))


(start-process "ri_repl" " *ri-output*" "ri_repl" "\n" "respond_do\n")
(process-send-string "respond_do\n")

(defun ri-get-process ()
  "Return the subprocess, starting it if necessary."
  (or (get-process "ri-repl")
      (start-process "ri-repl" " *ri-output*" "")))
(ri-get-process)
(process-send-string (ri-get-process) "respond_do\n")

(eshell-command "ls")
(car (eshell-command-result "ls"))

(setq foobar (eshell-command-result "date"))
(insert foobar)Wed Sep 15 14:16:49 2010


(let ((riVar (eshell-command-result "ri -T respond_to")))
  (progn (set-buffer (generate-new-buffer "**ri respond_to**"))
         (insert riVar)
         (beginning-of-buffer)
         (switch-to-buffer "**ri respond_to**")))



(current-buffer)
            

(defun ri2 ()
  (interactive)
  (let (
        (oldbuf (current-buffer))
        (foobar (eshell-command-result "ri -T -frdoc respond_to")))
    (set-buffer (generate-new-buffer "**ri respond_to**"))
    (insert foobar)
    (set-buffer oldbuf)))
(ri2)
       

       
(generate-new-buffer "**ri respond_to**")
(insert foobar)

noshell-process-mode
(setq buffer-read-only t)
ri_repl

(defun testarg(cmd)
(let ((command "TT"))
  (concat "**" cmd "**")))
(testarg "dd")

(eshell-command "ri -T File.open")
(ri-command "ri -T File.open")

(defun ri-command (command)
  "* Thu Sep 16 09:36:39 2010 rpc -
Lifted (and butchered) from /usr/share/emacs/23.1/lisp/eshell/eshell.el::eshell-command
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

(defun ri-readin (&optional ri-documented)
  "Look up Ruby documentation."
  (interactive)
  (setq ri-documented (or ri-documented (ri-completing-read))))

(defun ri-completing-read ()
  "Read the name of a Ruby class, module, or method to look up."
  (let (ri-completions-alist) ;; Needs to be dynamically bound.
    (completing-read "RI: " 'ri-complete nil t (ri-symbol-at-point))))

(defun ri-complete (string predicate flag)
  "Dispatch to the proper completion functions based on flag."
  ;; Populate ri-completions-alist if necessary
  (unless (assoc string ri-completions-alist)
    (add-to-list 'ri-completions-alist
                 (cons string
                       (split-string (ri-query (concat "Complete: " string))))))
  (cond ((eq t flag)
         (ri-all-completions string))
        ((eq nil flag)
         (ri-try-completion string))
        ((eq 'lambda flag)
         (ri-test-completion string))
        ((and (listp flag) (eq (car flag) 'boundaries))
         ;; Going to treat boundaries like all-completions for now.
         (ri-all-completions string))
        (t (message "Unknown flag: %s" flag))))

(defun ri-test-completion (string)
  "Return non-nil if STRING is a valid completion."
  (assoc string ri-completions-alist))

(defun ri-all-completions (string)
  "Search for partial matches to STRING in RDoc."
  (cdr (assoc string ri-completions-alist)))

(defun ri-try-completion (string)
  "Return common substring of all completions of STRING in RDoc."
  (ido-find-common-substring (ri-all-completions string) string))

(defun ri-symbol-at-point ()
  (interactive)
  (let ((ri-symbol (symbol-at-point)))
    (setq sap ri-symbol)
    (if ri-symbol
        (symbol-name ri-symbol)
      "")))

(defun get-ri-input()
  (interactive)
  (let ((ri-sym (read-from-minibuffer "RI: " (ri-symbol-at-point))))
    (concat "ri -T " ri-sym)))

(defun ri()
  (interactive)
  (ri-command (get-ri-input)))

    

(ri-symbol-at-point)
(ri-readin)

