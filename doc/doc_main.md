# CODE

## oambuffer.asm

_./src/oambuffer.asm_

**memory**

 OAMBUFFER

**segments**

 OAM 

**exports**

 v_sprite_00
            v_sprite_00_X
            v_sprite_00_Y
            v_sprite_00_S
            v_sprite_00_T

**size**

 $0100

**description**

~~~
 Fichier contenant la RAM copiée dans le PPU
            Utilisée pour les sprites (max. 64 sprites)
~~~

## ram.asm

_./src/ram.asm_

**memory**

 RAM

**segments**

 BSS 

**exports**

 v_nmi_end_flag
            v_frames_counter
            v_chr_bank_idx
            v_chr_bank_parts
            v_prg_bank_idx 

**size**

 $0500

**description**

~~~
 Fichier contenant les variables du programme
~~~

## chrroms.asm

_./src/chrroms.asm_

**memory**

 CHRROMXX (XX = 00, 01, 02)

**segments**

 CHR00
            CHR01
            CHR02 

**size**

 $6000

**description**

~~~
 Fichier dans lequel sont inclus les banks de CHRs
~~~

## zeropage.asm

_./src/zeropage.asm_

**memory**

 ZEROPAGE

**segments**

 ZEROPAGE

**exports**

 _ptr_00 

**size**

 $FF

**description**

~~~
 Fichier contenant les variables pouvant être addressé em mode 
            zeropage (notamment les pointeurs)
~~~

## header.asm

_./src/header.asm_

**memory**

 HEADER

**segments**

 HEADER 

**size**

 $10

**description**

~~~
 Fichier contenant le header de la cartouche
~~~

## rodata.asm

_./src/prgromfixed/rodata.asm_

**memory**

 PRGROMFIXED

**segments**

 RODATA

**exports**

 palettes

**description**

~~~
 Fichier contenant les données brutes (i.e. non code) du la ROM 
            PRG fixe.
~~~

## code.asm

_./src/prgromfixed/code.asm_

**memory**

 PRGROMFIXED

**segments**

 CODE 

**exports**

 main

**description**

~~~
 Fichier contenant le point d'entrée (main) et la boucle 
            principale du programme
~~~

## vectors.asm

_./src/prgromfixed/vectors.asm_

**memory**

 PRGROMFIXED

**segments**

 VECTORS 

**size**

 6 Bytes

**description**

~~~
 Fichier contenant la segment des vecteurs (les addresses des 
            procédures appellées lors des interruptions NMI, Reset et IRQ)
~~~

## reset_handler.asm

_./src/prgromfixed/procedures/reset_handler.asm_

**memory**

 PRGROMFIXED

**segments**

 CODE 

**exports**

 p_reset_handler

**description**

~~~
 Fichier contenant la procédure appellée lors d'une interruption
            de type RESET. Cela se produit au démarrage de la ROM 
            (allumage ou reset console/émulateur)
~~~

## nmi_handler.asm

_./src/prgromfixed/procedures/nmi_handler.asm_

**memory**

 PRGROMFIXED

**segments**

 CODE 

**exports**

 p_nmi_handler

**description**

~~~
 Fichier contenant la procédure appellée lors d'une interruption
            de type NMI. Cette interruption se produit à chaque 
            rafraîchissement d'écran.
            C'est lors de l'interruption NMI que la mémoire OAM est copiée 
            dans la mémoire du PPU. 
~~~

## irq_handler.asm

_./src/prgromfixed/procedures/irq_handler.asm_

**memory**

 PRGROMFIXED

**segments**

 CODE 

**exports**

 p_irq_handler

**description**

~~~
 Fichier contenant la procédure appellée lors d'une interruption
            de type IRQ
~~~

## clear_OAM.asm

_./src/prgromfixed/subroutines/clear_OAM.asm_

**memory**

 PRGROMFIXED

**segments**

 CODE 

**exports**

 s_clear_OAM

**description**

~~~
 Fichier contenant la sous-routine nettoyant le buffer OAM
            Dans les faits, il s'agit surtout de mettre l'ensemble des 
            sprites en dehors de l'écran (coordonnées Y mise à $FF)
~~~

## load_palettes.asm

_./src/prgromfixed/subroutines/load_palettes.asm_

**memory**

 PRGROMFIXED

**segments**

 CODE 

**exports**

 s_load_palettes

**description**

~~~
 Fichier contenant la sous-routine permettant le changement des 
            palettes. Les palettes sont localisées à l'adresse "palettes"
~~~

## clear_RAM.asm

_./src/prgromfixed/subroutines/clear_RAM.asm_

**memory**

 PRGROMFIXED

**segments**

 CODE 

**exports**

 s_clear_RAM

**description**

~~~
 Fichier contenant la sous-routine nettoyant la RAM
~~~

## load_prg.asm

_./src/prgromfixed/subroutines/load_prg.asm_

**memory**

 PRGROMFIXED

**segments**

 CODE 

**exports**

 s_load_prg

**params**

 v_prg_bank_idx > contient l'index de la bank PRG à changer

