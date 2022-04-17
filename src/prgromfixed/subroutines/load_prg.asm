;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ memory   : PRGROMFIXED
;@ segments : CODE 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ exports  : s_load_prg
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant la sous-routine permettant le changement de 
;@            PRG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ params   : v_prg_bank_idx > contient l'index de la bank PRG à changer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.include "constants.inc"
.include "regs.inc" 

.import v_prg_bank_idx

.segment "ZEROPAGE"
.importzp _ptr_00

.segment "CODE"

.export s_load_prg
.proc s_load_prg

  M_SAVE_REGS

  LDA v_prg_bank_idx ; On met le pointeur à la valeur correspondant à l'index de la prg  
  STA _ptr_00        ; | byte faible = prg idx
  LDA #$00           ; |
  STA _ptr_00+1      ; | byte fort = 0
  

  ASL _ptr_00        ; ptr idx = PRG idx * 2

  LDA #MMC3_PRG_BANK_8K_0 ; We want to change $8000-$9FFF to what it was when we were 32KB NROM
  STA MMC3_MODE
  LDA _ptr_00
  STA MMC3_CTRL  


  INC _ptr_00          ; ptr idx2 = ptr idx1 + 1

  LDA #MMC3_PRG_BANK_8K_1  ;Now we need to make sure $A000-$BFFF is in the right place
  STA MMC3_MODE
  LDA _ptr_00
  STA MMC3_CTRL  

  M_RESTORE_REGS

  RTS

.endproc