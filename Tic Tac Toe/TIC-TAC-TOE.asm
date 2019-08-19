.MODEL SMALL
.STACK 100H

CHECKWIN MACRO P1,P2,P3
    LOCAL PLYROWIN
    LOCAL PLYRXWIN
    LOCAL DRAWN
    LOCAL EXITN
    XOr BX,BX
    MOV BX,P1
    ADD BX,P2
    ADD BX,P3
    
    CMP BX,0
    JE PLYROWIN
    JNE PLYRXWIN
 PLYROWIN:
      CALL PLAYER2WIN
    
 PLYRXWIN:
    CMP BX,3
    JNE DRAWN
    CALL PLAYER1WIN
    
  DRAWN:
        CMP CHK1,5
        JE EXITN
        CMP CHK2,5
        JE EXITN
        CMP CHK3,5
        JE EXITN
        CMP CHK4,5
        JE EXITN
        CMP CHK5,5
        JE EXITN
        CMP CHK6,5
        JE EXITN
        CMP CHK7,5
        JE EXITN
        CMP CHK8,5
        JE EXITN
        CMP CHK9,5
        JE EXITN
        CALL MATCHDRAWN
    
  EXITN:
  ENDM


.DATA

        GAME DB "TIC TAC TOE $"
        PLAYER1 DB "PLAYER1: $"
        PLAYER2 DB "PLAYER2: $"
        ENTNAME DB "ENTER NAME OF PLAYERS $"
        NEWGAME DB "PRESS $"
        CONTGAME DB "PRESS $"
        WINS DB "WINS :D $"
        DRAWN DB "MATCH DRAWN $"
        MYCHAR DB ?
        INPLAYER1 DB 10 DUP (?)
        INPLAYER2 DB 10 DUP (?)
        ROW DB 15
        COLUMN DB 20
        ROW2 DB 18
        COLUMN2 DB 20
        LENGTH1 DB 0
        LENGTH2 DB 0
        WIN1 DB 0
        WIN2 DB 0
        X DW 40
        Y DW 50
        CHK1 DW 5
        CHK2 DW 5
        CHK3 DW 5
        CHK4 DW 5
        CHK5 DW 5
        CHK6 DW 5
        CHK7 DW 5
        CHK8 DW 5
        CHK9 DW 5 
        Z DW 1
    
        CONTMATCH1 DB "  PRESS C TO $"
        CONTMATCH2 DB "CONTINUE PLAYING $"
              
        NEWMATCH1 DB "  PRESS S TO $"
        NEWMATCH2 DB "START NEW MATCH $"          
        
        ARROW DB 16,"$"
        SPACE DB " $" 
 
        CHECKFLAG DB 0 
        DRAWNFLAG DB 0
  
        TURNX DB 1 
    
        FILENAME DB 'SAVEGAME.TXT', 0
   
        BUFFER DW 50 DUP(0), '$'
   
        HANDLE DW ?


.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

STARTNEWGAME:
; SeT graPhicS mOde 4
    MOV AH,0 ;SET MODE
    MOV AL,0
    INT 10H
    
    
    
