// Luke Kloer
// RCET 3373
// First Program
// git url is : \
// -Wl,-presetVect=0000h,-pcode=0008h. This is the reset vector locations for the linker.

; CONFIG1
CONFIG  FOSC = XT             ; Oscillator Selection bits (XT oscillator: Crystal/resonator on RA6/OSC2/CLKOUT and RA7/OSC1/CLKIN)
CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled and can be enabled by SWDTEN bit of the WDTCON register)
CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
CONFIG  MCLRE = ON            ; RE3/MCLR pin function select bit (RE3/MCLR pin function is MCLR)
CONFIG  CP = OFF              ; Code Protection bit (Program memory code protection is disabled)
CONFIG  CPD = OFF             ; Data Code Protection bit (Data memory code protection is disabled)
CONFIG  BOREN = OFF           ; Brown Out Reset Selection bits (BOR disabled)
CONFIG  IESO = OFF            ; Internal External Switchover bit (Internal/External Switchover mode is disabled)
CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enabled bit (Fail-Safe Clock Monitor is disabled)
CONFIG  LVP = OFF             ; Low Voltage Programming Enable bit (RB3 pin has digital I/O, HV on MCLR must be used for programming)

; CONFIG2
CONFIG  BOR4V = BOR40V        ; Brown-out Reset Selection bit (Brown-out Reset set to 4.0V)
CONFIG  WRT = OFF             ; Flash Program Memory Self Write Enable bits (Write protection off)

; Config statements should precede project file includes.
#include <xc.inc>
        
; Reset Vector at 0000h. Execution starts here after reset.
 PSECT resetVect,class=CODE,delta=2
 ResetVector:
    NOP
    NOP
    NOP
    goto Setup
    
; Main Code section starts at 0008h. User code goes here.
PSECT code,class=CODE,delta=2

; Add device setup here
Setup: 
    
   
 goto Main
    
Main: 
    ; Main code goes here
    
 goto Main
    