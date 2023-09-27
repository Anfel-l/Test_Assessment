CREATE OR REPLACE PACKAGE PCK_ACCOUNT_TYPE IS
/*******************************************************************************
Description: Table that stores information about bank's transactions
Author: Team B
Date 22-09-23
Management Id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/

    /* Public data types declaration */

    SUBTYPE tyrcACCOUNTTYPE IS ACCOUNT_TYPE%ROWTYPE;

    TYPE tytbACCOUNTTYPE IS TABLE OF tyrcACCOUNTTYPE INDEX BY BYNARY_INTEGER;

    /* Public variables declaration */



    /* Public methods and functions declaration */

    PROCEDURE insACCOUNTTYPE (accountType IN OUT NOCOPY tyrcACCOUNTTYPE);

END PCK_ACCOUNT_TYPE;

CREATE OR REPLACE PACKAGE BODY PCK_ACCOUNT_TYPE IS

    /*Insert an account type*/
    PROCEDURE insACCOUNTTYPE(accountType IN OUT NOCOPY tyrcACCOUNTTYPE) is 
    BEGIN

        -- Initialize values
        accountType.account_type_id := SEQ.NECTVAL;

        -- Insert register
        INSERT INTO ACCOUNT_TYPE accountType;

        -- Trow Exception
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error: Valor duplicado en la clave primaria o única.');
        WHEN 
        
    END;
END;

