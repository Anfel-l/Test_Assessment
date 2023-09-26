/*******************************************************************************
Description: Table that stores information about bank's transactions
Author: Team B
Date 22-09-23
Management Id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/

CREATE TABLE IF NOT EXISTS USER.TRANSACTION_TYPE(
    transaction_id NUMBER(10) NOT NULL,
    transaction_type_code VARCHAR2(3) PRIMARY KEY,
    description VARCHAR2(50)
)
/
INSERT INTO USER.TRANSACTION_TYPE (transaction_type_code, description) VALUES ('1', 'Retiro')
/
INSERT INTO USER.TRANSACTION_TYPE (transaction_type_code, description) VALUES ('2', 'Consignación')
/
INSERT INTO USER.TRANSACTION_TYPE (transaction_type_code, description) VALUES ('3', 'Interéses')
/
COMMENT ON TABLE USER.TRANSACTION_TYPE IS 'Document type table'
/
COMMENT ON COLUMN USER.TRANSACTION_TYPE.transaction_id IS 'Unique identifier for the transaction type. It is the primary key for the table.'
/
COMMENT ON COLUMN USER.TRANSACTION_TYPE.transaction_type_code IS 'Unique code representing the type of transaction. It is the primary key for the table.'
/
COMMENT ON COLUMN USER.TRANSACTION_TYPE.description IS 'Description of the transaction type, explaining what each code represents.'
/
