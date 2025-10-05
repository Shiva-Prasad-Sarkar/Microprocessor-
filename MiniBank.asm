.MODEL SMALL  
 
.STACK 100H

.DATA

;======================================================================================================     
    ID DB 1,2,3,4,5    
    PASSWORD DB 'ADITI','SHIVA','12345','ABCDE','PASSW'  
    LID DB 1   
                       
    HISTORY DB 30 DUP(?) 
    INDEX DW 0 
                 
    COUNTER DW  0
    TAKA DW 100 
    VAR DW 0 
    YEARS DW 0 
    RATE DW 0         
    
    DIPOSIT_MSG DB "DIPOSIT OF $"
    WITHDRAW_MSG DB "WITHDRAWAL $"  
    LOAN_MSG DB "TOOK LOAN OF $"
    FD_MSG DB "MADE AN FD OF $" 
    NO_HIS DB "NO TRANSACTIONS YET$"
    
    A DB "                         --WELCOME TO MINIBANK 8086-- $"
    B DB "PLEASE ENTER YOUR ID & PASSWORD TO LOGIN$"
    C DB "ID (1 DIGIT) : $" 
    D DB "PASSWORD (5 CHARACTERS) : $"  
    
    IDNO DB "ID DIDN'T MATCH$" 
    IDNA DB "PASSWORD DIDN'T MATCH$"    
    ENTRS DB "PLEASE CHOOSE A CORRECT OPTION$"
    
    LOG DB "YOU HAVE SUCCESSFULLY LOGGED IN !! $"  
    
    ENT DB "ENTER OPTION NO: $" 
    ENTT DB "ENTER YOUR OPTION: $"
    
    ONE DB "1. CHECK BALANCE $"
    TWO DB "2. DEPOSITE MONEY $" 
    THREE DB "3. WITHDRAW MONEY $" 
    FOUR DB "4. FIXED DEPOSIT SCHEME$"    
    FIVE DB "5. LOAN INFORMATION$"
    SIX DB "6. SHOW RECENT TRANSACTION$"
    SEVEN DB "7. LOGOUT $"       
    
    
    ONEE DB "YOUR CURRENT BALANCE: $" 
    THREEE DB "WITHDRAW AMOUNT<MAX 999): $"
    LIM DB "BALANCE IS MAXIMUM LIMIT CROSSING, CAN'T DEPOSIT NOW !!$"
    TWOO DB "DEPOSIT AMOUNT (MAX 999) : $"     
    ENOUGH DB "YOU DON'T HAVE ENOUGH BALANCE TO WITHDRAW ! $" 
    
    SUCC DB "AMOUNT DEPOSITED SUCCESSFULLY$"  
    WITD DB "WITHDRAWAL SUCCESSFUL$"
    
    AGAIN DB "1. MAIN MENU ..!! $"
    LOGOUT DB "2. LOGOUT ! $"       
    LGT DB "LOGOUT SUCCESSFULLY$"
     
    
    NO_LOAN DB "YOU MUST DEPOSIT SOME MONEY TO YOUR ACCOUNT TO ENJOY OUR LOAN FACILITY ! THANK YOU !! $"
    FIX DB "WOULD YOU LIKE TO PLACE YOUR MONEY IN A FIX DEPOSIT ? ( Y / N ) $"
    STUDENT DB "1. ARE YOU A STUDENT ? ( 5% INTEREST PER YEAR ) !$"
    JOB DB "2. ARE YOU A JOB HOLDER ? ( 3% INTEREST PER YEAR ) !$"
    RETIRED DB "3. ARE YOU RETIRED ? ( 7% INTEREST PER YEAR ) !$"  
    YEAR DB "ENTER NUMBER OF YEARS ( BETWEEN 1 TO 9 ) : $" 
    
    FDMSG DB "EXPECTED TOTAL AMOUNT AFTER FIXED DEPOSIT: $"
    LOANMSG DB "EXPECTED AMOUNT TO BE PAID AFTER TAKING LOAN: $"   
    
    
    THANK DB "THANKS FOR USING MINIBANK !!!! $"
    GREAT DB "HAVE A GREAT DAY !!! $" 
    
    RETRY DB "1. RETRY ? $"
    EXITTT DB "2. EXIT $"
    
    ASK DB "DO YOU WANT TO CREATE FIXED DEPOSIT ACCOUNT? ( Y / N ) $" 
    ASKK DB "DO YOU WANT TO TAKE LOAN ? ( Y / N ) $"
    CREATED DB "CONGRATS ! FIXED DEPOSITE CREATED FOR YEARS: $"
    LOAN_CREATED DB "CONGRATS ! YOUR LOAN IS APPROVED SUCCESSFULLY ! YEARS = $"   
    
    STUDENTT DB "1. ARE YOU A STUDENT ? ( 2% INTEREST PER YEAR ) !$"
    JOB_B DB "2. ARE YOU A JOB HOLDER ? ( 8% INTEREST PER YEAR ) !$"
    RETIREDD DB "3. ARE YOU RETIRED ? ( 3% INTEREST PER YEAR ) !$"  
    ALREADY DB "YOU ARE ALREADY ENJOYING OUR LOAN FACILITY ! GO TO DEPOSIT OPTION TO PAY YOUR PREVIOUS LOAN FIRST ! $"   
    
    
    
    RENTT DB "DO YOU WANT TO GIVE A RATING(Y/N? $"
    RNTR DB "PLEASE ENTER YOUR REVIEW(0 TO 5) : $"
    TNK DB "THANKS FOR YOUR REVIEW!$"  
    
    
