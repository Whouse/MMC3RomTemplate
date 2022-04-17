;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ MACROS  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant la MACRO permettant l'attente de la fin de 
;@            la synchronisation verticale
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;@ MACRO
;@ name   : M_VBLANK_WAIT
;@ desc   : Boucle indéfiement tant que la valeur de PPU_STATUS n'indique pas 
;@          que la synchronisation verticale est finie 
.mac M_VBLANK_WAIT

.scope
vblank_wait:
  BIT PPU_STATUS
  BPL vblank_wait
.endscope

.endmac

