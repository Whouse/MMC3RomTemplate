;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ MACROS  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant la MACRO permettant l'attente de la fin de 
;@            l'interruption NMI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;@ MACRO
;@ name   : M_SET_PTR_TO_ADDR
;@ desc   : Boucle indéfiniement tant que la variable v_nmi_end_flag est 
;@          égale à NMI_FINISHED_FALSE. La variable v_nmi_end_flag est mise à
;@          la valeur NMI_FINISHED_TRUE à la fin de l'interruption NMI.  
.mac M_NMI_END_WAIT

.import v_nmi_end_flag

.scope
end_nmi_wait:
  LDA v_nmi_end_flag                   ; A = v_nmi_end_flag 
  CMP #NMI_FINISHED_FALSE              ; si A == NMI_FINISHED_FALSE nmi is not finished
	BEQ end_nmi_wait                   ; alors on boucle
	LDA #NMI_FINISHED_FALSE            ; sinon, on continue 
	STA v_nmi_end_flag                 ; | et on met v_nmi_end_flag à NMI_FINISHED_FALSE 
.endscope

.endmac



