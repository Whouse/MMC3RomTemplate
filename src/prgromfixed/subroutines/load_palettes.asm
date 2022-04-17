;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ memory   : PRGROMFIXED
;@ segments : CODE 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ exports  : s_load_palettes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant la sous-routine permettant le changement des 
;@            palettes. Les palettes sont localisées à l'adresse "palettes"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.include "constants.inc"
.include "regs.inc"

.import palettes 

.segment "CODE"

.export s_load_palettes
.proc s_load_palettes

  M_SAVE_REGS

  LDA PPU_STATUS     ; réinitialiser le PPU
  LDA #$3F           ; faire pointer le PPU sur l'adresse des palettes $F300
  STA PPU_ADDR       ; |
  LDA #$00           ; |
  STA PPU_ADDR       ; |

load_palettes:       ; ecrire les palettes
  LDA palettes,X     ; pour x de 0 à $20 - charger la valeur (palettes + offset X)
  STA PPU_DATA       ;                   - écrire la valeur
  INX                ;                   - augmenter offset X
  CPX #$20           ;                   - est-ce fini ?
  BNE load_palettes  ;                   - non, on repart     

  M_RESTORE_REGS

  RTS

.endproc