;SeT bgd cOlOr TO cYan
    MOV AH, 0BH  ;BACKGROUND
    MOV BH, 00  ;SELECT BACK COLOR
    MOV BL, 0   ; SELECT COLOR 0 -15
    INT 10h    
    
        

        MOV AH, 2   ;MOVE CURSOR
        MOV BH, 0
        MOV DH, 2 ; ROW
        MOV DL, 15 ; COLUMN
        INT 10H
        
        
        MOV AH, 9
        MOV BL, 2
        LEA DX, GAME
        INT 21H  
      
             
    
        MOV AH, 02
        MOV BH, 0
        MOV DH, 10 ; ROW
        MOV DL, 10 ; COLUMN
        INT 10H 
    
    
        MOV AH, 9
        MOV BL, 2
        LEA DX, ENTNAME
        INT 21H 
     
     
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 15 ; ROW
        MOV DL, 10 ; COLUMN
        INT 10H 
    
    
        MOV AH, 9
        MOV BL, 2
        LEA DX, PLAYER1
        INT 21H
       
       
       
        MOV AH, 02
        MOV BH, 0
        MOV DH, 18 ; ROW
        MOV DL, 10 ; COLUMN
        INT 10H 
    
    
        MOV AH, 9
        LEA DX, PLAYER2
        INT 21H 
  
       

        
        
        LEA SI, INPLAYER1
        
   NAMEINPUT:
   
            MOV AH, 02
            MOV BH, 0
            MOV DH, ROW ; ROW
            MOV DL, COLUMN ; COLUMN
            INT 10H
            
       
            MOV AH, 0
            INT 16h
            ;CMP AL, 0AH
            MOV MYCHAR, AL
            CMP AH, 1CH
            JNE NOTENTER 
            JMP INPUT2
           
  NOTENTER:
            INC LENGTH1
            MOV [SI], AL
            INC SI
            MOV AH, 02
            MOV BH, 0
            MOV DH, ROW ; ROW
            MOV DL, COLUMN ; COLUMN
            INT 10H    
        
            MOV AH, 9
            MOV BL, 2 ; cOlOr vALue frOm PALeTTe
            MOV CX, 1
            INT 10h
            
            ;INC ROW
            INC COLUMN
            
            JMP NAMEINPUT
              
            INPUT2:
            
            MOV [SI], "$"
            MOV AH, 02
            MOV BH, 0
            MOV DH, ROW ; ROW
            MOV DL, COLUMN ; COLUMN
            INT 10H
            
            LEA DX, INPLAYER1
            MOV AH, 9
            INT 21H
            
            
            
            
            ; INPUT FOR 2ND PLAYER STARTS HERE
            
            
            LEA SI, INPLAYER2
            
   NAMEINPUT2:
   
            MOV AH, 02
            MOV BH, 0
            MOV DH, ROW2 ; ROW
            MOV DL, COLUMN2 ; COLUMN
            INT 10H
            
       
            MOV AH, 0
            INT 16h
            ;CMP AL, 0AH
            MOV MYCHAR, AL
            CMP AH, 1CH
            JNE NOTENTER2 
            JMP INPUT3
            
     NOTENTER2:
     
            INC LENGTH2
            MOV [SI], AL
            INC SI
            MOV AH, 02
            MOV BH, 0
            MOV DH, ROW2 ; ROW
            MOV DL, COLUMN2 ; COLUMN
            INT 10H    
        
            MOV AH, 9
            MOV BL, 2 ; cOlOr vALue frOm PALeTTe
            MOV CX, 1
            INT 10h
            
            ;INC ROW
            INC COLUMN2
            
            JMP NAMEINPUT2
         
            INPUT3:
            
            MOV [SI], "$"
            MOV AH, 02
            MOV BH, 0
            MOV DH, ROW2 ; ROW
            MOV DL, COLUMN2 ; COLUMN
            INT 10H
            
            LEA DX, INPLAYER2
            MOV AH, 9
            INT 21H
            
            
          
            CONTINUEGAME:   
            
            ;CLEAR SCREEN
            
            MOV AH, 6
            XOR AL, AL
            MOV CX, 0
            
            MOV DX, 184FH
            MOV BH, 7
            INT 10H
            
            
            ;GAME SCREEN
        
        MOV AH,0 ;SET MODE
        MOV AL,5
        INT 10H 
         
            
        MOV AH, 02
        MOV BH, 0
        MOV DH, 1 ; ROW
        MOV DL, 27 ; COLUMN
        INT 10H 
    
    
        MOV AH, 9
        LEA DX, INPLAYER1
        INT 21H
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 1 ; ROW
        MOV DL, 38 ; COLUMN
        INT 10H
        
        
        MOV AH, 9
        MOV DL, WIN1
        ADD DL, 30H
        MOV AL, DL
        MOV BL, 2 ; cOlOr vALue frOm PALeTTe
        MOV CX, 1
        INT 10h
        
        
        
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 3 ; ROW
        MOV DL, 27 ; COLUMN
        INT 10H 
    
    
        MOV AH, 9
        LEA DX, INPLAYER2
        INT 21H
        
        JMP QWERT
        
      
        
        QWERT:
        MOV AH, 02
        MOV BH, 0
        MOV DH, 3 ; ROW
        MOV DL, 38 ; COLUMN
        INT 10H
        
        
        MOV AH, 9
        MOV DL, WIN2
        ADD DL, 30H
        MOV AL, DL
        MOV BL, 2 ; cOlOr vALue frOm PALeTTe
        MOV CX, 1
        INT 10h
      
        
        
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 1 ; ROW
        MOV DL, 25 ; COLUMN
        INT 10H
        
        
        MOV AH, 9
        MOV AL, 16
        MOV BL, 2 ; cOlOr vALue frOm PALeTTe
        MOV CX, 1
        INT 10h
        
        
        JMP JKL
        
 
        
        
        
        
        
 
        
        
        
        
        
        CONTINUEGAME1:
            
            MOV AH, 6
            XOR AL, AL
            MOV CX, 0
            
            MOV DX, 184FH
            MOV BH, 7
            INT 10H
            
            
        MOV X, 40
        MOV Y, 50
        MOV CHK1, 5
        MOV CHK2, 5
        MOV CHK3, 5
        MOV CHK4, 5
        MOV CHK5, 5
        MOV CHK6, 5
        MOV CHK7, 5
        MOV CHK8, 5
        MOV CHK9, 5
         
        MOV Z, 1
        JMP CONTINUEGAME
        
        JKL:
        
        
        CALL DESIGN
        
        
        MOV AH,0CH
        MOV AL,2
        CALL DRAWBOX
        
        
        CALL SCAN
        
        MOV AH, 0
        INT 16H
        
        CMP AH,1FH
        JE STARTNEWGAME1
        
        CMP AH, 2EH
        JE CONTINUEGAME1
        
        
        
        STARTNEWGAME1:
            MOV AH, 6
            XOR AL, AL
            MOV CX, 0
            
            MOV DX, 184FH
            MOV BH, 7
            INT 10H         
            MOV ROW, 15
            MOV COLUMN, 20
            
            MOV ROW2, 18
            MOV COLUMN2, 20
            
            
        MOV X, 40
        MOV Y, 50
        MOV CHK1, 5
        MOV CHK2, 5
        MOV CHK3, 5
        MOV CHK4, 5
        MOV CHK5, 5
        MOV CHK6, 5
        MOV CHK7, 5
        MOV CHK8, 5
        MOV CHK9, 5
         
        MOV Z, 1
        MOV WIN1, 0
        MOV WIN2, 0
            
            MOV CHECKFLAG, 0      
            JMP STARTNEWGAME
        
       
                 
        MOV AH, 0 ; DOESNT SHOW THT SHIT PROGRAM HAS RETURNED SUCCESSFULLY AND BLAH BLAH BLAH.....
        INT 16h
        
        
      
        
        MOV AH, 4CH
        INT 21h
        
