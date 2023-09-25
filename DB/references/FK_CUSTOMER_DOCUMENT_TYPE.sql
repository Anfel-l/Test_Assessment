/*******************************************************************************
Description: Foreing Key from document type table to customer table
Author: Team B
Date: 25-09-23
Management_id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE USER.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_DOCUMENT_TYPE FOREIGN KEY (document_type_id) REFERENCES USER.DOCUMENT_TYPE (document_type_id)
/