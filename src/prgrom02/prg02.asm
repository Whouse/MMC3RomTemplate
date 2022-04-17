;
; TODO : Ecrire descriptif du fichier
;

.include "constants.inc"
.include "regs.inc"
.include "ptrs.inc"

.segment "ZEROPAGE"
.importzp _ptr_00

.segment "PRG02"

.export s_call_prg02_bank
.proc s_call_prg02_bank
  M_SAVE_REGS

  LDA PPU_STATUS     ; réinitialiser le PPU
  LDA #$20           ; faire pointer le PPU sur l'adresse des NT1 $2000
  STA PPU_ADDR       ; |
  LDA #$00           ; |
  STA PPU_ADDR       ; |

  M_SET_PTR_TO_ADDR _ptr_00, msg_nt1 ; Fais pointer vers le message à afficher sur NT1
  JSR si_affichage_msg               ; Appelle la sousroutines d'affichage

  LDA #$00        ; reset scroll
  STA PPU_SCROLL  ;
  STA PPU_SCROLL  ; PPU scroll = $0000 

  M_RESTORE_REGS
  RTS
.endproc

.proc si_affichage_msg

  LDA #00            ; Simplement pour faire commencer le message après la colonne vide
  STA PPU_DATA	     ;

  LDY #00		         ; set Y counter to 0
loop:
  LDA (_ptr_00),Y	   ; get next character
  BEQ end	           ; is 0? exit loop
  STA PPU_DATA	     ; store+advance PPU
  INY		             ; next character
  BNE loop	         ; loop
end:

  RTS
.endproc


; ASCII message to display on screen
msg_nt1:
.byte "Hello, PRG02 bank NT1!"
.byte 0		; zero terminator