MAIN ENDP 
        
     


DESIGN PROC

        
     ;DRAW ROW
     MOV AH, 0CH  ;FOR WRITING PIXEL
     MOV AL,3
     MOV CX,40
     MOV DX,50
    
     R1:
     INT 10H
     INC CX
     CMP CX,160
     JLE R1
     
     DEC CX
     C4:
     INT 10H
     INC DX
     CMP DX,170
     JLE C4
     
     DEC DX
     R4:
     INT 10H
     DEC CX
     CMP CX, 40
     JG R4
     
     C1:
     INT 10H
     DEC DX
     CMP DX,50
     JG C1
     
     
     
     MOV CX,40
     MOV DX,90
    
     R2:
     INT 10H
     INC CX
     CMP CX,160
     JLE R2
     
     
     MOV CX,40
     MOV DX,130
     
     R3:
     INT 10H
     INC CX
     CMP CX,160
     JLE R3
     
     
     MOV CX,80
     MOV DX,50
     
     C2:
     INT 10H
     INC DX
     CMP DX,170
     JLE C2
     
     
     MOV CX,120
     MOV DX,50
     
     C3:
     INT 10H
     INC DX
     CMP DX,170
     JLE C3
     
     

 
    RET
    DESIGN  ENDP
    
    
    DRAWBOX PROC
    
    MOV CX,X
    MOV DX,Y
    MOV BX,X
    ADD BX,40
    
    B1:
        INT 10h
        INC CX
        CMP CX,BX
        JL B1
        
        MOV CX,X
        ADD DX,40
     B2:
        INT 10h
        INC CX
        CMP CX,BX
        JL B2
        MOV BX,DX
        MOV DX,Y
        MOV CX,X
     B3:
        INT 10h
        INC DX
        CMP DX,BX
        JL B3
        
        MOV DX,Y
        ADD CX,40
     B4:
        INT 10h
        INC DX
        CMP DX,BX
        JL B4
        
        RET
        DRAWBOX  ENDP
 

 
     
  SETX PROC
  
  
  CMP Z,1
  JNE S2
  CMP CHK1,5
  JNE ENDX
  MOV CHK1,1
  JMP ENDX
  
 S2:
   CMP Z,2
   JNE S3
   CMP CHK2,5
   JNE ENDX
   MOV CHK2,1
   JMP ENDX
 S3:
   CMP Z,3
   JNE S4
   CMP CHK3,5
   JNE ENDX
   MOV CHK3,1
   JMP ENDX
 
 S4:
   CMP Z,4
   JNE S5
   CMP CHK4,5
   JNE ENDX
   MOV CHK4,1
   JMP ENDX
 
 S5:
   CMP Z,5
   JNE S6
   CMP CHK5,5
   JNE ENDX
   MOV CHK5,1
   JMP ENDX
 ENDX:
    JMP ENDALL
 
 S6:
   CMP Z,6
   JNE S7
   CMP CHK6,5
   JNE ENDX
   MOV CHK6,1
   JMP ENDX
 
 S7:
   CMP Z,7
   JNE S8
   CMP CHK7,5
   JNE ENDX
   MOV CHK7,1
   JMP ENDX
 
 S8:
   CMP Z,8
   JNE S9
   CMP CHK8,5
   JNE ENDX
   MOV CHK8,1
   JMP ENDX
 S9:
   CMP Z,9
   JNE ENDX
   CMP CHK9,5
   JNE ENDX
   MOV CHK9,1
   JMP ENDX
   ENDALL:
    
  RET