**description**

~~~
 Fichier contenant la sous-routine permettant le changement de 
            PRG
~~~

## load_chr.asm

_./src/prgromfixed/subroutines/load_chr.asm_

**memory**

 PRGROMFIXED

**segments**

 CODE 

**exports**

 s_load_chr

**params**

 v_chr_bank_idx > contient l'index de la CHR à changer
             v_chr_bank_parts > contient les parties à changer de la CHR 
                                %00xxxxxx (x: 0|1)

**description**

~~~
 Fichier contenant la sous-routine permettant le changement de 
            CHR (tout ou partie)
~~~

## hello_world.asm

_./src/prgromfixed/subroutines/hello_world.asm_

**memory**

 PRGROMFIXED

**segments**

 CODE 

**exports**

 s_hello_world

**description**

~~~
 Fichier contenant la sous-routine s_hello_world
~~~

# CONSTANTS

## constants.inc

_./src/constants/constants.inc_

**description**

~~~
 Fichier contenant l'ensemble des constantes
~~~

# MACROS

## ptrs.inc

_./src/macros/ptrs.inc_

**description**

~~~
 Fichier contenant les MACROS servant à manipuler les pointeurs
~~~

## regs.inc

_./src/macros/regs.inc_

**description**

~~~
 Fichier contenant la MACRO permettant la manipulation des 
            registres
~~~

## nmiendwait.inc

_./src/macros/nmiendwait.inc_

**description**

~~~
 Fichier contenant la MACRO permettant l'attente de la fin de 
            l'interruption NMI
~~~

## vblankwait.inc

_./src/macros/vblankwait.inc_

**description**

~~~
 Fichier contenant la MACRO permettant l'attente de la fin de 
            la synchronisation verticale
~~~

# VAR

##  v_sprite_00(_Y,_T,_S,_X) 

_./src/oambuffer.asm_

**size**

 4 bytes

**description**

~~~
 Suite de 4 bytes destinés à gérer le sprite 00
       _Y: coordonnées Y
       _T: numéro de la Tile dans la CHR
           76543210
           ||||||||
           |||||||+- Bank ($0000 or $1000) of tiles
           +++++++-- Tile number of top of sprite (0 to 254; bottom half gets the next tile) 
       _S: flags de transformation
           76543210
           ||||||||
           ||||||++- Palette (4 to 7) of sprite
           |||+++--- Unimplemented
           ||+------ Priority (0: in front of background; 1: behind background)
           |+------- Flip sprite horizontally
           +-------- Flip sprite vertically 
       _X: coordonnées X    
~~~

##  v_nmi_end_flag 

_./src/ram.asm_

**size**

 1 byte

**description**

~~~
 flag utilisé pour indiquer que l'interruption NMI est terminée
~~~

##  v_frames_counter

_./src/ram.asm_

**size**

 1 byte

**description**

~~~
 utilisé pour compter le nomnre de frames (boucle à 255)
~~~

##  v_chr_bank_idx

_./src/ram.asm_

**size**

 1 byte

**description**

~~~
 variable utilisée pour indiquer quelle bank de chr charger 
       (les banks banks sont indexées à partir de 0)
~~~

##  v_chr_bank_parts

_./src/ram.asm_

**size**

 1 byte

**description**

~~~
 variable utilisée pour indiquer quelle partie de la bank de chr charger 
       (bit de 0 à 6, si setté alors partie à changer)
~~~

##  v_prg_bank_idx

_./src/ram.asm_

**size**

 1 byte

**description**

~~~
 variable utilisée pour indiquer quelle bank de prg charger 
       (les banks banks sont indexées à partir de 0)
~~~

##  _ptr_00

_./src/zeropage.asm_

**size**

 2 bytes

**description**

~~~
 pointeur utilisé pour un adressage indirect 
~~~

# MACRO

##  M_SET_PTR_TO_ADDR

_./src/macros/ptrs.inc_

**params**

 ptr  <  pointeur à modifier 
          addr >  adresse à copier dans le pointeur

**description**

~~~
 Copie l'adresse dans le pointeur passé en paramètre    
~~~

##  M_SAVE_REGS

_./src/macros/regs.inc_

**description**

~~~
 Sauvegarde les registres P, A, X, Y sur la pile.  
~~~

##  M_SAVE_REGS

_./src/macros/regs.inc_

**description**

~~~
 Restaure les registres Y, X, A, P depuis la pile.  
~~~

##  M_SET_PTR_TO_ADDR

_./src/macros/nmiendwait.inc_

**description**

~~~
 Boucle indéfiniement tant que la variable v_nmi_end_flag est 
          égale à NMI_FINISHED_FALSE. La variable v_nmi_end_flag est mise à
          la valeur NMI_FINISHED_TRUE à la fin de l'interruption NMI.  
~~~

##  M_VBLANK_WAIT

_./src/macros/vblankwait.inc_

**description**

~~~
 Boucle indéfiement tant que la valeur de PPU_STATUS n'indique pas 
          que la synchronisation verticale est finie 
~~~

