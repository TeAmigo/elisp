;; * Tue Sep 14 02:40:30 2010 rpc - For practicing edebug, do C-u M-C-x inside function to set it
;; up for stepping, see info edebug, ? gives keybindings in edebug mode
;;* Thu Sep 16 11:27:32 2010 rpc - 
;;   `C-M-x' instruments the definition
;; The command `M-x edebug-all-defs' toggles the value of the variable `edebug-all-defs'.
;; `e EXP <RET>'     Evaluate expression EXP
;; `M-: EXP <RET>'     Evaluate expression EXP in the context of Edebug itself
;; `C-x C-e'  Evaluate the expression before point
;; `b'
   ;;   Set a breakpoint at the stop point at or after point
   ;;   (`edebug-set-breakpoint').  If you use a prefix argument, the
   ;;   breakpoint is temporary--it turns off the first time it stops the
   ;;   program.

   ;; `u'
   ;;   Unset the breakpoint (if any) at the stop point at or after point
   ;;   (`edebug-unset-breakpoint').

   ;;  `x CONDITION <RET>'
   ;;   Set a conditional breakpoint which stops the program only if
   ;;   evaluating CONDITION produces a non-`nil' value
   ;;   (`edebug-set-conditional-breakpoint').  With a prefix argument,
   ;;   the breakpoint is temporary.

   ;;  `B'
   ;;   Move point to the next breakpoint in the current definition
   ;;   (`edebug-next-breakpoint').
;; (edebug) - in code, cause break here

;;  To enable trace recording, set `edebug-trace' to a non-`nil' value.




(defun fac (n)
  (if (< 0 n)
      (* n (fac (1- n)))
    1))

(fac 3)
(setq y 2)

(let ((y 1)
      (z y))
  (list y z))