SETX ENDP


PUTX PROC
    CMP CHK1,1
    JNE PUT2
  
    MOV DH,8
    MOV DL,7
    CALL DRAWX
    ;CALL ARROWX
    
   PUT2:
     CMP CHK2,1
     JNE PUT3
    
     MOV DH,8
     MOV DL,12
     CALL DRAWX
     ;CALL ARROWX2
  PUT3:
     CMP CHK3,1
     JNE PUT4
     MOV DH,8
     MOV DL,17
     CALL DRAWX
     ;CALL ARROWX3
  PUT4:
     CMP CHK4,1
     JNE PUT5
     MOV DH,13
     MOV DL,7
     CALL DRAWX
     ;CALL ARROWX4
  PUT5:
     CMP CHK5,1
     JNE PUT6
     MOV DH,13
     MOV DL,12
     CALL DRAWX
     ;CALL ARROWX5
  PUT6:
     CMP CHK6,1
     JNE PUT7
     MOV DH,13
     MOV DL,17
     CALL DRAWX
     ;CALL ARROWX
  PUT7:
     CMP CHK7,1
     JNE PUT8
     MOV DH,18
     MOV DL,7
     CALL DRAWX
     ;CALL ARROWX
  PUT8:
     CMP CHK8,1
     JNE PUT9
     MOV DH,18
     MOV DL,12
     CALL DRAWX
     ;CALL ARROWX
  PUT9:
     CMP CHK9,1
     JNE ENDPUT
     MOV DH,18
     MOV DL,17
     CALL DRAWX
     ;CALL ARROWX
  ENDPUT:
    
    RET
