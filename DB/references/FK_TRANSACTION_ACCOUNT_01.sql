/*******************************************************************************
Description: Foreing Key from document type table to customer table
Author: Team B
Date: 25-09-23
Management_id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/

ALTER TABLE USER.TRANSACTION ADD CONSTRAINT FK_TRANSACTION_ACCOUNT_01 FOREIGN KEY (account_id) REFERENCES USER.ACCOUNT (account_id)
/