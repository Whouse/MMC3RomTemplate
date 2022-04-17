;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ MACROS  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant la MACRO permettant la manipulation des 
;@            registres
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;@ MACRO
;@ name   : M_SAVE_REGS
;@ desc   : Sauvegarde les registres P, A, X, Y sur la pile.  
.mac M_SAVE_REGS
  PHP
  PHA
  TXA
  PHA
  TYA
  PHA
.endmac

;@ MACRO
;@ name   : M_SAVE_REGS
;@ desc   : Restaure les registres Y, X, A, P depuis la pile.  
.mac M_RESTORE_REGS
  PLA
  TAY
  PLA
  TAX
  PLA
  PLP 
.endmac
