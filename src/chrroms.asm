;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ memory   : CHRROMXX (XX = 00, 01, 02)
;@ segments : CHR00
;@            CHR01
;@            CHR02 
;@ size     : $6000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc    : Fichier dans lequel sont inclus les banks de CHRs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.segment "CHR00"
.incbin "helloworld_bank00.chr"

.segment "CHR01"
.incbin "helloworld_bank01.chr"

.segment "CHR02"
.incbin "helloworld_bank02.chr"