/*******************************************************************************
Description: Table that stores the information of customer's account
Author: Team B
Date 22-09-23
Management Id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/

CREATE TABLE USER.ACCOUNT (
    account_id NUMBER(10),
    customer_id NUMBER(10),
    account_type_id NUMBER(10),
    created_branch_id NUMBER(10),
    balance NUMBER(15) DEFAULT NULL,
    password VARCHAR2(4) NOT NULL,
    closing_date TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) TABLESPACE TS_MANAGER;

-- Table
COMMENT ON TABLE USER.ACCOUNT IS 'Account table'
/

-- Columns
COMMENT ON COLUMN USER.ACCOUNT.account_id IS 'Unique identifier for each account'
/
COMMENT ON COLUMN USER.ACCOUNT.customer_id IS 'Unique identifier for the customer'
/
COMMENT ON COLUMN USER.ACCOUNT.account_type_id IS 'Unique identifier for the customer type'
/
COMMENT ON COLUMN USER.ACCOUNT.created_branch_id IS 'Unique identifier for the branch'
/
COMMENT ON COLUMN USER.ACCOUNT.balance IS 'Account balance'
/
COMMENT ON COLUMN USER.ACCOUNT.password IS 'Account password'
/
COMMENT ON COLUMN USER.ACCOUNT.closing_date IS 'Date account registration was closed'
/
COMMENT ON COLUMN USER.ACCOUNT.created_at IS 'Date when the account record was created'
/
COMMENT ON COLUMN USER.ACCOUNT.updated_at IS 'Date when the account record was last updated'
/
