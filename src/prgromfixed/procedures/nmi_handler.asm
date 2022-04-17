;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ memory   : PRGROMFIXED
;@ segments : CODE 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ exports  : p_nmi_handler
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant la procédure appellée lors d'une interruption
;@            de type NMI. Cette interruption se produit à chaque 
;@            rafraîchissement d'écran.
;@            C'est lors de l'interruption NMI que la mémoire OAM est copiée 
;@            dans la mémoire du PPU. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.include "constants.inc"
.import v_nmi_end_flag
.import v_frames_counter
.import v_chr_bank_idx
.import v_sprite_00, v_sprite_00_X, v_sprite_00_Y, v_sprite_00_S, v_sprite_00_T 
.import s_clear_OAM
.import s_load_chr

.segment "CODE"

.export p_nmi_handler
.proc p_nmi_handler

  LDA #$00
  STA OAM_ADDR
  LDA #$02
  STA PPU_OAM_DMA

  INC v_frames_counter ; Incremente le compteur de frame (boucle sur 256 valeur)
  
  BNE draw_sprite        ; Si v_frames_counter = 0
  INC v_chr_bank_idx     ; | On passe a la bank suivante (bank_idx = bank_idx) 
  LDA v_chr_bank_idx     ; | Si bank_idx < nombre de rom
  CMP #CHR_ROM_BANKS_NB  ; | | 
  BCC change_chr_bank    ; | | On ne fait rien et on passe au changement de bank
  LDA #$00               ; | Sinon 
  STA v_chr_bank_idx     ; | | On remet l'index de la bank à 0 

change_chr_bank:        
  JSR s_load_chr         ; On change de CHR



draw_sprite:

  JSR s_clear_OAM      ; Nettoie le buffer OAM 

  LDA v_frames_counter ; Mets le X à frames_counter (out à 70, réapparition à 0)
  STA v_sprite_00_X    ; |
  LDA #$70             ; Mets le Y du sprite à 70 
  STA v_sprite_00_Y    ; |
  LDA #$14             ; Mets le tile du sprite à $14 de la CHR 
  STA v_sprite_00_T    ; |
  LDA #$00             ; Pas de valeurs spéciale pour ce sprite
  STA v_sprite_00_S    ; |

  INC v_nmi_end_flag   ; Flag de fin de nmi mis à 1
  RTI                  ; On revient au code 

.endproc