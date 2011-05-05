;; /*                              -***-   /share/elisp/processes.el  -***-

;;  * * Thu Sep 16 11:57:48 2010 rpc - 
;;  * 
;;  * 
;;  */

;; NExt 2 from info (see Edit/Bookmarks Asynch processes), work as advertised
(start-process "my-process" "foo" "sleep" "10")
(start-process "my-process" "foo" "ls" "-l" "/share/elisp")

;;From ri.el (~/EmacsLispRPC/ri.el)
(setq riproc (start-process "ri-repl" "foo" "ri_repl" "\n" "File.open"))
(process-send-string "foo" ("File.open\n"))

(setq riproc (start-process "eshell" "eshell" "eshell"))
(process-send-string riproc ("ls"))

(setq calproc (start-process "rubycal" "cal" "ruby" "/share/ruby/examples/cal.rb"))

(setq riproc (start-process "ri" "ri" "ri" "-T" "File.open"))

(setq rubyproc (start-process "rubproc"   "rub" "/share/ruby/loopInput.rb" "20"))
