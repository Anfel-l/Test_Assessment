/*******************************************************************************
Description: Table that stores the information of the bank's clients
Author: Team B
Date: 22-09-23
Management_id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/

CREATE TABLE IF NOT EXISTS USER.DOCUMENT_TYPE(
    document_type_id NUMBER(10),
    type_code VARCHAR2(3) PRIMARY KEY,
    description VARCHAR2(50)
)
/
COMMENT ON TABLE USER.DOCUMENT_TYPE IS 'Table that stores the different types of documents that a customer can have.'
/
COMMENT ON COLUMN USER.DOCUMENT_TYPE.document_type_id IS 'Unique identifier for the document type. It is the primary key for the table.'
COMMENT ON COLUMN USER.DOCUMENT_TYPE.type_code IS 'Unique code representing the type of document. It is the primary key for the table.'
/
COMMENT ON COLUMN USER.DOCUMENT_TYPE.description IS 'Description of the document type, explaining what each code represents.'
/
INSERT INTO USER.DOCUMENT_TYPE (type_code, description) VALUES ('CC', 'Cédula de Ciudadanía')
/
INSERT INTO USER.DOCUMENT_TYPE (type_code, description) VALUES ('TI', 'Tarjeta de Identidad')
/
INSERT INTO USER.DOCUMENT_TYPE (type_code, description) VALUES ('NIT', 'Número de Identificación Tributaria')
/
INSERT INTO USER.DOCUMENT_TYPE (type_code, description) VALUES ('CE', 'Cédula de Extranjería')
/
INSERT INTO USER.DOCUMENT_TYPE (type_code, description) VALUES ('PA', 'Pasaporte')