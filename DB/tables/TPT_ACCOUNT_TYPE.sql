/*******************************************************************************
Description: Table that stores information about bank's transactions
Author: Team B
Date 22-09-23
Management Id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/

CREATE TABLE USER.ACCOUNT_TYPE(
    account_type_id NUMBER(10),
    account_name VARCHAR2(15) NOT NULL,
    rate DECIMAL(5,4) NOT NULL
) TABLESPACE TS_MANAGER;

COMMENT ON TABLE USER.ACCOUNT_TYPE IS 'Table that stores the different types of accounts available in the bank'
/
COMMENT ON COLUMN USER.ACCOUNT_TYPE.account_type_id IS 'Unique identifier for each account type.'
/
COMMENT ON COLUMN USER.ACCOUNT_TYPE.account_name IS 'Name of the account type.'
/
COMMENT ON COLUMN USER.ACCOUNT_TYPE.rate IS 'Interest rate associated with the account type.'
/
INSERT INTO USER.ACCOUNT_TYPE (account_type_id, account_name, rate) VALUES ()
/
INSERT INTO USER.ACCOUNT_TYPE (account_type_id, account_name, rate) VALUES ()
/