;============================================================================================================ 
    
    
.CODE
MAIN PROC

MOV AX,@DATA
MOV DS,AX
 

MOV AH , 9 
LEA DX , A
INT 21H   

CALL PRINT_NEW_LINE  

FIRST: 
CALL PRINT_NEW_LINE 

MOV AH , 9
LEA DX , B
INT 21H

CALL PRINT_NEW_LINE

MOV AH , 9 
LEA DX , C
INT 21H 
MOV AH , 1
INT 21H
SUB AL , 48 
MOV DL, AL  


MOV LID, AL 
SUB LID, 1 
MOV AL,5
MUL LID

MOV LID,AL 

MOV AL,DL

MOV SI , 0 
MOV CX , 5
MOV BL , 0 
 
CHECK_ID:
    CMP ID[SI] , AL 
    JE INCREM
    INC SI
    LOOP CHECK_ID
    JMP K 
    INCREM:
        ADD BL , 1 
        
K:        
CMP BL , 1 
JNE ID_NO_MATCH  

CALL PRINT_NEW_LINE

MOV AH , 9 
LEA DX , D
INT 21H 



MOV CX , 5  
MOV AL, LID
MOV AH,0
MOV SI , AX
MOV BL , 0  


NAME_CHECK:
    MOV AH , 1 
    INT 21H          
    CMP AL , PASSWORD[SI]
    JNE NEXT
    INC BL   
                                   
    NEXT:
        INC SI
        LOOP NAME_CHECK  
    

CMP BL , 5
JE LOGIN  

JNE NAME_NO_MATCH
    

ID_NO_MATCH:
    CALL PRINT_NEW_LINE  
    
    LEA DX , IDNO
    MOV AH , 9 
    INT 21H   
    
    CALL PRINT_NEW_LINE
    MOV AH , 9 
    LEA DX , RETRY 
    INT 21H
    CALL PRINT_NEW_LINE
    MOV AH , 9 
    LEA DX , EXITTT
    INT 21H 
    CALL PRINT_NEW_LINE   
    
    AF:
    
    MOV AH,9
    LEA DX, ENT
    INT 21H
    
    MOV AH , 1 
    INT 21H
    
    CMP AL , 49  
    JE FIRST 
    
    CMP AL , 50
    JE EXITT 
    
    CALL PRINT_NEW_LINE 
    MOV AH , 9 
    LEA DX , ENTRS
    INT 21H   
    CALL PRINT_NEW_LINE   
    JMP AF
    
    
     
