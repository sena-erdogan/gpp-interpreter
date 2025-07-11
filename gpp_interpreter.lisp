(ql:quickload "alexandria")

(defun gppinterpreter()
    (princ "Enter 'e' when done")
    (setq line "not e")
    (loop while (!= line "e") 
        do (decoder(line))
        (setq line (read)))
    (princ "Exiting..."))

(defun gppinterpreter(filename)
    (let ((in (open filename :if-does-not-exist nil)))
        (when in
            (loop for line = (read-line in nil)
             while line do (decoder(line)))
        (close in))))

(defun decoder(line)
    ;;(cl-ppcre:split "\\ " line :with-registers-p t)
    (let ((t t)) 
        (switch (t :test 'equal)
        (";;"
            (princ "Syntax OK.")
            (princ "This is a comment."))
        ("(+"
            ((loop while (!= t ")") (
                (setq sum (+ t sum))))
            (princ "Syntax OK.")
            (princ "Result: ~a" sum))
            ;; (if (!= int (typeof t))  (princ "Operands need to be numbers"))
            )
        ("(-"
            ((loop while (!= t ")") (
                (setq sub (- t sub))))
            (princ "Syntax OK.")
            (princ "Result: ~a" sub))
            ;; (if (!= int (typeof t))  (princ "Operands need to be numbers"))
            )
        ("(*"
            ((loop while (!= t ")") (
                (setq mul (* t mul))))
            (princ "Syntax OK.")
            (princ "Result: ~a" mul))
            ;; (if (!= int (typeof t))  (princ "Operands need to be numbers"))
            )
        ("(/"
            ((loop while (!= t ")") (
                (setq div (/ t div))))
            (princ "Syntax OK.")
            (princ "Result: ~a" div))
            ;; (if (!= int (typeof t))  (princ "Operands need to be numbers"))
            )
        ("list"
            ((defparameter lista (list 1 2 3))
            (loop while (!= t ")") (
                (push t (cdr (last lista)))))
            (princ "Syntax OK.")
            (princ "Result: " )
            (lista))
            )
        ("(#\"" 
            (princ "Syntax OK.")
            (princ "Result: ~a" t))
        ;; /default case/ (princ "SYNTAX_ERROR Expression not recognized")
    )
)

(gppinterpreter())

(gppinterpreter(test.txt))
