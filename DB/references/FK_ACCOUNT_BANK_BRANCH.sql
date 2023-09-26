/*******************************************************************************
Description: Foreing Key from account table to customer table
Author: Team B
Date: 25-09-23
Management_id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE USER.ACCOUNT ADD CONSTRAINT FK_ACCOUNT_BANK_BRANCH FOREIGN KEY (created_branch_id) REFERENCES USER.BANK_BRANCH (bank_branch_id)
/

