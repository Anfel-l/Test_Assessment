CREATE OR REPLACE PACKAGE PCK_ACCOUNT IS
/*******************************************************************************
Description: Table that stores information about bank's transactions
Author: Team B
Date 22-09-23
Management Id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/

    /* Public datas declaration */

    SUBTYPE tyrcACCOUNTT IS ACCOUNT%ROWTYPE;

    TYPE tytbACCOUNTT IS TABLE OF tyrcACCOUNT INDEX BY BINARY_INTEGER;

    /* Public variables declaration */



    /* Public methods and functions declaration */

    /*******************************************************************************
    Description: Procedure that inserts an account object
    Author: Team B
    Date 28-09-23
    Management Id: XD01
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_ACCOUNT
    (
        IOp_ACCOUNT IN OUT NOCOPY tyrcACCOUNT
    );

    /*******************************************************************************
    Description: Procedure that obtains an account object
    Author: Team B
    Date 28-09-23
    Management Id: XD01
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_ACCOUNT
    (
        Ip_Id in NUMBER,
        Op_ACCOUNT OUT NOCOPY tyrcACCOUNT
    );

    /*******************************************************************************
    Description: Procedure that obtains all customer account objects
    Author: Team B
    Date 28-09-23
    Management Id: XD01
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_Customer_ACCOUNTS
    (
        Ip_Customer_Id in NUMBER,
        Op_ACCOUNT OUT NOCOPY tytbACCOUNTT
    );

    /*******************************************************************************
    Description: Procedure that updates an account object
    Author: Team B
    Date 28-09-23
    Management Id: XD01
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_ACCOUNT
    (
        IOp_ACCOUNT IN OUT NOCOPY tyrcACCOUNT
    );

END PCK_ACCOUNT;



CREATE OR REPLACE PACKAGE BODY PCK_ACCOUNT IS

    /*Insert an account */
    PROCEDURE Proc_Insert_ACCOUNT(IOp_Account IN OUT NOCOPY tyrcACCOUNT) is

    BEGIN
        -- Initialize values
        IOp_Account.ACCOUNTid := SEQ_ACCOUNT.NEXTVAL;

        -- Insert register
        INSERT INTO ACCOUNT VALUES /*+PCK_ACCOUNT.Proc_Insert_ACCOUNT*/ IOp_ACCOUNT;

    -- Throw Exception
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20000, 'Error: Valor duplicado en la clave primaria o única [PCK_ACCOUNT.insACCOUNT]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);
    END Proc_Insert_ACCOUNT;
    
    
    PROCEDURE Proc_Get_ACCOUNT (Ip_Id in NUMBER, Op_ACCOUNT out nocopy tyrcACCOUNT) IS

        ACCOUNT_EXCEPTION EXCEPTION; 

        CURSOR cur_ACCOUNT IS
            SELECT 
                account_id,
                customer_id,
                account_type_id,
                created_branch_id,
                balance,
                password,
                created_at,
                updated_at,
                closing_date 
            FROM ACCOUNT
            WHERE /*+PCK_ACCOUNT.Proc_Get_ACCOUNT*/ ACCOUNT_id = Ip_Id;

    BEGIN
        OPEN cur_ACCOUNT;
        FETCH cur_ACCOUNT INTO Op_ACCOUNT;
        CLOSE cur_ACCOUNT;
    
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20150, 'Error: No hay ningun resultado [PCK_ACCOUNT.Proc_Get_ACCOUNT]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_ACCOUNT;


    PROCEDURE Proc_Get_Customer_ACCOUNTS (Ip_Customer_Id in NUMBER, Op_ACCOUNTS OUT NOCOPY tytbACCOUNTT) IS
    v_counter BINARY_INTEGER := 0; -- to index the collection

        CURSOR cur_Customer_Accounts IS
            SELECT * 
            FROM ACCOUNT 
            WHERE customer_id = Ip_Customer_Id;

    BEGIN
        FOR record in cur_Customer_Accounts LOOP
            v_counter := v_counter + 1;
            Op_ACCOUNTS(v_counter) := record;
        END LOOP;

    EXCEPTION 
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20150, 'Error: No hay cuentas para el cliente con ID ' || TO_CHAR(Ip_Customer_Id) || ' [PCK_ACCOUNT.Proc_Get_Customer_ACCOUNTS]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_Customer_ACCOUNTS


    /*update */
    PROCEDURE Proc_Update_ACCOUNT (IOp_ACCOUNT IN OUT tyrcACCOUNT) IS
        ACCOUNT_EXCEPTION EXCEPTION;
    BEGIN
        -- Validación de entradas, si es necesario
        IF IOp_ACCOUNT.account_id IS NULL OR IOp_ACCOUNT IS NULL THEN
            RAISE ACCOUNT_EXCEPTION;
        END IF;
        
        -- Actualizar registro
        UPDATE ACCOUNT
        SET balance = IOp_ACCOUNT.balance,
            password = IOp_ACCOUNT.password,
            closing_date = IOp_ACCOUNT.closing_date

            
        WHERE account_id = IOp_ACCOUNT.account_id;
        
        IF SQL%NOTFOUND THEN
            RAISE ACCOUNT_EXCEPTION;
        END IF;
        
    EXCEPTION
        WHEN ACCOUNT_EXCEPTION THEN
            RAISE_APPLICATION_ERROR(-20150, 'Error updating ACCOUNT with id ' || TO_CHAR(IOp_ACCOUNT.account_id) || ' [PCK_ACCOUNT.updACCOUNT]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Update_ACCOUNT;

END PCK_ACCOUNT;
