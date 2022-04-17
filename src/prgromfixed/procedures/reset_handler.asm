;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ memory   : PRGROMFIXED
;@ segments : CODE 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ exports  : p_reset_handler
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant la procédure appellée lors d'une interruption
;@            de type RESET. Cela se produit au démarrage de la ROM 
;@            (allumage ou reset console/émulateur)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.include "constants.inc"
.include "vblankwait.inc"

.import main
.import s_clear_RAM
.import s_clear_OAM

.segment "CODE"

.export p_reset_handler
.proc p_reset_handler

  SEI               ; disable IRQs
  CLD               ; decimal mode not supported
  LDX #$FF          ; set up stack pointer     
  TXS         			; |
  INX               ; increment X to 0
  STX PPU_MASK      ; disable rendering
  STX DMC_FREQ      ; disable DMC interrupts
  STX PPU_CTRL      ; disable NMI interrupts
	BIT PPU_STATUS    ; clear VBL flag
  BIT APU_CHAN_CTRL ; ack DMC IRQ bit 7
	LDA #$40          ; disable APU Frame IRQ
	STA APU_FRAME     ; |
	LDA #$0F          ; disable DMC, enable/init other channels.   
	STA APU_CHAN_CTRL ; |

  M_VBLANK_WAIT     ; On attend la synchro vertical

  JSR s_clear_RAM   ; On nettoie la RAM
  JSR s_clear_OAM   ; On nettoie l'OAM 

  M_VBLANK_WAIT     ; On attend la synchro vertical

  JMP main          ; Tout est prêt, on peut aller à la boucle prioncipale.

.endproc