NAME_NO_MATCH:
    CALL PRINT_NEW_LINE
    LEA DX , IDNA
    MOV AH , 9 
    INT 21H
    CALL PRINT_NEW_LINE
    MOV AH , 9 
    LEA DX , RETRY 
    INT 21H
    CALL PRINT_NEW_LINE
    MOV AH , 9 
    LEA DX , EXITTT
    INT 21H 
    CALL PRINT_NEW_LINE    
    
    AFF:
    
    MOV AH,9
    LEA DX, ENT
    INT 21H
    
    MOV AH , 1 
    INT 21H
    
    CMP AL , 49  
    
    JE FIRST
    CMP AL , 50
    JE EXITT  
    
    CALL PRINT_NEW_LINE 
    MOV AH , 9 
    LEA DX , ENTRS
    INT 21H   
    CALL PRINT_NEW_LINE   
    JMP AFF
        
    
LOGIN:
    CALL PRINT_NEW_LINE
    LEA DX , LOG
    MOV AH , 9 
    INT 21H

; ---------------------------------------------------------------

AGAINNN:

CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , ONE 
INT 21H
CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , TWO 
INT 21H
CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , THREE 
INT 21H
CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , FOUR 
INT 21H
CALL PRINT_NEW_LINE 
MOV AH , 9 
LEA DX ,FIVE 
INT 21H 
CALL PRINT_NEW_LINE      
MOV AH , 9 
LEA DX ,SIX 
INT 21H 
CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX ,SEVEN 
INT 21H 
CALL PRINT_NEW_LINE  


ENTRR:

MOV AH , 9 
LEA DX , ENT
INT 21H
MOV AH , 1 
INT 21H 
SUB AL , 48 

CMP AL , 1 
JE BALANCE
CMP AL , 2 
JE DEPOSIT
CMP AL , 3 
JE WITHDRAW
CMP AL , 4
JE FIXEDDEPO 
CMP AL, 5
JE LOANN
CMP AL, 6
JE HISTORYY
CMP AL , 7
JE EXIT  

CALL PRINT_NEW_LINE 
MOV AH , 9 
LEA DX , ENTRS
INT 21H   
CALL PRINT_NEW_LINE   
JMP ENTRR


;------------------------------------------------- 

BALANCE:    
    CALL PRINT_NEW_LINE 
    MOV AH , 9 
    LEA DX , ONEE
    INT 21H
    MOV AX , TAKA
    CALL PRINT_TAKA 
    JMP FR

;-------------------------------------------------

DEPOSIT: 
    MOV COUNTER , 0
    CALL PRINT_NEW_LINE 
    MOV CX , 0 
    MOV VAR , CX
    MOV AH , 9 
    LEA DX , TWOO
    INT 21H  
    
    MOV AH , 1
    INT 21H
    SUB AL , 48
    MOV BL , 100 
    MUL BL
    ADD VAR , AX
    MOV AH , 1
    INT 21H
    SUB AL , 48
    MOV BL , 10 
    MUL BL
    ADD VAR , AX
    MOV AH , 1
    INT 21H
    SUB AL , 48
    MOV BL , 1 
    MUL BL
    ADD VAR , AX 
    MOV BX , VAR  
        
    
    MOV AX, TAKA
    ADD AX, BX  
                
    CMP TAKA, 10000
    JG OVERFLOW  
    
    
    MOV SI , INDEX 
    MOV HISTORY[SI] , '+'
    INC SI
    MOV HISTORY[SI] , BL
    MOV HISTORY[SI+1] , BH
    ADD SI , 2 
    MOV INDEX , SI
        
       
    MOV TAKA, AX
    MOV AX , TAKA 
    
    CALL PRINT_NEW_LINE   
    MOV AH , 9 
    LEA DX , SUCC
    INT 21H 
       
    JMP BALANCE

    OVERFLOW:
        CALL PRINT_NEW_LINE
        MOV AH, 9
        LEA DX, LIM         
        INT 21H
        JMP FR
    
;------------------------------------------------------------------------
 
