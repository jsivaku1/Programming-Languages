;Project 2 in scheme programming
;===============================
;Problem 1: To generate the given number of 's' using int->unary function as per peano's definition of natural numbers

(define (int->unary n)
        (if(= n 0)  	
                'z				    ;if given number is 0, then print the empty list
                (cons 's (int->unary (- n 1)))))    ;if not empty, print the recursive of the given number 






;Problem 2: To generate the number for the given int->unary representation of list.

(define (unary->int n)
        (if(pair? n)    
                (+ 1 (unary->int  (cdr n)))	;if it is pair, generate the number
                0))				;if not, print 0





;Problem 3: To add two list m and n from the arguments
(define unary-add
  	(lambda (m n)	
		(cond				
  			[(null? m) n]		;if m is empty, print n
 			[(null? n) m]		;if n is empty, print m
			[(equal? m 'z) n]	;if m has 'z alone, then print n
   			[else (cons (car m) (unary-add (cdr m) n))])))	;if not cons the m and n and recrusive it till the list is empty





;Problem 4: To multiply two given lists using additive multiplicative property as per the hint

(define unary-mul
  (lambda (m n)
    (cond
      [(equal? n 'z) 'z]				;if n has 'z, then print 'z. It is like 0 multiplied gets 0 again
      [else (unary-add m (unary-mul m (cdr n)))])))	;if not, add the list m to cdr of the list for n times. 






;Problem 5: To map the car and cdr of a list using map and transpose function

;Procedure to append the list after mapping
(define (fill fill_ls val num)
        (append fill_ls					;appending to the seperated list
                (build-list num (const val))))		;create a new list from the seperated one




;Function to transpose lists
(define (transpose tp_ls)
        (apply map list tp_ls))



;List-tuple to combine the mapping of car and cdr
(define (list-tuples ls)
        (let* ((lengths (map length ls)) 				;Get the length of seperated lists
                (max-length (apply max lengths))) 			;Calculating maximum length of list
                        (transpose 					;Create a new element list after spliting
                                (map (lambda (lst len) 			;Create a new length list
                                (fill lst '() (- max-length len))) 	;fill seperated list with '()
				ls
                                lengths))))



