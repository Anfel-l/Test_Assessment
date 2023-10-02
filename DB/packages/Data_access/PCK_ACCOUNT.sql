CREATE OR REPLACE PACKAGE PCK_ACCOUNT IS
/******************************************************************************
Description: Package to manage data access for Account records
Author: Team B
Date 22-09-23
Management Id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/

    /* Public datas declaration */

    SUBTYPE tyrcACCOUNT IS ACCOUNT%ROWTYPE;

    TYPE tytbACCOUNT IS TABLE OF tyrcACCOUNT INDEX BY BINARY_INTEGER;

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
    PROCEDURE Proc_Get_Customer_Accounts
    (
       Ip_Customer_Id in NUMBER, 
       Op_Accounts OUT NOCOPY tytbACCOUNT
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
        IOp_Account.ACCOUNT_id := SEQ_ACCOUNT.NEXTVAL;

        -- Insert register
        INSERT INTO ACCOUNT VALUES /*+PCK_ACCOUNT.Proc_Insert_ACCOUNT*/ IOp_ACCOUNT;

    -- Throw Exception
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20000, 'Error: Valor duplicado en la clave primaria o única [PCK_ACCOUNT.Proc_Insert_ACCOUNT]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);
    END Proc_Insert_ACCOUNT;
    
    /* Get By Id*/
    PROCEDURE Proc_Get_ACCOUNT (Ip_Id in NUMBER, Op_ACCOUNT out nocopy tyrcACCOUNT) IS

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
        WHERE account_id = Ip_Id;

    v_count INT := 0;

	BEGIN
	    OPEN cur_ACCOUNT;
	    FETCH cur_ACCOUNT INTO Op_ACCOUNT;
	    v_count := cur_ACCOUNT%ROWCOUNT;
	    CLOSE cur_ACCOUNT;
	
	    IF
			v_count = 0 THEN
		        RAISE_APPLICATION_ERROR(-20150,
			'Error: No hay ningun resultado [PCK_ACCOUNT.Proc_Get_ACCOUNT]');
		END IF;
	
	EXCEPTION
	    WHEN OTHERS THEN
	        RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
	END Proc_Get_ACCOUNT;


    /* Get All accounts by customer_id*/
    PROCEDURE Proc_Get_Customer_Accounts (Ip_Customer_Id in NUMBER, Op_Accounts OUT NOCOPY tytbACCOUNT) IS
        v_counter BINARY_INTEGER := 1; -- to index the collection

        CURSOR cur_Customer_Accounts IS
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
            WHERE customer_id = Ip_Customer_Id;

    BEGIN
        FOR record in cur_Customer_Accounts LOOP
            Op_Accounts(v_counter).account_id := record.account_id;
            Op_Accounts(v_counter).customer_id := record.customer_id;
            Op_Accounts(v_counter).account_type_id := record.account_type_id;
            Op_Accounts(v_counter).created_branch_id := record.created_branch_id;
            Op_Accounts(v_counter).balance := record.balance;
            Op_Accounts(v_counter).password := record.password;
            Op_Accounts(v_counter).created_at := record.created_at;
            Op_Accounts(v_counter).updated_at := record.updated_at;
            Op_Accounts(v_counter).closing_date := record.closing_date;
            v_counter := v_counter + 1;
        END LOOP;

    EXCEPTION 
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20150, 'Error: No hay cuentas para el cliente con ID ' || TO_CHAR(Ip_Customer_Id) || ' [PCK_ACCOUNT.Proc_Get_Customer_Accounts]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_Customer_Accounts;


    /*update*/
    PROCEDURE Proc_Update_ACCOUNT (IOp_Account IN OUT NOCOPY tyrcACCOUNT) IS
        v_updated_record tyrcACCOUNT;
    BEGIN
        /* Update record */

        UPDATE ACCOUNT
        SET balance = IOp_ACCOUNT.balance,
            password = IOp_ACCOUNT.password,
            closing_date = IOp_ACCOUNT.closing_date
        WHERE account_id = IOp_Account.account_id;
       
		Proc_Get_ACCOUNT(IOp_Account.account_id, v_updated_record);
		IOp_Account := v_updated_record;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Update_ACCOUNT;

END PCK_ACCOUNT;