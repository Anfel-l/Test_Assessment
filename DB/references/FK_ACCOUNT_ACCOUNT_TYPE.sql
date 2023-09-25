/*******************************************************************************
Description: Table that stores information about bank's transactions
Author: Team B
Date 22-09-23
Management Id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/

ALTER TABLE USER.ACCOUNT ADD CONSTRAINT FK_ACCOUNT_ACCOUNT_TYPE FOREIGN KEY (account_type_id) REFERENCES USER.ACCOUNT_TYPE (account_type_id)
/