PUTX ENDP


SET_O PROC
  CMP Z,1
  JNE T2
  CMP CHK1,5
  JNE ENDO
  MOV CHK1,0
  JMP ENDO
  
 T2:
   CMP Z,2
   JNE T3
   CMP CHK2,5
   JNE ENDO
   MOV CHK2,0
   JMP ENDO
 T3:
   CMP Z,3
   JNE T4
   CMP CHK3,5
   JNE ENDO
   MOV CHK3,0
   JMP ENDO
 
 T4:
   CMP Z,4
   JNE T5
   CMP CHK4,5
   JNE ENDO
   MOV CHK4,0
   JMP ENDO
 
 T5:
   CMP Z,5
   JNE T6
   CMP CHK5,5
   JNE ENDO
   MOV CHK5,0
   JMP ENDO
 ENDO:
   JMP ENDALLO
 
 T6:
   CMP Z,6
   JNE T7
   CMP CHK6,5
   JNE ENDO
   MOV CHK6,0
   JMP ENDO
 
 T7:
   CMP Z,7
   JNE T8
   CMP CHK7,5
   JNE ENDO
   MOV CHK7,0
   JMP ENDO
 
 T8:
   CMP Z,8
   JNE T9
   CMP CHK8,5
   JNE ENDO
   MOV CHK8,0
   JMP ENDO
 T9:
   CMP Z,9
   JNE ENDO
   CMP CHK9,5
   JNE ENDO
   MOV CHK9,0
   JMP ENDO
 ENDALLO:
    
  RET
SET_O ENDP

PUT_O PROC
    CMP CHK1,0
    JNE PUTO2
    MOV DH,8
    MOV DL,7
    CALL DRAWO
    ;CALL ARROWY
    
   PUTO2:
     CMP CHK2,0
     JNE PUTO3
     MOV DH,8
     MOV DL,12
     CALL DRAWO
     ;CALL ARROWY2
   PUTO3:
     CMP CHK3,0
     JNE PUTO4
     MOV DH,8
     MOV DL,17
     CALL DRAWO
     ;CALL ARROWY3
   PUTO4:
     CMP CHK4,0
     JNE PUTO5
     MOV DH,13
     MOV DL,7
     CALL DRAWO
     ;CALL ARROWY4
  PUTO5:
     CMP CHK5,0
     JNE PUTO6
     MOV DH,13
     MOV DL,12
     CALL DRAWO
     ;CALL ARROWY5
  PUTO6:
     CMP CHK6,0
     JNE PUTO7
     MOV DH,13
     MOV DL,17
     CALL DRAWO
     ;CALL ARROWY
  PUTO7:
     CMP CHK7,0
     JNE PUTO8
     MOV DH,18
     MOV DL,7
     CALL DRAWO
     ;CALL ARROWY
  PUTO8:
     CMP CHK8,0
     JNE PUTO9
     MOV DH,18
     MOV DL,12
     CALL DRAWO
     ;CALL ARROWY
  PUTO9:
     CMP CHK9,0
     JNE ENDPUTO
     MOV DH,18
     MOV DL,17
     CALL DRAWO
    ; CALL ARROWY
  ENDPUTO:
    
    RET
    
PUT_O ENDP    
    
DRAWX PROC
    
        MOV AH, 02
        MOV BH, 0
        INT 10h
; wriTe char        
        MOV AH, 9
        MOV AL, 'X'
        MOV BL, 1 ; cOlOr Blue
        MOV CX, 1
        INT 10H  
        
        CALL ARROWX
        
  RET
  
  DRAWX ENDP
  
  
