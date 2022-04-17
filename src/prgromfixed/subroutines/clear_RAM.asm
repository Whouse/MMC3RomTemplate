;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ memory   : PRGROMFIXED
;@ segments : CODE 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ exports  : s_clear_RAM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant la sous-routine nettoyant la RAM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.include "constants.inc"
.include "regs.inc"

.segment "CODE"

.export s_clear_RAM
.proc s_clear_RAM

  M_SAVE_REGS

  LDA #0		      ; A = 0
  TAX 	         	; X = 0
clear_RAM:
  STA $00,X	      ; clear $0-$ff
  CPX #$FE	      ; last 2 bytes of stack?
  BCS skip_stack	; don't clear it
  STA $0100,X     ; clear $100-$1fd
skip_stack:
  STA $0200,X	    ; clear $200-$2ff
  STA $0300,X	    ; clear $300-$3ff
  STA $0400,X    	; clear $400-$4ff
  STA $0500,X    	; clear $500-$5ff
  STA $0600,X    	; clear $600-$6ff
  STA $0700,X	    ; clear $700-$7ff
  INX	        	  ; X = X + 1
  BNE clear_RAM	  ; loop 256 times

  M_RESTORE_REGS

  RTS

.endproc
