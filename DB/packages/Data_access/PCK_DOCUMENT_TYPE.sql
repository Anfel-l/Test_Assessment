CREATE OR REPLACE PACKAGE PCK_DOCUMENT_TYPE IS
/*******************************************************************************
Description: Package that manages operations on DOCUMENT_TYPE table.
Author: Team B
Date 28-09-23
Management Id: XD01
@copyright: Seguros Bolívar
*******************************************************************************/

    /* Public data types declaration */
    SUBTYPE tyrcDOCUMENT_TYPE IS DOCUMENT_TYPE%ROWTYPE;

    TYPE tytbDOCUMENT_TYPE IS TABLE OF tyrcDOCUMENT_TYPE INDEX BY BINARY_INTEGER;

    /* Public methods and functions declaration */
    
    PROCEDURE Proc_Insert_DOCUMENT_TYPE
    (
        IOp_Document_Type IN OUT NOCOPY tyrcDOCUMENT_TYPE
    );
    
    PROCEDURE Proc_Get_DOCUMENT_TYPE
    (
        Ip_Id IN NUMBER,
        Op_Document_Type OUT NOCOPY tyrcDOCUMENT_TYPE
    );
    
    PROCEDURE Proc_Update_DOCUMENT_TYPE
    (
        IOp_Document_Type IN OUT NOCOPY tyrcDOCUMENT_TYPE
    );

END PCK_DOCUMENT_TYPE;

CREATE OR REPLACE PACKAGE BODY PCK_DOCUMENT_TYPE IS

    /* Procedure to insert a new document type */
    PROCEDURE Proc_Insert_DOCUMENT_TYPE(IOp_Document_Type IN OUT NOCOPY tyrcDOCUMENT_TYPE) IS
    BEGIN
        IOp_Document_Type.document_type_id := SEQ_DOCUMENT_TYPE.NEXTVAL;
        INSERT INTO DOCUMENT_TYPE VALUES IOp_Document_Type;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RAISE_APPLICATION_ERROR(-20000, 'Error: Valor duplicado en la clave primaria o única [PCK_DOCUMENT_TYPE.insDOCUMENT_TYPE]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, SQLCODE || ' => ' || SQLERRM);
    END Proc_Insert_DOCUMENT_TYPE;
    
    /* Procedure to get a document type by id */
    PROCEDURE Proc_Get_DOCUMENT_TYPE(Ip_Id IN NUMBER, Op_Document_Type OUT NOCOPY tyrcDOCUMENT_TYPE) IS
        CURSOR cur_DOCUMENT_TYPE IS
            SELECT * FROM DOCUMENT_TYPE WHERE document_type_id = Ip_Id;
    BEGIN
        OPEN cur_DOCUMENT_TYPE;
        FETCH cur_DOCUMENT_TYPE INTO Op_Document_Type;
        CLOSE cur_DOCUMENT_TYPE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20150, 'Error: No hay ningun resultado [PCK_DOCUMENT_TYPE.Proc_Get_DOCUMENT_TYPE]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Get_DOCUMENT_TYPE;
    
    /* Procedure to update a document type */
    PROCEDURE Proc_Update_DOCUMENT_TYPE(IOp_Document_Type IN OUT NOCOPY tyrcDOCUMENT_TYPE) IS
    BEGIN
        UPDATE DOCUMENT_TYPE
        SET type_code = IOp_Document_Type.type_code,
            description = IOp_Document_Type.description
        WHERE document_type_id = IOp_Document_Type.document_type_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20150, 'Error: No hay ningun resultado [PCK_DOCUMENT_TYPE.updDOCUMENT_TYPE]');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20199, SQLCODE || ' => ' || SQLERRM);
    END Proc_Update_DOCUMENT_TYPE;
    
END PCK_DOCUMENT_TYPE;
