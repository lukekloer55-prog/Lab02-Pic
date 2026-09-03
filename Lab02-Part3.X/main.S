// Luke Kloer
// RCET 3373
// Lab 2 PIC16F883 I/O Familirization Part 3
// git url is : https://github.com/lukekloer55-prog/Lab02-Pic.git

; CONFIG1
CONFIG  FOSC = XT             ; Oscillator Selection bits (XT oscillator: Crystal/resonator on RA6/OSC2/CLKOUT and RA7/OSC1/CLKIN)
CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled and can be enabled by SWDTEN bit of the WDTCON register)
CONFIG  PWRTE = ON           ; Power-up Timer Enable bit (PWRT disabled)
CONFIG  MCLRE = ON            ; RE3/MCLR pin function select bit (RE3/MCLR pin function is MCLR)
CONFIG  CP = OFF              ; Code Protection bit (Program memory code protection is disabled)
CONFIG  CPD = OFF             ; Data Code Protection bit (Data memory code protection is disabled)
CONFIG  BOREN = OFF          ; Brown Out Reset Selection bits (BOR disabled)
CONFIG  IESO = OFF            ; Internal External Switchover bit (Internal/External Switchover mode is disabled)
CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enabled bit (Fail-Safe Clock Monitor is disabled)
CONFIG  LVP = OFF             ; Low Voltage Programming Enable bit (RB3 pin has digital I/O, HV on MCLR must be used for programming)

; CONFIG2
CONFIG  BOR4V = BOR40V        ; Brown-out Reset Selection bit (Brown-out Reset set to 4.0V)
CONFIG  WRT = OFF             ; Flash Program Memory Self Write Enable bits (Write protection off)

; Config statements should precede project file includes.
#include <xc.inc>
    
    Portbsnapshot EQU 0x20
        
; Reset Vector at 0000h. Execution starts here after reset.
 PSECT resetVect,class=CODE,delta=2
 ResetVector:
    NOP
    NOP
    NOP
    GOTO Setup
    
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
    MOVLW 0xFF ;Set the working register as a full 255 to be moved into the TRISB to make all the bits high to enable inputs.
    MOVWF 0x86 ;Set all HIgh for Inputs to be enabled.
    CLRF 0x95 ;Set all low for weak pull ups to be disabled.
    CLRF 0x96 ;Set all low for interrupt to be disabled.
    
    BCF 0x03,5 ;Set Bank 2
    BSF 0x03,6 ;Set Bank 2
    BSF 0x09,1 ;Set Bit 1 High for original state to be enabled.
    
    BSF 0x03,5 ;Set Bank 3
    BSF 0x03,6 ;Set Bank 3
    CLRF 0x89 ;Set all low for digital I/O Enabled.
    BSF 0x81,7 ;Set Bit 7 High to disable Pull-Up.
    CLRF 0x8B ;Set all low to disable interupts.
    
    ;Setup PORT C and disable unnecessary features. 
    BCF 0x03,5 ;Set Bank 0
    BCF 0x03,6 ;Set Bank 0
    CLRF 0x17 ;Set all low for capture/compare to be disabled
    CLRF 0x10 ;Set all low for capture/compare to be disabled
    MOVLW 0xFF ;Set the working register as a full 255 to be moved into the PORTC to make all the bits high to enable VIH inputs.
    MOVWF 0x07 ;Move in the full bits to enable the VIH inputs.
    CLRF 0x18 ;Set all low to disable serial readings and enable I/O ports.
    CLRF 0x10 ;Set all low to disable the timer feature.
    
    BSF 0x03,5 ;Set Bank 1
    BCF 0x03,6 ;Set Bank 1
    CLRF 0x9D ;Set all low for PWM disabled on Port C.
    CLRF 0x87 ;Set all low for outputs to be enabled on Port C.
 GOTO Main
    
