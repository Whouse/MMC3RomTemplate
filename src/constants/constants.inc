;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ CONSTANTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;@ desc     : Fichier contenant l'ensemble des constantes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; TODO : Envisager un découpage thématique PPU, APU, JOYPAD, RAM, etc


;;;;; PPU

PPU_CTRL   = $2000
PPU_MASK   = $2001
PPU_STATUS = $2002
OAM_ADDR   = $2003
OAM_DATA   = $2004
PPU_SCROLL = $2005
PPU_ADDR   = $2006
PPU_DATA   = $2007

PPU_NT1     = $2000     ;;   
PPU_NT2     = $2400     ;;  | NT1 | NT2 |
PPU_NT3     = $2800     ;;   -----------
PPU_NT4     = $2C00     ;;  | NT3 | NT4 |

PPU_OAM_DMA	    = $4014
; OAM local RAM copy goes from $0200-$02FF:
OAM_RAM = $0200

; PPU_CTRL flags
CTRL_NMI	    = %10000000	    ; Execute Non-Maskable Interrupt on VBlank
CTRL_8x8	    = %00000000 	; Use 8x8 Sprites
CTRL_8x16	    = %00100000 	; Use 8x16 Sprites
CTRL_BG_0000	= %00000000 	; Background Pattern Table at $0000 in VRAM
CTRL_BG_1000	= %00010000 	; Background Pattern Table at $1000 in VRAM
CTRL_SPR_0000	= %00000000 	; Sprite Pattern Table at $0000 in VRAM
CTRL_SPR_1000	= %00001000 	; Sprite Pattern Table at $1000 in VRAM
CTRL_INC_1	    = %00000000 	; Increment PPU Address by 1 (Horizontal rendering)
CTRL_INC_32	    = %00000100 	; Increment PPU Address by 32 (Vertical rendering)


; PPU_MASK flags
MASK_TINT_RED	= %00100000     ; Red Background
MASK_TINT_BLUE	= %01000000     ; Blue Background
MASK_TINT_GREEN	= %10000000     ; Green Background
MASK_SPR	    = %00010000     ; Sprites Visible
MASK_BG		    = %00001000     ; Backgrounds Visible
MASK_SPR_CLIP	= %00000100     ; Sprites clipped on left column
MASK_BG_CLIP	= %00000010     ; Background clipped on left column
MASK_COLOR	    = %00000000     ; Display in Color
MASK_MONO	    = %00000001     ; Display in Monochrome


; read flags
F_BLANK	  = %10000000   ; VBlank Active
F_SPRITE0 = %01000000 	; VBlank hit Sprite 0
F_SCAN8	  = %00100000 	; More than 8 sprites on current scanline
F_WIGNORE = %00010000 	; VRAM Writes currently ignored.




;;;;; APU

DMC_FREQ	    = $4010
APU_STATUS	    = $4015
APU_NOISE_VOL   = $400C
APU_NOISE_FREQ  = $400E
APU_NOISE_TIMER = $400F
APU_DMC_CTRL    = $4010
APU_CHAN_CTRL   = $4015
APU_FRAME       = $4017

APU_OAM_DMA = $4014




;;;;;; JOYPAD

JOYPAD1		= $4016
JOYPAD2		= $4017




;;;;;; HEADER

NES_MIRR_HORIZ	= 0
NES_MIRR_VERT	= 1
NES_MIRR_QUAD	= 8

NES_MAPPER_MMC3 = 4




;;;;;; MMC3

MMC3_MODE = $8000
MMC3_CTRL = $8001

MMC3_CHR_BANK_2K_0 = $00
MMC3_CHR_BANK_2K_1 = $01
MMC3_CHR_BANK_1K_2 = $02
MMC3_CHR_BANK_1K_3 = $03
MMC3_CHR_BANK_1K_4 = $04
MMC3_CHR_BANK_1K_5 = $05

MMC3_PRG_BANK_8K_0 = $06
MMC3_PRG_BANK_8K_1 = $07


;;;;;;; PARTIES DE CHRS A CHANGER

CHR_PART_0    = %00000001
CHR_PART_1    = %00000010
CHR_PART_2    = %00000100
CHR_PART_3    = %00001000
CHR_PART_4    = %00010000
CHR_PART_5    = %00100000
CHR_ALL_PARTS = %00111111


;;;;;; CONF 

CHR_ROM_BANKS_NB = $03
PRG_ROM_BANKS_NB = $04


;;;;;; NMI
NMI_FINISHED_FALSE = $00
NMI_FINISHED_TRUE  = $01