/*******************************************************************************
Description: Foreing Key from account table to customer table
Author: Team B
Date: 25-09-23
Management_id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/
ALTER TABLE USER.ACCOUNT ADD CONSTRAINT FK_ACCOUNT_CUSTOMER FOREIGN KEY (customer_id) REFERENCES USER.CUSTOMER (customer_id)
/
