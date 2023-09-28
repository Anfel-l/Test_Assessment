CREATE OR REPLACE PACKAGE PCK_CUSTOMER IS
/*******************************************************************************
Description: Table that stores information about bank's transactions
Author: Team B
Date 22-09-23
Management Id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/

/*la gente e pueblo la gente e pueblo weweewweww*/

	/* Public data types declaration */

	SUBTYPE tyrcCUSTOMER IS CUSTOMER%ROWTYPE;

	TYPE tytbCUSTOMER IS TABLE OF tyrcCUSTOMER INDEX BY BINARY_INTEGER;

	/* Public variables declaration */



	/* Public methods and functions declaration */

	PROCEDURE Proc_Insert_CUSTOMER (IOp_Customer IN OUT NOCOPY tyrcCUSTOMER);

	PROCEDURE Proc_Get_CUSTOMER (Ip_Id IN NUMBER, Op_Customer OUT NOCOPY tyrcCUSTOMER);

	PROCEDURE Proc_Update_CUSTOMER (Ip_Id IN NUMBER, IOp_Customer IN OUT NOCOPY tyrcCUSTOMER);

END PCK_CUSTOMER;



CREATE OR REPLACE PACKAGE BODY PCK_CUSTOMER IS

	/* Insert customer */
	PROCEDURE Proc_Insert_CUSTOMER (IOp_Customer IN OUT NOCOPY tyrcCUSTOMER) IS

	BEGIN
		-- Initialize values
		IOp_Customer.customer_id := SEQ_CUSTOMER.NEXTVAL;

		-- Insert value
		INSERT INTO CUSTOMER VALUES /*+PCK_CUSTOMER.Proc_Insert_CUSTOMER*/ IOp_Customer;

	EXCEPTION
		WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20000, 'Error: Valor duplicado en la clave primaria o única [PCK_CUSTOMER.insCUSTOMER]');
		WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);
	END Proc_Insert_CUSTOMER;

	/* Get customer by id */
	PROCEDURE Proc_Get_CUSTOMER (Ip_Id IN NUMBER, Op_Customer OUT NOCOPY tyrcCUSTOMER) IS

		CUSTOM_EXCEPTION EXCEPTION;

		CURSOR cur_CUSTOMER IS
		SELECT 
			customer_id, 
			first_name, 
			second_name, 
			last_name, 
			second_last_name,
			birthdate, 
			document, 
			document_type_id, 
			address, 
			email, 
			phone_number,
			password,
			created_at,
			updated_at
		FROM CUSTOMER
		WHERE /*+PCK_CUSTOMER.Proc_Get_CUSTOMER*/ customer_id = Ip_Id;

	BEGIN
		OPEN cur_CUSTOMER;
		FETCH cur_CUSTOMER INTO Op_Customer;
		CLOSE cur_CUSTOMER;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20150, 'Error: No hay ningun resultado [PCK_ACCOUNT_TYPE.Proc_Get_CUSTOMER]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
	END Proc_Get_CUSTOMER;

END;