ARROWX PROC
    

    MOV AH, 02
    MOV BH, 0
        MOV DH, 3 ; ROW
        MOV DL, 25 ; COLUMN
        INT 10H
        
        
        MOV AH, 9
        MOV AL, 16
        MOV BL, 2 ; cOlOr vALue frOm PALeTTe
        MOV CX, 1
        INT 10h
        
         
        MOV AH, 02
        MOV BH, 0
        MOV DH, 1 ; ROW
        MOV DL, 25 ; COLUMN
        INT 10H
        
        
        MOV AH, 9
        MOV AL, " "
        MOV BL, 2 ; cOlOr vALue frOm PALeTTe
        MOV CX, 1
        INT 10h


RET
ARROWX ENDP 



ARROWY PROC
    

    MOV AH, 02
        MOV BH, 0
        MOV DH, 1 ; ROW
        MOV DL, 25 ; COLUMN
        INT 10H
        
        
        MOV AH, 9
        MOV AL, 16
        MOV BL, 2 ; cOlOr vALue frOm PALeTTe
        MOV CX, 1
        INT 10h
        
        
        
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 3 ; ROW
        MOV DL, 25 ; COLUMN
        INT 10H
        
        
        MOV AH, 9
        MOV AL, " "
        MOV BL, 2 ; cOlOr vALue frOm PALeTTe
        MOV CX, 1
        INT 10h


RET
ARROWY ENDP

  
  

DRAWO PROC


        MOV AH, 02
        MOV BH, 0
        INT 10h
; wriTe char        
        MOV AH, 9
        MOV AL, 'O'
        MOV BL, 0EH ; cOlOr YellO
        MOV CX, 1
        INT 10H  
        
        CALL ARROWY   
 
  RET
  
  DRAWO ENDP
 
SCAN PROC


     MAINWORK:
     
     
     MOV AL, CHECKFLAG
     CMP AL, 1
     JE EXIT1
     
     CALL PUTX
     
     CALL PUT_O
     
     CALL RESULTCHECK
     
     
     MOV AH,0
     INT 16h
     
     MOV AL, CHECKFLAG
     CMP AL, 1
     JE EXIT1
     
     WORKIF:
     
     CMP AH,77
     JE RIGHT
     CMP AH,75
     JE LEFT
     CMP AH,80
     JE DOWN1
     CMP AH,72
     JE UP
     
     
     
     CMP AH,45
     JE SCANX
     CMP AH,24
     JE SCANO
    
  RIGHT:
     CMP X,120
     jge MAINWORK
     MOV AH,0CH
     MOV AL,3
     CALL DRAWBOX
     ADD X,40
     ADD Z,1
     MOV AH,0CH
     MOV AL,2
     CALL DRAWBOX
     JMP MAINWORK
     
     EXIT1:
     JMP EXIT2
     
   MAINWORK2:
    JMP MAINWORK  
     
  LEFT:
    CMP X,40
    JLe MAINWORK2
     MOV AH,0CH
     MOV AL,3
     CALL DRAWBOX
     Sub X,40
     Sub Z,1
     MOV AH,0CH
     MOV AL,2
     CALL DRAWBOX
     JMP MAINWORK
     
     
     
   SCANX:
     CALL SETX
     JMP MWORK3
     
   SCANO:
     CALL SET_O
     JMP MWORK3
     
   DOWN1:
      JMP DOWN
     
  UP:
  CMP Y,50
     JLe MWORK3
     MOV AH,0CH
     MOV AL,3
     CALL DRAWBOX
     Sub Y,40
     Sub Z,3
     MOV AH,0CH
     MOV AL,2
     CALL DRAWBOX
     JMP MAINWORK
  
   MWORK3:
    JMP MAINWORK
    
  EXIT2:
    MOV CHECKFLAG, 0
    JMP EXIT  
   
  DOWN:
  CMP Y,130
     jge MWORK3
     MOV AH,0CH
     MOV AL,3
     CALL DRAWBOX
     ADD Y,40
     ADD Z,3
     MOV AH,0CH
     MOV AL,2
     CALL DRAWBOX
     JMP MWORK3
     
    
    EXIT:   
    RET

