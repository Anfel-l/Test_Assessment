/*******************************************************************************
Description: Foreing Key from transaction table to transaction type table
Author: Team B
Date: 25-09-23
Management_id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE USER.TRANSACTION ADD CONSTRAINT FK_TRANSACTION_ACCOUNT_02 FOREIGN KEY (destination_account_id) REFERENCES USER.ACCOUNT (account_id)
/