;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ MACROS  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant les MACROS servant à manipuler les pointeurs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;@ MACRO
;@ name   : M_SET_PTR_TO_ADDR
;@ params : ptr  <  pointeur à modifier 
;@          addr >  adresse à copier dans le pointeur
;@ desc   : Copie l'adresse dans le pointeur passé en paramètre    
.mac M_SET_PTR_TO_ADDR ptr, addr
  LDA #<addr
  STA ptr
  LDA #>addr
  STA ptr+1
.endmac

;;;; set pointer to adress - SET_PTR_TO_ADDR <ptr name> <label/addr>
;	MAC SET_PTR_TO_ADDR
;.ptr SET {1}
;.addr SET {2}
;		lda #<.addr
;		sta .ptr
;		lda #>.addr
;		sta .ptr+1
;	ENDM






;;;; increment pointer - INC_PTR <ptr name>
;
;	MAC INC_PTR
;		inc {1}
;		bne .inc_end
;		inc {1}+1
;.inc_end		
;	ENDM


;;;; compare pointers - CMP_PTRS <ptr1 name> <ptr2 name>
;
;	MAC CMP_PTRS
;		lda {1}
;		cmp {2}
;		bne .not_equal
;		lda {1}+1
;		cmp {2}+1
;.not_equal
;	ENDM

;;;; copy pointer (ptr1 to ptr2) - CPY_PTR <ptr1 name> <ptr2 name> 
;
;	;; copy value (word) {1} to word {2}
;	MAC CPY_PTR
;.ptr1 SET {1}
;.ptr2 SET {2}
;	    lda .ptr1+1
;        sta .ptr2+1
;        lda .ptr1
;        sta .ptr2 
;	ENDM


;;;; add 4 to a pointer
;	MAC PTR_ADD_4
;.ptr SET {1}
;		clc
;		lda .ptr
;		adc #$04
;		sta .ptr
;       lda .ptr+1
;        adc #$00
;        sta .ptr+1
;	ENDM  