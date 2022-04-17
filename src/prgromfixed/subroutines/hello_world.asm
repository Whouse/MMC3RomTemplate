;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ memory   : PRGROMFIXED
;@ segments : CODE 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ exports  : s_hello_world
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant la sous-routine s_hello_world
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.include "constants.inc"
.include "regs.inc"
.include "ptrs.inc"

.segment "ZEROPAGE"
.importzp _ptr_00


.segment "CODE"

.export s_hello_world
.proc s_hello_world

  M_SAVE_REGS

  LDA PPU_STATUS     ; réinitialiser le PPU
  LDA #$20           ; faire pointer le PPU sur l'adresse des NT1 $2000
  STA PPU_ADDR       ; |
  LDA #$00           ; |
  STA PPU_ADDR       ; |

  M_SET_PTR_TO_ADDR _ptr_00, msg_nt1 ; Fais pointer vers le message à afficher sur NT1
  JSR si_affichage_msg               ; Appelle la sousroutines d'affichage

  LDA PPU_STATUS     ; réinitialiser le PPU
  LDA #$24           ; faire pointer le PPU sur l'adresse des NT2 $2400
  STA PPU_ADDR       ; |
  LDA #$00           ; |
  STA PPU_ADDR       ; |

  M_SET_PTR_TO_ADDR _ptr_00, msg_nt2 ; Fais pointer vers le message à afficher sur NT2
  JSR si_affichage_msg               ; Appelle la sousroutines d'affichage

  LDA PPU_STATUS     ; réinitialiser le PPU
  LDA #$28           ; faire pointer le PPU sur l'adresse des NT3 $2800
  STA PPU_ADDR       ; |
  LDA #$00           ; |
  STA PPU_ADDR       ; |

  M_SET_PTR_TO_ADDR _ptr_00, msg_nt3 ; Fais pointer vers le message à afficher sur NT3
  JSR si_affichage_msg               ; Appelle la sousroutines d'affichage

  LDA PPU_STATUS     ; réinitialiser le PPU
  LDA #$2C           ; faire pointer le PPU sur l'adresse des NT4 $2C00
  STA PPU_ADDR       ; |
  LDA #$00           ; |
  STA PPU_ADDR       ; |

  M_SET_PTR_TO_ADDR _ptr_00, msg_nt4 ; Fais pointer vers le message à afficher sur NT3
  JSR si_affichage_msg               ; Appelle la sousroutines d'affichage

  M_RESTORE_REGS

  RTS

.endproc


; Affiche le message pointé par _ptr_00 sur la NT courante
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
.byte "Hello, World NT1!"
.byte 0		; zero terminator

msg_nt2:
.byte "Hello, World NT2!"
.byte 0		; zero terminator

msg_nt3:
.byte "Hello, World NT3!"
.byte 0		; zero terminator

msg_nt4:
.byte "Hello, World NT4!"
.byte 0		; zero terminator