/*******************************************************************************
Description: Table that stores information about bank's transactions
Author: Team B
Date 22-09-23
Management Id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/

CREATE TABLE USER.TRANSACTION_TYPE(
    transaction_type_id NUMBER(10) NOT NULL,
    description VARCHAR2(50) NOT NULL
) TABLESPACE TS_MANAGER;

INSERT INTO USER.TRANSACTION_TYPE (transaction_type_id, description) VALUES ('1', 'Retiro')
/
INSERT INTO USER.TRANSACTION_TYPE (transaction_type_id, description) VALUES ('2', 'Consignación')
/
INSERT INTO USER.TRANSACTION_TYPE (transaction_type_id, description) VALUES ('3', 'Interéses')
/
COMMENT ON TABLE USER.TRANSACTION_TYPE IS 'Document type table'
/
COMMENT ON COLUMN USER.TRANSACTION_TYPE.transaction_type_id IS 'Unique identifier for the transaction type. It is the primary key for the table.'
/
COMMENT ON COLUMN USER.TRANSACTION_TYPE.description IS 'Description of the transaction type, explaining what each code represents.'
/
