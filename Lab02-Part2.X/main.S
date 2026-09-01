// Luke Kloer
// RCET 3373
// Lab 2 PIC16F883 I/O Familirization Part 2
// git url is : 

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
    ;Setup Port B and disable unnecessary features.
    BCF 0x03,5 ;Set Bank 0
    BCF 0x03,6 ;Set Bank 0
    CLRF 0x17 ;Set all low for ccp to be disabled.
    
    BSF 0x03,5 ;Set Bank 1
    BCF 0x03,6 ;Set Bank 1
    CLRF 0x86 ;Set all low for output to be enabled.
    CLRF 0x95 ;Set all low for weak pull ups to be disabled.
    CLRF 0x96 ;Set all low for interrupt to be disabled.
    
    BCF 0x03,5 ;Set Bank 2
    BSF 0x03,6 ;Set Bank 2
    BSF 0x09,1 ;Set Bit 1 High for original state to be enabled.
    
    BSF 0x03,5 ;Set Bank 3
    BSF 0x03,6 ;Set Bank 3
    CLRF 0x87 ;Set all low for digital I/O Enabled.
    BSF 0x81,7 ;Set Bit 7 High to disable Pull-Up.
    CLRF 0x18B ;Set all low to disable interupts.
    
    BCF 0x03,5 ;Set Bank 0 to get to PORTB.
    BCF 0x03,6 ;Set Bank 0 to get to PORTB.
 goto Main
    
Main: 
    ; Main code goes here, including the increment loop.
    INCF 0x06,1 ;Increment on port B, then goto Main to continue the loop.
 goto Main