SCAN ENDP  



PLAYER1WIN PROC
        
        MOV DRAWNFLAG, 1
    
        INC WIN1
        MOV AH, 02
        MOV BH, 0
        MOV DH, 8
        MOV DL, 27
        INT 10h
; wriTe char

        MOV AH, 9
        LEA DX, INPLAYER1        
        INT 21H
        
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 26
        INT 10h
; wriTe char

        MOV AH, 9
        LEA DX, WINS        
        INT 21H
        
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 1 ; ROW
        MOV DL, 38 ; COLUMN
        INT 10H
        
        
        MOV AH, 9
        MOV DL, WIN1
        ADD DL, 30H
        MOV AL, DL
        MOV BL, 2 ; cOlOr vALue frOm PALeTTe
        MOV CX, 1
        INT 10h
        
        MOV CHECKFLAG, 1
        
        
        CALL PRINTMATCH
             
        
        RET
        
PLAYER1WIN ENDP        
        
PLAYER2WIN PROC

       MOV DRAWNFLAG, 1 

        INC WIN2
       MOV AH, 02
        MOV BH, 0
        MOV DH, 8
        MOV DL, 27
        INT 10h
; wriTe char

        MOV AH, 9
        LEA DX, INPLAYER2        
        INT 21H
        
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 26
        INT 10h
; wriTe char

        MOV AH, 9
        LEA DX, WINS        
        INT 21H
        
        
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 3 ; ROW
        MOV DL, 38 ; COLUMN
        INT 10H
        
        
        MOV AH, 9
        MOV DL, WIN2
        ADD DL, 30H
        MOV AL, DL
        MOV BL, 2 ; cOlOr vALue frOm PALeTTe
        MOV CX, 1
        INT 10h
        
        
        MOV CHECKFLAG, 1
        
        CALL PRINTMATCH
      
        RET
        
  PLAYER2WIN ENDP      
  
MATCHDRAWN PROC

        CMP DRAWNFLAG, 1
        JE DXX
        MOV AH, 02
        MOV BH, 0
        MOV DH, 10
        MOV DL, 24
        INT 10h
        
        
        MOV AH, 9
        LEA DX, DRAWN        
        INT 21H 
        
        DXX:
        
        MOV CHECKFLAG, 1
     
        CALL PRINTMATCH   
        
        RET  
   
        MATCHDRAWN ENDP  
        
        
PRINTMATCH PROC   
        MOV AH, 2
        MOV BH, 0
        MOV DH, 14
        MOV DL, 24
        INT 10h
; wriTe char

        MOV AH, 9
        LEA DX, CONTMATCH1        
        INT 21H
        
        
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 16
        MOV DL, 23
        INT 10h
; wriTe char

        MOV AH, 9
        LEA DX, CONTMATCH2        
        INT 21H
        
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 19
        MOV DL, 24
        INT 10h
; wriTe char

        MOV AH, 9
        LEA DX, NEWMATCH1        
        INT 21H
        
        
        MOV AH, 02
        MOV BH, 0
        MOV DH, 21
        MOV DL, 23
        INT 10h
; wriTe char

        MOV AH, 9
        LEA DX, NEWMATCH2        
        INT 21H
        
        
   RET

PRINTMATCH ENDP   

     
 

RESULTCHECK PROC
    CHECKWIN CHK1,CHK2,CHK3
    CHECKWIN CHK4,CHK5,CHK6
    CHECKWIN CHK7,CHK8,CHK9
    CHECKWIN CHK1,CHK4,CHK7
    CHECKWIN CHK2,CHK5,CHK8
    CHECKWIN CHK3,CHK6,CHK9
    CHECKWIN CHK1,CHK5,CHK9
    CHECKWIN CHK7,CHK5,CHK3
    RET

    RESULTCHECK ENDP    
   
    
    
    
    END MAIN