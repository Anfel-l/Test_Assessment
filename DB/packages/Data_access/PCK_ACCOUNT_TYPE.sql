
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

    PROCEDURE getACCOUNTTYPE (id in NUMBER, objACCOUNTTYPE out nocopy tyrcACCOUNTTYPE);

END PCK_ACCOUNT_TYPE;



CREATE OR REPLACE PACKAGE BODY PCK_ACCOUNT_TYPE IS

    /*Insert an account type*/
    PROCEDURE insACCOUNTTYPE(objAccountType IN OUT NOCOPY tyrcACCOUNTTYPE) is

        ACCOUNT_TYPE_EXCEPTION EXCEPTION; 

    BEGIN

        -- Initialize values
        objAccountType.account_type_id := SEQ_ACCOUNT_TYPE.NEXTVAL;

        -- Insert register
        INSERT INTO ACCOUNT_TYPE VALUES /*+PCK_ACCOUNT_TYPE.insACCOUNTTYPE*/ objAccountType;

    -- Trow Exception
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error: Valor duplicado en la clave primaria o única [PCK_ACCOUNT_TYPE.insACCOUNTTYPE]');
        WHEN ACCOUNT_TYPE_EXCEPTION THEN
            RAISE_APPLICATION_ERROR(-20001, 'Error creating ACCOUNT_TYPE [PCK_ACCOUNT_TYPE.insACCOUNTTYPE]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, SQLCODE || ' => ' || SQLERRM);
        
    END insACCOUNTTYPE;
    
    
    PROCEDURE getACCOUNTTYPE (id in NUMBER, objACCOUNTTYPE out nocopy tyrcACCOUNTTYPE) IS

        ACCOUNT_TYPE_EXCEPTION EXCEPTION; 

        -- Indicar columnas
        CURSOR curACCOUNTTYPE IS
            SELECT * 
            FROM ACCOUNT_TYPE
            WHERE /*+PCK_ACCOUNT_TYPE.getACCOUNTTYPE*/ account_type_id = id;

    BEGIN
        OPEN curACCOUNTTYPE;
        FETCH curACCOUNTTYPE INTO objACCOUNTTYPE;
        CLOSE curACCOUNTTYPE;
    
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Error: No hay ningun resultado [PCK_ACCOUNT_TYPE.getACCOUNTTYPE]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, SQLCODE || ' => ' || SQLERRM);
    END getACCOUNTTYPE;


END;

