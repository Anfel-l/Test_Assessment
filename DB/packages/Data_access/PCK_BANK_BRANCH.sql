CREATE OR REPLACE PACKAGE PCK_BANK_BRANCH IS
/*******************************************************************************
Description: Table that stores information about bank's transactions
Author: Team B
Date 22-09-23
Management Id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/

    /* Public data types declaration */
    SUBTYPE tyrcBANKBRANCH IS BANK_BRANCH%ROWTYPE;

    TYPE tytbBANKBRANCH IS TABLE OF tyrcBANKBRANCH INDEX BY BINARY_INTEGER;

     /* Public variables declaration */



    /* Public methods and functions declaration */

    /*******************************************************************************
    Description: Procedure that inserts a bank branch object
    Author: Team B
    Date 28-09-23
    Management Id: XD01
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Insert_BANKBRANCH 
    (
        IOp_Bank_Branch IN OUT NOCOPY tyrcBANKBRANCH 
    );

    /*******************************************************************************
    Description: Procedure that obtains all bank branch
    Author: Team B
    Date 28-09-23
    Management Id: XD01
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_All_BANKBRANCH
    (
        Op_Bank_Branch OUT tyrcBANKBRANCH
    );

    /*******************************************************************************
    Description: Procedure that obtains a bank branch
    Author: Team B
    Date 28-09-23
    Management Id: XD01
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Get_BANKBRANCH
    (
        Ip_Id in NUMBER,
        Op_Bank_Branch OUT NOCOPY tyrcBANKBRANCH
    );

    /*******************************************************************************
    Description: Procedure that updates a bank branch object
    Author: Team B
    Date 28-09-23
    Management Id: XD01
    @copyright: Seguros Bolívar
    *******************************************************************************/
    PROCEDURE Proc_Update_BANKBRANCH
    (
        IOp_ank_Branch IN OUT NOCOPY tyrcBANKBRANCH
    );

END PCK_BANK_BRANCH;