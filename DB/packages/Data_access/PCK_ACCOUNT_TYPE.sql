
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

    PROCEDURE Proc_Insert_ACCOUNTTYPE (IOp_Account_Type IN OUT NOCOPY tyrcACCOUNTTYPE);

    PROCEDURE Proc_Get_ACCOUNTTYPE (Ip_Id in NUMBER, Op_Account_Type OUT NOCOPY tyrcACCOUNTTYPE);

    PROCEDURE Proc_Update_ACCOUNTTYPE (Ip_Id IN NUMBER, IOp_Account_Type IN OUT NOCOPY tyrcACCOUNTTYPE);

END PCK_ACCOUNT_TYPE;



CREATE OR REPLACE PACKAGE BODY PCK_ACCOUNT_TYPE IS

    /*Insert an account type*/
    PROCEDURE Proc_insACCOUNTTYPE(IOp_ObjAccountType IN OUT NOCOPY tyrcACCOUNTTYPE) is

    BEGIN

        -- Initialize values
        IOp_ObjAccountType.account_type_id := SEQ_ACCOUNT_TYPE.NEXTVAL;

        -- Insert register
        INSERT INTO ACCOUNT_TYPE VALUES /*+PCK_ACCOUNT_TYPE.Proc_insACCOUNTTYPE*/ IOp_ObjAccountType;

    -- Trow Exception
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20000, 'Error: Valor duplicado en la clave primaria o única [PCK_ACCOUNT_TYPE.insACCOUNTTYPE]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);
    END Proc_insACCOUNTTYPE;
    
    
    PROCEDURE Proc_Get_ACCOUNTTYPE (Ip_Id in NUMBER, Op_accountType out nocopy tyrcACCOUNTTYPE) IS

        ACCOUNT_TYPE_EXCEPTION EXCEPTION; 

        -- Indicar columnas
        CURSOR cur_ACCOUNTTYPE IS
            SELECT 
            account_type_id,
            account_name,
            rate 
            FROM ACCOUNT_TYPE
            WHERE /*+PCK_ACCOUNT_TYPE.Proc_Get_ACCOUNTTYPE*/ account_type_id = Ip_Id;

    BEGIN
        OPEN cur_ACCOUNTTYPE;
        FETCH cur_ACCOUNTTYPE INTO objACCOUNTTYPE;
        CLOSE cur_ACCOUNTTYPE;
    
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20150, 'Error: No hay ningun resultado [PCK_ACCOUNT_TYPE.Proc_Get_ACCOUNTTYPE]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_ACCOUNTTYPE;


    /*update */
    PROCEDURE Proc_Update_ACCOUNTTYPE (Ip_Id IN NUMBER, IOp_New_Obj_Account_Type IN OUT tyrcACCOUNTTYPE) IS
        ACCOUNT_TYPE_EXCEPTION EXCEPTION;
    BEGIN
        -- Validación de entradas, si es necesario
        IF Ip_Id IS NULL OR IOp_New_Obj_Account_Type IS NULL THEN
            RAISE ACCOUNT_TYPE_EXCEPTION;
        END IF;
        
        -- Actualizar registro
        UPDATE ACCOUNT_TYPE
        SET column1 = newObjAccountType.column1,
            column2 = newObjAccountType.column2,
            
        WHERE account_type_id = Ip_Id;
        
        IF SQL%NOTFOUND THEN
            RAISE ACCOUNT_TYPE_EXCEPTION;
        END IF;
        
    EXCEPTION
        WHEN ACCOUNT_TYPE_EXCEPTION THEN
            RAISE_APPLICATION_ERROR(-20150, 'Error updating ACCOUNT_TYPE with id ' || TO_CHAR(Ip_Id) || ' [PCK_ACCOUNT_TYPE.updACCOUNTTYPE]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END updACCOUNTTYPE;

END;
    