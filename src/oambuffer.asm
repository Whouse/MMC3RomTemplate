;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ memory   : OAMBUFFER
;@ segments : OAM 
;@ size     : $0100
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ exports  : v_sprite_00
;@            v_sprite_00_X
;@            v_sprite_00_Y
;@            v_sprite_00_S
;@            v_sprite_00_T
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant la RAM copiée dans le PPU
;@            Utilisée pour les sprites (max. 64 sprites)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.segment "OAM"


;@ VAR
;@ name: v_sprite_00(_Y,_T,_S,_X) 
;@ size: 4 bytes
;@ desc: Suite de 4 bytes destinés à gérer le sprite 00
;@       _Y: coordonnées Y
;@       _T: numéro de la Tile dans la CHR
;@           76543210
;@           ||||||||
;@           |||||||+- Bank ($0000 or $1000) of tiles
;@           +++++++-- Tile number of top of sprite (0 to 254; bottom half gets the next tile) 
;@       _S: flags de transformation
;@           76543210
;@           ||||||||
;@           ||||||++- Palette (4 to 7) of sprite
;@           |||+++--- Unimplemented
;@           ||+------ Priority (0: in front of background; 1: behind background)
;@           |+------- Flip sprite horizontally
;@           +-------- Flip sprite vertically 
;@       _X: coordonnées X    
.export v_sprite_00, v_sprite_00_X, v_sprite_00_Y, v_sprite_00_S, v_sprite_00_T 

v_sprite_00:
v_sprite_00_Y: .res 1
v_sprite_00_T: .res 1
v_sprite_00_S: .res 1
v_sprite_00_X: .res 1
