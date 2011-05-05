;;08/22/2010  - From http://xahlee.org/emacs/elisp_basics.html
;; Double ;; keeps at begin of line ^, single ; jumps to comment column
;;C-x C-e eval-last-sexp, handy inside funcs for sing sexp
;;C-M-x runs the command eval-defun

(message "Her age is: %d " 16)          ; %d is for number
(message "Her name is: %s " "Vicky")    ; %s is for string
(message "Her mid init is: %c " 86)     ; %c is for character in ascii code

(+ 4 5 1)                               ;    ⇒ 10
(- 9 2)                                 ;    ⇒  7
(- 9 2 3)                               ;    ⇒  4
(* 2 3)                                 ;    ⇒  6
(* 2 3 2)                               ;    ⇒ 12
(/ 7 2)                                 ;    ⇒  3 Integer part of quotient
(/ 7 2.0)                               ;    ⇒  3.5
(% 7 4)                                 ;    ⇒  3. Remainder
(expt 2 3)                              ;    ⇒ 8

nil and () are both false, the only falses

(< 3 4)                                 ; less than
(> 3 4)                                 ; greater than
(<= 3 4)                                ; less or equal to
(>= 3 4)                                ; greater or equal to

(= 3 3)                                 ; ⇒ t
(= 3 3.0)                               ; ⇒ t

(string= "this" "this")                 ; ⇒ t. Case matters.
(string< "a" "b")                       ; ⇒ t. by lexicographic order.
(string< "B" "b")                       ; ⇒ t.

;; testing if two values have the same datatype and value.
(equal "abc" "abc")                     ; ⇒ t
(equal 3 3)                             ; ⇒ t
(equal 3.0 3.0)                         ; ⇒ t
(equal 3 3.0)                           ; ⇒ nil. Because datatype doesn't match.

;; testing equality of lists
(equal '(3 4 5) '(3 4 5))               ; ⇒ t
(equal '(3 4 5) '(3 4 "5"))             ; ⇒ nil

;; testing equality of symbols
(equal 'abc 'abc)                       ; ⇒ t

;;There is no -Y´!=¡ or ´not-equal¡. To test for inequality, use ´not¡ to negate your equality test.


(not (= 3 4))                           ; ⇒ t
(not (equal 3 4))                       ; ⇒ t

;;setq¡ is used to set variables. Variables need not be declared, and is global.
(setq x 1)                              ; assign 1 to x
(setq a 3 b 2 c 7)                      ; assign 3 to a, 2 to b, 7 to c

(let (a b)
  (setq a 3)
  (setq b 4)
  (+ a b)
  )                                     ; returns 7
;; Shorter, more compact form
(let ((a 3) (b 4))
  (+ a b)
  )                                     ; returns 7

;;(progn ...)¡ is equivalent to a block of code ´{...}¡ in C-like languages. 
(progn (message "hi") (message "lo"))
;;is equivalent to
(message "hi") (message "lo")

;; If Then Else...
(if (< 3 2) (message "yes") )
(if (< 3 2) (message "yes") (message "no") )

(if nil (message "yes") (message "no") ) ; prints no

;;Here is a way to remove and return the first element from a list in the variable x,
;;then return the value of that former element:
(let ((x '(3 4 5)) (y 3)) (prog1 (car x) (setq x (cdr x))))

;;Iteration, also see http://xahlee.org/elisp/Iteration.html or
(info "(elisp) Iteration")
(setq x 0)

(while (< x 4)
  (princ (format "yay %d." x))
  (setq x (1+ x)))


(let ((x 32))
  (while (/= x 128)
    (ucs-insert x)
    (setq x (+ x 1))))
;;; result => !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~

;; use C-x C-e to eval => (info "(elisp) Lists")

                                        ; prints a list
(message "%S" '(a b c))

                                        ; assign a list to a var
(setq mylist '(a b c))

                                        ; create a list of values of variables
(let ((x 3) (y 4) (z 5))
  (message "%S" (list x y z))
  )                                     ; prints "(3 4 5)"

                                        ; add one to each list member
(mapcar (lambda (x) (+ x 1)) '(1 2 3 4)) ; ⇒ (2 3 4 5)
                                        ; add one to each list member using the build in function 1+
(mapcar '1+ '(1 2 3 4))                 ; ⇒ (2 3 4 5)

                                        ; take the 1st element of each element in the list
(mapcar 'car  '((1 2) (3 4) (5 6)))     ; ⇒ (1 3 5)

                                        ; take the 2nd element of each element in the ilst
(mapcar (lambda (x) (nth 1 x))  '((1 2) (3 4) (5 6))) ; ⇒ (2 4 6)

(let (mylist)
  (setq mylist '(a b c))
  (while mylist
    (message "%s" (pop mylist))
    (sleep-for 1)))

;;The following is a basic function definition taking region as arg. Note the (interactive "r"),
;;The "r" is a code that tells emacs that the function will receive the buffer's region as its argument.

(defun myFunction (myStart myEnd)
  "Prints region start and end positions"
  (interactive "r")
  (message "Region begin at: %d, end at: %d" myStart myEnd)
)

;;By default, emacs highlight just the parens. You can change it with the following code:

(setq show-paren-style 'parenthesis) ; highlight just parens
(setq show-paren-style 'expression) ; highlight entire expression

(info "(elisp) Iteration")