WITHDRAW:
    CALL PRINT_NEW_LINE
    MOV CX , 0 
    MOV VAR , CX 
    MOV AH , 9 
    LEA DX , THREEE
    INT 21H
    MOV AH , 1
    INT 21H
    SUB AL , 48
    MOV BL , 100 
    MUL BL
    ADD VAR , AX
    MOV AH , 1
    INT 21H
    SUB AL , 48
    MOV BL , 10 
    MUL BL
    ADD VAR , AX
    MOV AH , 1
    INT 21H
    SUB AL , 48
    MOV BL , 1
    MUL BL
    ADD VAR , AX 
    
    MOV BX , VAR    
    MOV AX, TAKA
    CMP BX , AX
    JG NOT_ENOUGH
    
    MOV SI , INDEX 
    MOV HISTORY[SI] , '-'
    INC SI
    MOV HISTORY[SI] , BL
    MOV HISTORY[SI+1] , BH
    ADD SI , 2 
    MOV INDEX , SI 
     
    SUB AX, BX
    JC OVERFLOW         
    MOV TAKA, AX
    MOV AX , TAKA  
    CALL PRINT_NEW_LINE 
    MOV AH , 9 
    LEA DX , WITD
    INT 21H 
    

        
    JMP BALANCE
    JMP FR

    NOT_ENOUGH:
        CALL PRINT_NEW_LINE
        MOV AH, 9
        LEA DX,ENOUGH          
        INT 21H       
        
;--------------------------------------------------------------------
    
FR:    
CALL PRINT_NEW_LINE 
MOV AH , 9 
LEA DX , AGAIN 
INT 21H
CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , LOGOUT
INT 21H 
CALL PRINT_NEW_LINE     

RE:
MOV AH , 9
LEA DX , ENT
INT 21H
MOV AH , 1 
INT 21H
SUB AL , 48
CMP AL , 1 
JE AGAINNN 
CMP AL , 2
JE EXIT  


CALL PRINT_NEW_LINE 
MOV AH , 9 
LEA DX , ENTRS
INT 21H   
CALL PRINT_NEW_LINE  
JMP RE

; ------------------------------------------------------------------------

FIXEDDEPO:
CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , FIX
INT 21H 
CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , ENTT
INT 21H 
MOV AH , 1 
INT 21H 
CMP AL , 'N'
JE FR 
JMP YES

YES:
    CALL PRINT_NEW_LINE
    MOV AH , 9 
    LEA DX , STUDENT 
    INT 21H
    CALL PRINT_NEW_LINE
    MOV AH , 9 
    LEA DX , JOB 
    INT 21H 
    CALL PRINT_NEW_LINE
    MOV AH , 9
    LEA DX , RETIRED
    INT 21H 
    CALL PRINT_NEW_LINE
    MOV AH , 9 
    LEA DX , ENT
    INT 21H
    MOV AH , 1 
    INT 21H
    CALL PRINT_NEW_LINE
    MOV BL , AL
    SUB BL , 48     ;
    MOV AH , 9 
    LEA DX , YEAR
    INT 21H
    MOV AH , 1 
    INT 21H
    SUB AL , 48
    MOV AH , 0  
    MOV YEARS , AX
    CALL PRINT_NEW_LINE  
   
    
    CMP BL , 1
    JE STUD
    CMP BL , 2 
    JE JOBB
    CMP BL , 3 
    JE RETIRE 
    
    
    
    
    STUD:
        MOV BX , 5
        JMP CALC_FD
    JOBB:
        MOV BX , 3 
        JMP CALC_FD
    RETIRE:
        MOV BX , 7
        JMP CALC_FD
    
    
CALC_FD:
    
    MOV BH , 0
    MOV SI, BX 
    CALL PRINT_NEW_LINE
    MOV AH, 9
    LEA DX, ONEE
    INT 21H
    MOV AX, TAKA        
    CALL PRINT_TAKA
    CALL PRINT_NEW_LINE
    
    MOV AX , TAKA
    MOV CX, YEARS                 
    MOV BX , 100
    MOV DI , TAKA

