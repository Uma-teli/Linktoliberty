       IDENTIFICATION DIVISION.
       PROGRAM-ID. FRAUDMOD.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 I PIC 9(2) VALUE 1.
       01 MODEL_ID  PIC X(36) VALUE
                    '3442335c-c694-4e34-b7c9-af26e14cadd6'.
       01 IN_CLASS  PIC X(16) VALUE 'FraudMLINwrapper'.
       01 OUT_CLASS PIC X(17) VALUE 'FraudMLOUTwrapper'.

       LINKAGE SECTION.
       01 DFHCOMMAREA.
           02 FRADMLIN.
           COPY MODELIN.
           02 FRADMLOT.
           COPY MODELOUT.

       PROCEDURE DIVISION.
      *      MOVE 2.814210  TO AMOUNT_NUM.
      *      MOVE 1         TO CARD.
      *      MOVE 0         TO ERRORSX.
      *      MOVE 75        TO MCC.
      *      MOVE 486       TO MERCHANTXCITY.
      *      MOVE 25679     TO MERCHANTXNAME.
      *      MOVE 64        TO MERCHANTXSTATE.
      *      MOVE 2         TO USEXCHIP.
      *      MOVE 1         TO USER. 
      *      MOVE 99        TO ZIP.

            DISPLAY 'AMOUNT         :' AMOUNT-NUM.
            DISPLAY 'MERCHANT CITY  :' MERCHANTXCITY.
            DISPLAY 'MERCHANT NAME  :' MERCHANTXNAME.
            DISPLAY 'MERCHANT STATE :' MERCHANTXSTATE.
            DISPLAY 'card           :' CARD.
            DISPLAY 'ERROSX           :' ERRORSX.
            DISPLAY 'USEXCHIP           :' USEXCHIP.
            DISPLAY 'MCC           :' MCC.

            EXEC CICS PUT CONTAINER('ALN_DEPLOY_ID') CHANNEL('CHAN')
               CHAR
               FROM(MODEL_ID)
               END-EXEC.

            EXEC CICS PUT CONTAINER('ALN_INPUT_CLASS') CHANNEL('CHAN')
               CHAR FROM(IN_CLASS)
               END-EXEC.

            EXEC CICS PUT CONTAINER('ALN_INPUT_DATA') CHANNEL('CHAN')
               FROM(FRADMLIN) BIT END-EXEC.

            EXEC CICS PUT CONTAINER('ALN_OUTPUT_CLASS')
               CHANNEL('CHAN')
               CHAR FROM(OUT_CLASS)
               END-EXEC.
            DISPLAY FRADMLIN.

            EXEC CICS LINK PROGRAM('ALNSCORE') CHANNEL('CHAN')
                END-EXEC.
            EXEC CICS GET CONTAINER('ALN_OUTPUT_DATA')
                CHANNEL('CHAN')
                INTO(FRADMLOT) END-EXEC.

      *   DISPLAY 'PREDICTION     :' PREDICTION.
      *   DISPLAY 'PROBABILITY    :'.

            DISPLAY 'probabilityX0X :' PREDICTION.
            DISPLAY 'probabilityX1X :' PROBABILITY(1).
      *   PERFORM UNTIL I=3
      *   DISPLAY 'PROBABILITY-' I
      *   DISPLAY PROBABILITY(I)
      *   ADD 1 TO I
      *   END-PERFORM.
            EXEC CICS RETURN END-EXEC.
            STOP RUN.
