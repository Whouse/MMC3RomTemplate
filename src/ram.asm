;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ memory   : RAM
;@ segments : BSS 
;@ size     : $0500
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ exports  : v_nmi_end_flag
;@            v_frames_counter
;@            v_chr_bank_idx
;@            v_chr_bank_parts
;@            v_prg_bank_idx 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant les variables du programme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.segment "BSS"

;@ VAR
;@ name: v_nmi_end_flag 
;@ size: 1 byte
;@ desc: flag utilisé pour indiquer que l'interruption NMI est terminée
.export v_nmi_end_flag
v_nmi_end_flag: .res 1

;@ VAR
;@ name: v_frames_counter
;@ size: 1 byte
;@ desc: utilisé pour compter le nomnre de frames (boucle à 255)
.export v_frames_counter
v_frames_counter: .res 1


;@ VAR
;@ name: v_chr_bank_idx
;@ size: 1 byte
;@ desc: variable utilisée pour indiquer quelle bank de chr charger 
;@       (les banks banks sont indexées à partir de 0)
.export v_chr_bank_idx
v_chr_bank_idx: .res 1

;@ VAR
;@ name: v_chr_bank_parts
;@ size: 1 byte
;@ desc: variable utilisée pour indiquer quelle partie de la bank de chr charger 
;@       (bit de 0 à 6, si setté alors partie à changer)
.export v_chr_bank_parts
v_chr_bank_parts: .res 1

;@ VAR
;@ name: v_prg_bank_idx
;@ size: 1 byte
;@ desc: variable utilisée pour indiquer quelle bank de prg charger 
;@       (les banks banks sont indexées à partir de 0)
.export v_prg_bank_idx
v_prg_bank_idx: .res 1