FD_LOOP:
    MOV DX, 0         
    MUL SI            
    DIV BX            
    ADD AX, TAKA     
    MOV TAKA, AX      
    LOOP FD_LOOP 
       

      
MOV AH, 9
LEA DX, FDMSG       
INT 21H 
MOV AX , TAKA
CALL PRINT_TAKA
MOV TAKA , DI          


CALL PRINT_NEW_LINE 
MOV AH , 9 
LEA DX , ASK
INT 21H 
CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , ENT
INT 21H
MOV AH , 1
INT 21H

CMP AL , 'Y'
JE DO_FD
MOV VAR , 0
JMP FR


DO_FD: 
    MOV BX, TAKA 

    MOV SI , INDEX 
    MOV HISTORY[SI] , '*'
    INC SI
    MOV HISTORY[SI] , BL
    MOV HISTORY[SI+1] , BH
    ADD SI , 2 
    MOV INDEX , SI  
    
    
MOV TAKA , 0 
CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , CREATED 
INT 21H 
MOV AX , YEARS 
CALL PRINT_TAKA
CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , ONEE
INT 21H
MOV AX , TAKA 
CALL PRINT_TAKA

CALL PRINT_NEW_LINE
JMP FR 


;=================================================
   
LOANN:
    CALL PRINT_NEW_LINE
    MOV AX , TAKA 
    CMP AX , 0 
    JE NOT_LOAN
    MOV AH , 9 
    LEA DX , STUDENTT 
    INT 21H
    CALL PRINT_NEW_LINE
    MOV AH , 9 
    LEA DX , JOB_B 
    INT 21H 
    CALL PRINT_NEW_LINE
    MOV AH , 9
    LEA DX , RETIREDD
    INT 21H 
    CALL PRINT_NEW_LINE
    MOV AH , 9 
    LEA DX , ENT
    INT 21H
    MOV AH , 1 
    INT 21H 
    MOV BL , AL
    SUB BL , 48      
    CALL PRINT_NEW_LINE
    MOV AH , 9 
    LEA DX , YEAR
    INT 21H
    MOV AH , 1 
    INT 21H
    SUB AL , 48
    MOV AH , 0  
    MOV YEARS , AX
    CALL PRINT_NEW_LINE 
    
    
    CMP BL , 1
    JE STUDD
    CMP BL , 2 
    JE JOBBB
    CMP BL , 3 
    JE RETIREE
    
    STUDD:
        MOV BX , 2
        JMP CALC_LOAN
    JOBBB:
        MOV BX , 8 
        JMP CALC_LOAN
    RETIREE:
        MOV BX , 3
        JMP CALC_LOAN
    
    
CALC_LOAN:    
    MOV BH , 0
    MOV SI, BX 
    CALL PRINT_NEW_LINE
    MOV AH, 9
    LEA DX, ONEE
    INT 21H
    MOV AX, TAKA        
    CALL PRINT_TAKA
    CALL PRINT_NEW_LINE
    
    MOV AX , TAKA
    MOV CX, YEARS                 
    MOV BX , 100
    MOV DI , TAKA

LOAN_LOOP:
    MOV DX, 0         
    MUL SI            
    DIV BX            
    ADD AX, TAKA     
    MOV TAKA, AX      
    LOOP LOAN_LOOP      



      
MOV AH, 9
LEA DX, LOANMSG       
INT 21H 
MOV AX , TAKA 
MOV VAR , AX
CALL PRINT_TAKA
MOV TAKA , DI          


CALL PRINT_NEW_LINE 
MOV AH , 9 
LEA DX , ASKK
INT 21H 
CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , ENT
INT 21H
MOV AH , 1
INT 21H

CMP AL , 'Y'
JE DO_LOAN
MOV VAR , 0
JMP FR


DO_LOAN:  

     
    
    
MOV DX , COUNTER 
CMP DX , 1 
JE GIVE_PREV   

