/*******************************************************************************
Description: Table that stores information about bank's transactions
Author: Team B
Date 22-09-23
Management Id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/

CREATE TABLE USER.TRANSACTION(
    transaction_id NUMBER(10),
    transaction_type_id NUMBER(10),
    bank_branch_id NUMBER(10),
    account_id NUMBER(10),
    destination_account_id NUMBER(10),
    amount NUMBER(10) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) TABLESPACE TS_MANAGER;

COMMENT ON TABLE USER.TRANSACTION IS 'Transaction table'
/
COMMENT ON COLUMN USER.TRANSACTION.transaction_id IS 'Unique identifier for the transaction'
/
COMMENT ON COLUMN USER.TRANSACTION.transaction_type_id IS 'Identifier for the type of transaction'
/
COMMENT ON COLUMN USER.TRANSACTION.bank_branch_id IS 'Identifier for the bank branch where the transaction was made'
/
COMMENT ON COLUMN USER.TRANSACTION.account_id IS 'Identifier for the account where the transaction was made'
/
COMMENT ON COLUMN USER.TRANSACTION.destination_account_id IS 'Identifier for the destination account of the transaction'
/
COMMENT ON COLUMN USER.TRANSACTION.amount IS 'Identifier for the amount of the transaction'
/
COMMENT ON COLUMN USER.TRANSACTION.created_at IS 'Date when the transaction record was created'
/
