;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ memory   : HEADER
;@ segments : HEADER 
;@ size     : $10
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant le header de la cartouche
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


.include "constants.inc"

.segment "HEADER"
.byte $4E, $45, $53, $1A                       ; Magic string that always begins an iNES header
.byte PRG_ROM_BANKS_NB                         ; Number of 16KB PRG-ROM banks
.byte CHR_ROM_BANKS_NB                         ; Number of 8KB CHR-ROM banks
.byte NES_MIRR_QUAD|(NES_MAPPER_MMC3<<4)
.byte NES_MAPPER_MMC3&$F0
.byte $00                                      ; No PRG-RAM present
.byte $00                                      ; NTSC format