Main: 
    ; Main code goes here
    Bittest:
	BCF 0x03,5 ;Set Bank 0 as Port B is located there.
	BCF 0x03,6 ;Set Bank 0 as Port B is located there.
	MOVF 0x06,0
	MOVWF Portbsnapshot
	BTFSC Portbsnapshot,7 ;Check Bit 7 on Port B and see if it a high or a low, If it high execute the next instruction will be executed, if not it will skip the next instruction.
	GOTO Bit7high ;If Bit 7 is high the execution will jump to the bit 7 high subroutine.
	BTFSC Portbsnapshot,6 ;Check Bit 6 on Port B and see if it a high or a low, If it high execute the next instruction will be executed, if not it will skip the next instruction.
	GOTO Bit6high ;If Bit 6 is high the execution will jump to the bit 6 high subroutine.
	BTFSC Portbsnapshot,5 ;Check Bit 5 on Port B and see if it a high or a low, If it high execute the next instruction will be executed, if not it will skip the next instruction.
	GOTO Bit5high ;If Bit 5 is high the execution will jump to the bit 5 high subroutine.
	BTFSC Portbsnapshot,4 ;Check Bit 4 on Port B and see if it a high or a low, If it high execute the next instruction will be executed, if not it will skip the next instruction.
	GOTO Bit4high ;If Bit 4 is high the execution will jump to the bit 4 high subroutine.
	BTFSC Portbsnapshot,3 ;Check Bit 3 on Port B and see if it a high or a low, If it high execute the next instruction will be executed, if not it will skip the next instruction.
	GOTO Bit3high ;If Bit 4 is high the execution will jump to the bit 4 high subroutine.
	BTFSC Portbsnapshot,2 ;Check Bit 2 on Port B and see if it a high or a low, If it high execute the next instruction will be executed, if not it will skip the next instruction.
	GOTO Bit2high ;If Bit 3 is high the execution will jump to the bit 3 high subroutine.
	BTFSC Portbsnapshot,1 ;Check Bit 1 on Port B and see if it a high or a low, If it high execute the next instruction will be executed, if not it will skip the next instruction.
	GOTO Bit1high ;If Bit 1 is high the execution will jump to the bit 1 high subroutine.
	BTFSC Portbsnapshot,0 ;Check Bit 0 on Port B and see if it a high or a low, If it high execute the next instruction will be executed, if not it will skip the next instruction.
	GOTO Bit0high ;If Bit 0 is high the execution will jump to the bit 0 high subroutine.
	GOTO Nobithigh ;If no bit is high it will exceute the subroutine to display the $.
	
	Bit7high: 
	    BCF 0x03,5 ;Set Bank 0 as Port C is located there.
	    BCF 0x03,6 ;Set Bank 0 as Port C is located there.
	    BCF 0x07,7 ;Set the Chip enable pin low to read the next input. 
	    MOVLW 0xB7 ;Load the hex value that is needed to get the correct colloumn and row value into the working register.
	    MOVWF 0x07 ;Load the hex value that is needed to get the correct colloumn and row value into Port C.
	    BSF 0x07,7 ;Set the Chip Enable Bit high to keep the light from flickering.
	GOTO Main
        Bit6high:
	    BCF 0x03,5 ;Set Bank 0 as Port C is located there.
	    BCF 0x03,6 ;Set Bank 0 as Port C is located there.
	    BCF 0x07,7 ;Set the Chip enable pin low to read the next input.
	    MOVLW 0xB6 ;Load the hex value that is needed to get the correct colloumn and row value into the working register.
	    MOVWF 0x07 ;Load the hex value that is needed to get the correct colloumn and row value into Port C.
	    BSF 0x07,7 ;Set the Chip Enable Bit high to keep the light from flickering.
	GOTO Main
	Bit5high:
	    BCF 0x03,5 ;Set Bank 0 as Port C is located there.
	    BCF 0x03,6 ;Set Bank 0 as Port C is located there.
	    BCF 0x07,7 ;Set the Chip enable pin low to read the next input.
	    MOVLW 0xB5 ;Load the hex value that is needed to get the correct colloumn and row value into the working register.
	    MOVWF 0x07 ;Load the hex value that is needed to get the correct colloumn and row value into Port C.
	    BSF 0x07,7 ;Set the Chip Enable Bit high to keep the light from flickering.
	GOTO Main
	Bit4high:
	    BCF 0x03,5 ;Set Bank 0 as Port C is located there.
	    BCF 0x03,6 ;Set Bank 0 as Port C is located there.
	    BCF 0x07,7 ;Set the Chip enable pin low to read the next input.
	    MOVLW 0xB4 ;Load the hex value that is needed to get the correct colloumn and row value into the working register.
	    MOVWF 0x07 ;Load the hex value that is needed to get the correct colloumn and row value into Port C.
	    BSF 0x07,7 ;Set the Chip Enable Bit high to keep the light from flickering.
	    
	GOTO Main
	Bit3high:
	    BCF 0x03,5 ;Set Bank 0 as Port C is located there.
	    BCF 0x03,6 ;Set Bank 0 as Port C is located there.
	    BCF 0x07,7 ;Set the Chip enable pin low to read the next input.
	    MOVLW 0xB3 ;Load the hex value that is needed to get the correct colloumn and row value into the working register.
	    MOVWF 0x07 ;Load the hex value that is needed to get the correct colloumn and row value into Port C.
	GOTO Main
	Bit2high:
	    BCF 0x03,5 ;Set Bank 0 as Port C is located there.
	    BCF 0x03,6 ;Set Bank 0 as Port C is located there.
	    BCF 0x07,7 ;Set the Chip enable pin low to read the next input.
	    MOVLW 0xB2 ;Load the hex value that is needed to get the correct colloumn and row value into the working register.
	    MOVWF 0x07 ;Load the hex value that is needed to get the correct colloumn and row value into Port C.
	    BSF 0x07,7 ;Set the Chip Enable Bit high to keep the light from flickering.
	GOTO Main
	Bit1high:
	    BCF 0x03,5 ;Set Bank 0 as Port C is located there.
	    BCF 0x03,6 ;Set Bank 0 as Port C is located there.
	    BCF 0x07,7 ;Set the Chip enable pin low to read the next input.
	    MOVLW 0xB1 ;Load the hex value that is needed to get the correct colloumn and row value into the working register.
	    MOVWF 0x07 ;Load the hex value that is needed to get the correct colloumn and row value into Port C.
	    BSF 0x07,7 ;Set the Chip Enable Bit high to keep the light from flickering.
	GOTO Main
	Bit0high:
	    BCF 0x03,5 ;Set Bank 0 as Port C is located there.
	    BCF 0x03,6 ;Set Bank 0 as Port C is located there.
	    BCF 0x07,7 ;Set the Chip enable pin low to read the next input.
	    MOVLW 0xB0 ;Load the hex value that is needed to get the correct colloumn and row value into the working register.
	    MOVWF 0x07 ;Load the hex value that is needed to get the correct colloumn and row value into Port C.
	    BSF 0x07,7 ;Set the Chip Enable Bit high to keep the light from flickering.
	GOTO Main
	Nobithigh:
	    BCF 0x03,5 ;Set Bank 0 as Port C is located there.
	    BCF 0x03,6 ;Set Bank 0 as Port C is located there.
	    BCF 0x07,7 ;Set the Chip enable pin low to read the next input.
	    MOVLW 0xA4 ;Load the hex value that is needed to get the correct colloumn and row value into the working register.
	    MOVWF 0x07 ;Load the hex value that is needed to get the correct colloumn and row value into Port C.
	    BSF 0x07,7 ;Set the Chip Enable Bit high to keep the light from flickering.
	GOTO Main
    GOTO Main