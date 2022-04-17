;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ memory   : PRGROMFIXED
;@ segments : CODE 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ exports  : main
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant le point d'entrée (main) et la boucle 
;@            principale du programme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


.include "constants.inc"
.include "nmiendwait.inc"

.import s_load_palettes
.import s_hello_world
.import s_load_prg
.import s_call_prg00_bank
.import s_call_prg01_bank
.import s_call_prg02_bank
.import v_prg_bank_idx
.import v_chr_bank_parts
.import v_frames_counter


.segment "CODE"



;; PROC
;; name: main
;; desc: Point d'entrée du programme 
.export main
.proc main


  ; reset PPU address and scroll registers

  LDA PPU_STATUS   ; reset PPU

  JSR s_load_palettes
  JSR s_hello_world

  LDA #$00        ; reset scroll
  STA PPU_SCROLL  ;
  STA PPU_SCROLL  ; PPU scroll = $0000 

  ; activate PPU graphics
  LDA #(MASK_BG|MASK_SPR|MASK_BG_CLIP|MASK_SPR_CLIP)
  STA PPU_MASK 	  ; enable rendering
  LDA #CTRL_NMI
  STA PPU_CTRL	  ; enable NMI 

  ; Mettre les valeurs initiale des variables
  ;LDA #$00
  ;STA v_frames_counter
  LDA #(CHR_PART_0|CHR_PART_1)
  STA v_chr_bank_parts


main_loop:
  M_NMI_END_WAIT  ; attendre la fin de l'interruption NMI avnt de faire quoi que ce soit

  LDA v_frames_counter        ; Est-ce que le frame_counter est égal à 255
  CMP #$FF                    ;
  BEQ select_prg_bank
  JMP main_loop_end           ; Si plus petit, on va à la fin de main_loop

select_prg_bank:  

  INC v_prg_bank_idx          ; | On passe a la bank suivante (bank_idx = bank_idx) 
  LDA v_prg_bank_idx          ; | Si bank_idx < nombre de rom - la rom fixe
  CMP #(PRG_ROM_BANKS_NB-1)   ; | | 
  BCC change_prg_bank         ; | | On ne fait rien et on passe au changement de bank
  LDA #$00                    ; | Sinon 
  STA v_prg_bank_idx          ; | | On remet l'index de la bank à 0 

change_prg_bank:
  LDA v_prg_bank_idx
  JSR s_load_prg 
  LDA v_prg_bank_idx 
  CMP #$00
  BEQ display_prg00_msg
  CMP #$01
  BEQ display_prg01_msg
  CMP #$02
  BEQ display_prg02_msg
  JMP main_loop_end

display_prg00_msg:
  JSR s_call_prg00_bank
  JMP main_loop_end

display_prg01_msg:
  JSR s_call_prg01_bank
  JMP main_loop_end

display_prg02_msg:
  JSR s_call_prg02_bank
  JMP main_loop_end



main_loop_end:
  JMP main_loop


.endproc

