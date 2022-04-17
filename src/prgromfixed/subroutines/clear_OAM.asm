;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ memory   : PRGROMFIXED
;@ segments : CODE 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ exports  : s_clear_OAM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant la sous-routine nettoyant le buffer OAM
;@            Dans les faits, il s'agit surtout de mettre l'ensemble des 
;@            sprites en dehors de l'écran (coordonnées Y mise à $FF)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


.include "constants.inc"
.include "regs.inc"

.segment "CODE"

.export s_clear_OAM
.proc s_clear_OAM

  M_SAVE_REGS

	LDA #$FF
clear_OAM:
	STA OAM_RAM,X ; set sprite y-positions off the screen
	INX
	INX
	INX
	INX
	BNE clear_OAM

  M_RESTORE_REGS

  RTS

.endproc
