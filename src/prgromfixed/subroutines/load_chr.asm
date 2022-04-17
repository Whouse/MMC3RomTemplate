;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ memory   : PRGROMFIXED
;@ segments : CODE 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ exports  : s_load_chr
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant la sous-routine permettant le changement de 
;@            CHR (tout ou partie)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ params    : v_chr_bank_idx > contient l'index de la CHR à changer
;@             v_chr_bank_parts > contient les parties à changer de la CHR 
;@                                %00xxxxxx (x: 0|1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


.include "constants.inc"
.include "regs.inc" 

.import v_chr_bank_idx
.import v_chr_bank_parts

.segment "ZEROPAGE"
.importzp _ptr_00

.segment "CODE"

.export s_load_chr
.proc s_load_chr

  M_SAVE_REGS

  LDA v_chr_bank_idx       ; On met le pointeur à la valeur correspondant à l'index de la chr  
  STA _ptr_00              ; | byte faible = chr idx
  LDA #$00                 ; |
  STA _ptr_00+1            ; | byte fort = 0

  ASL _ptr_00              ; chr idx = CHR idx * 8
  ASL _ptr_00              ; |
  ASL _ptr_00              ; |



  LDA #CHR_PART_0          ; On teste si le bit 0 est setté
  BIT v_chr_bank_parts     ; |
  BEQ part_0_not_set       ; Si ce n'est pas le cas, on ne change pas la partie 0

  LDA #MMC3_CHR_BANK_2K_0  ; On indique que l'on change les 2KB a $0000-$07FF
  STA MMC3_MODE            ; |
  LDA _ptr_00              ; On indique par quelle partie on remplace les 2KB
  STA MMC3_CTRL            ; |


part_0_not_set:

  LDA #CHR_PART_1          ; On teste si le bit 1 est setté
  BIT v_chr_bank_parts     ; |
  BEQ part_1_not_set       ; Si ce n'est pas le cas, on ne change pas la partie 1

  LDA #MMC3_CHR_BANK_2K_1  ; On indique que l'on change les 2KB a $0800-$0FFF
  STA MMC3_MODE            ; |
  LDA _ptr_00              ; On indique par quelle partie on remplace les 2KB
  ADC #$02                 ; | chr idx2 = chr idx + 2
  STA MMC3_CTRL            ; |

part_1_not_set:

  LDA #CHR_PART_2          ; On teste si le bit 2 est setté
  BIT v_chr_bank_parts     ; |
  BEQ part_2_not_set       ; Si ce n'est pas le cas, on ne change pas la partie 2

  LDA #MMC3_CHR_BANK_1K_2  ; On indique que l'on change les 1KB a $1000-$13FF
  STA MMC3_MODE            ; |
  LDA _ptr_00              ; On indique par quelle partie on remplace les 1KB
  ADC #$04                 ; | chr idx3 = chr idx + 4
  STA MMC3_CTRL            ; |

part_2_not_set:

  LDA #CHR_PART_3          ; On teste si le bit 3 est setté
  BIT v_chr_bank_parts     ; |
  BEQ part_3_not_set       ; Si ce n'est pas le cas, on ne change pas la partie 3 

  LDA #MMC3_CHR_BANK_1K_3  ; On indique que l'on change les 1KB a $1400-$17FF
  STA MMC3_MODE            ; |
  LDA _ptr_00              ; On indique par quelle partie on remplace les 1KB
  ADC #$05                 ; | chr idx4 = chr idx + 5
  STA MMC3_CTRL            ; |

part_3_not_set:

  LDA #CHR_PART_4          ; On teste si le bit 4 est setté
  BIT v_chr_bank_parts     ; |
  BEQ part_4_not_set       ; Si ce n'est pas le cas, on ne change pas la partie 4 

  LDA #MMC3_CHR_BANK_1K_4  ; On indique que l'on change les 1KB a $1800-$1BFF
  STA MMC3_MODE            ; |
  LDA _ptr_00              ; On indique par quelle partie on remplace les 1KB
  ADC #$06                 ; | chr idx5 = chr idx + 6
  STA MMC3_CTRL            ; |

part_4_not_set:

  LDA #CHR_PART_5          ; On teste si le bit 5 est setté
  BIT v_chr_bank_parts     ; |
  BEQ part_5_not_set       ; Si ce n'est pas le cas, on ne change pas la partie 3 

  LDA #MMC3_CHR_BANK_1K_5  ; On indique que l'on change les 1KB a $1C00-$1FFF
  STA MMC3_MODE            ; |
  LDA _ptr_00              ; On indique par quelle partie on remplace les 1KB
  ADC #$07                 ; | chr idx6 = chr idx + 7
  STA MMC3_CTRL            ; |

part_5_not_set:

  M_RESTORE_REGS

  RTS

.endproc