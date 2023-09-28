
CREATE OR REPLACE PACKAGE PCK_CUSTOMER IS
/*******************************************************************************
Description: Table that stores information about bank's transactions
Author: Team B
Date 22-09-23
Management Id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/

  /* Public data types declaration */

  SUBTYPE tyrcCUSTOMER IS CUSTOMER%ROWTYPE;

  TYPE tytbCUSTOMER IS TABLE OF tyrcCUSTOMER INDEX BY binary_integer;

  /* Public variables declaration */



  /* Public methods and functions declaration */

  PROCEDURE insCUSTOMER (objCustomer in out nocopy tyrcCUSTOMER);

  PROCEDURE getCUSTOMER (id in NUMBER, objCustomer out nocopy tyrcCUSTOMER);

END PCK_CUSTOMER;



CREATE OR REPLACE PACKAGE BODY PCK_CUSTOMER IS

  /* Insert customer */
  PROCEDURE insCUSTOMER (objCustomer in out nocopy tyrcCUSTOMER) IS

    CUSTOM_EXCEPTION EXCEPTION;

  BEGIN
    -- Initialize values
    customer.customer_id := SEQ_CUSTOMER.NEXTVAL;

    -- Insert value
    INSERT INTO CUSTOMER VALUES /*+PCK_CUSTOMER.insCUSTOMER*/ objCustomer;

  EXCEPTION
    WHEN CUSTOM_EXCEPTION THEN
      RAISE_APPLICATION_ERROR(-20001, 'Error creating customer [PCK_CUSTOMER.insCUSTOMER]');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20000, SQLCODE || ' => ' || SQLERRM);
  END insCUSTOMER;

  /* Get customer by id */
  PROCEDURE getCUSTOMER (id in NUMBER, objCustomer out nocopy tyrcCUSTOMER) IS

    CUSTOM_EXCEPTION EXCEPTION;

    -- indicar columnas
    CURSOR curCUSTOMER IS
      SELECT *
      FROM CUSTOMER
      WHERE /*+PCK_CUSTOMER.getCUSTOMER*/ customer_id = id;

  BEGIN
    OPEN curCUSTOMER;
    FETCH curCUSTOMER INTO objCustomer;
    CLOSE curCUSTOMER;

  EXCEPTION
    /* WHEN CUSTOM_EXCEPTION THEN
      RAISE_APPLICATION_ERROR(-20001, 'Error creating customer [PCK_CUSTOMER.insCUSTOMER]');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20000, SQLCODE || ' => ' || SQLERRM); */
  END insCUSTOMER;

END;