MOV BX, TAKA 
MOV SI , INDEX 
MOV HISTORY[SI] , '#'
INC SI
MOV HISTORY[SI] , BL
MOV HISTORY[SI+1] , BH
ADD SI , 2 
MOV INDEX , SI 
    

CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , LOAN_CREATED 
INT 21H 
MOV AX , YEARS 
CALL PRINT_TAKA
CALL PRINT_NEW_LINE
MOV AX , VAR
ADD AX , TAKA 
MOV TAKA , AX
MOV AH , 9 
LEA DX , ONEE
INT 21H
MOV AX , TAKA 
CALL PRINT_TAKA

CALL PRINT_NEW_LINE 
MOV COUNTER , 1
JMP FR



GIVE_PREV:
    CALL PRINT_NEW_LINE
    MOV AH , 9 
    LEA DX , ALREADY
    INT 21H 
    JMP FR



NOT_LOAN:
    MOV AH , 9 
    LEA DX , NO_LOAN
    INT 21H
    JMP FR  
    
    
;===========================================================           

HISTORYY:
    CALL PRINT_NEW_LINE
    MOV SI, 0          
    CMP INDEX, 0
    JE NO_HISTORY       

PRINT_HISTORY_LOOP:
    CMP SI, INDEX
    JGE FR     

   
    MOV AL, HISTORY[SI]
    INC SI
    CMP AL, '+' 
    JE PRINT_DEPOSIT_MSG
    CMP AL, '-' 
    JE PRINT_WITHDRAW_MSG  
    CMP AL, '*'
    JE PRINT_FD_MSG   
    CMP AL, '#'
    JE PRINT_LOAN_MSG
    

PRINT_DEPOSIT_MSG:
    MOV AH, 9
    LEA DX, DIPOSIT_MSG
    INT 21H
    JMP PRINT_AMOUNT

PRINT_WITHDRAW_MSG:
    MOV AH, 9
    LEA DX, WITHDRAW_MSG
    INT 21H
    JMP PRINT_AMOUNT 
    
    
PRINT_FD_MSG: 
    MOV AH, 9
    LEA DX, FD_MSG
    INT 21H
    JMP PRINT_AMOUNT  
    
PRINT_LOAN_MSG:
    MOV AH, 9
    LEA DX, LOAN_MSG
    INT 21H
    JMP PRINT_AMOUNT 


PRINT_AMOUNT:
    MOV AL, HISTORY[SI]      
    INC SI
    MOV AH, HISTORY[SI]     
    INC SI
                 
    
    CALL PRINT_TAKA
    CALL PRINT_NEW_LINE
    JMP PRINT_HISTORY_LOOP

NO_HISTORY:
    MOV AH, 9
    LEA DX, NO_HIS
    INT 21H

JMP FR

;================================================================
EXIT:
;exit to DOS
CALL PRINT_NEW_LINE
CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , LGT
INT 21H 

CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , RENTT
INT 21H   

MOV AH, 1
INT 21H
MOV BL,AL
CMP BL,"Y"
JNE EXITT

CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , RNTR
INT 21H   

MOV AH,1
INT 21H

CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , TNK
INT 21H  

EXITT:      
CALL PRINT_NEW_LINE
CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , THANK
INT 21H 
CALL PRINT_NEW_LINE
MOV AH , 9 
LEA DX , GREAT
INT 21H
              
MOV AX,4C00H
INT 21H   

MAIN ENDP

PRINT_TAKA PROC NEAR
    MOV BX , 10 
    MOV CX , 0 
    DIV_LOOP:
        MOV DX, 0
        DIV BX            
        PUSH DX           
        INC CX
        CMP AX, 0
        JNE DIV_LOOP
    PRINT_LOOP:
        POP DX            
        ADD DL, 48
        MOV AH, 2
        INT 21H
        LOOP PRINT_LOOP
    RET
PRINT_TAKA ENDP

PRINT_NEW_LINE PROC
    MOV AH , 2 
    MOV DL , 10
    INT 21H
    MOV DL , 13 
    INT 21H 
    RET
PRINT_NEW_LINE ENDP 
    
 

    END MAIN

