Attribute VB_Name = "modSQLQuery"
' Version : 0.2
' Author: Poon Yip Hoon
' Created on: 26 Aug 2017
' Modified on: 22 Feb 2018
' Modified on: 05 Jun 2018
' Descriptions: Commonly use database query for CRUD
' Dependencies: modDatabase

Option Explicit
'Public gstrSQL As String

Public Sub SQL_SET_Text(strField As String, strText As String, Optional blnEndComma As Boolean = True)
    gstrSQL = gstrSQL & " " & strField & " = '" & strText & "'"
    If blnEndComma = True Then
        gstrSQL = gstrSQL & ","
    End If
End Sub

Public Sub SQL_SET_Double(strField As String, dblNumber As Double, Optional blnEndComma As Boolean = True)
    gstrSQL = gstrSQL & " " & strField & " = " & dblNumber
    If blnEndComma = True Then
        gstrSQL = gstrSQL & ","
    End If
End Sub

Public Sub SQL_SET_Long(strField As String, lngNumber As Long, Optional blnEndComma As Boolean = True)
    gstrSQL = gstrSQL & " " & strField & " = " & lngNumber
    If blnEndComma = True Then
        gstrSQL = gstrSQL & ","
    End If
End Sub

Public Sub SQL_SET_Boolean(strField As String, blnValue As Boolean, Optional blnEndComma As Boolean = True)
    gstrSQL = gstrSQL & " " & strField
    If blnValue Then
        gstrSQL = gstrSQL & " = TRUE"
    Else
        gstrSQL = gstrSQL & " = FALSE"
    End If
    If blnEndComma = True Then
        gstrSQL = gstrSQL & ","
    End If
End Sub

Public Sub SQL_SET_DateTime(strField As String, strDateTime As String, Optional blnEndComma As Boolean = True)
    gstrSQL = gstrSQL & " " & strField & " = #" & strDateTime & "#"
    If blnEndComma = True Then
        gstrSQL = gstrSQL & ","
    End If
End Sub

Public Sub SQLText(strText As String, Optional blnEndComma As Boolean = True, Optional blnBeginSpace As Boolean = True)
    If blnBeginSpace = True Then
        gstrSQL = gstrSQL & " "
    End If
    gstrSQL = gstrSQL & strText
    If blnEndComma = True Then
        gstrSQL = gstrSQL & ","
    End If
End Sub

Public Sub SQL_WHERE_Text(strField As String, strText As String)
    gstrSQL = gstrSQL & " WHERE " & strField & " = '" & strText & "'"
End Sub

Public Sub SQL_WHERE_Long(strField As String, lngNumber As Long)
    gstrSQL = gstrSQL & " WHERE " & strField & " = " & lngNumber
End Sub

Public Sub SQL_WHERE_Integer(strField As String, intNumber As Integer)
    gstrSQL = gstrSQL & " WHERE " & strField & " = " & intNumber
End Sub

Public Sub SQL_WHERE_Boolean(strField As String, blnBoolean As Boolean)
    'gstrSQL = gstrSQL & " WHERE " & strField & " = " & blnBoolean
    If blnBoolean Then
        gstrSQL = gstrSQL & " WHERE " & strField & " = Yes"
    Else
        gstrSQL = gstrSQL & " WHERE " & strField & " = No"
    End If
End Sub

Public Sub SQL_WHERE_BETWEEN(strField As String, strLeftValue As String, strRightValue As String)
    gstrSQL = gstrSQL & " WHERE " & strField & " BETWEEN " & strLeftValue & " AND " & strRightValue
End Sub

Public Sub SQL_WHERE_LIKE_Text(strField As String, strText As String)
    gstrSQL = gstrSQL & " WHERE " & strField & " LIKE '%" & strText & "%'"
End Sub

Public Sub SQL_OR_LIKE_Text(strField As String, strText As String)
    gstrSQL = gstrSQL & " OR " & strField & " LIKE '%" & strText & "%'"
End Sub

Public Sub SQL_AND_Text(strField As String, strText As String)
    gstrSQL = gstrSQL & " AND " & strField & " = '" & strText & "'"
End Sub

Public Sub SQL_ORDER_BY(strField As String, Optional blnAscending As Boolean = True)
    gstrSQL = gstrSQL & " ORDER BY " & strField
    If blnAscending = False Then
        gstrSQL = gstrSQL & " DESC"
    End If
End Sub

Public Sub SQL_INNER_JOIN(strTable1 As String, strTable2 As String, strCommonField1 As String, strCommonField2 As String)
    'SQLText "FROM " & strTable1, False
    SQLText "INNER JOIN " & strTable2, False
    SQLText "ON " & strTable1 & "." & strCommonField1 & " = " & strTable2 & "." & strCommonField2, False
End Sub

Public Sub SQL_LEFT_JOIN(strTable1 As String, strTable2 As String, strCommonField1 As String, strCommonField2 As String)
    'SQLText "FROM " & strTable1, False
    SQLText "LEFT JOIN " & strTable2, False
    SQLText "ON " & strTable1 & "." & strCommonField1 & " = " & strTable2 & "." & strCommonField2, False
End Sub

Public Sub SQL_SELECT()
    gstrSQL = "SELECT"
End Sub

Public Sub SQL_SELECT_ALL(strTable As String)
    gstrSQL = "SELECT * FROM " & strTable
End Sub

Public Sub SQL_SELECT_TOP(strField As String, strTable As String, Optional intTop As Integer = 1)
    gstrSQL = "SELECT TOP " & intTop & " " & strField & " FROM " & strTable
End Sub

Public Sub SQL_SELECT_ID(strTable As String, Optional intTop As Integer = 1)
    If intTop > 0 Then
        gstrSQL = "SELECT TOP " & intTop & " ID FROM " & strTable
    Else
        gstrSQL = "SELECT ID FROM " & strTable
    End If
End Sub

Public Sub SQL_FROM(strTable As String)
    gstrSQL = gstrSQL & " FROM " & strTable
End Sub

Public Sub SQL_INSERT(strTable As String)
    gstrSQL = "INSERT INTO " & strTable & " ("
End Sub

Public Sub SQL_VALUES()
    gstrSQL = gstrSQL & ") VALUES ("
End Sub

Public Sub SQL_UPDATE(strTable As String)
    gstrSQL = "UPDATE " & strTable & " SET"
End Sub

Public Sub SQL_DELETE(strTable As String)
    gstrSQL = "DELETE FROM " & strTable
End Sub

Public Sub SQL_DROP(strTable As String)
    gstrSQL = "DROP TABLE [" & strTable & "]"
End Sub

' References:
' http://allenbrowne.com/ser-49.html
' https://docs.microsoft.com/en-us/sql/odbc/microsoft/microsoft-access-data-types
' https://msdn.microsoft.com/en-us/library/aa140015(office.10).aspx (VERY GOOD)

Public Sub SQL_CREATE(strTable As String, Optional strPrefix As String = "")
    gstrSQL = "CREATE TABLE " & strPrefix & strTable
    gstrSQL = gstrSQL & " ("
End Sub

Public Sub SQL_COLUMN_ID(Optional strColumnName As String = "ID", Optional blnPrimaryKey As Boolean = True, Optional blnAutoIncrement As Boolean = True, Optional blnEndComma As Boolean = True)
    'gstrSQL = gstrSQL & "[" & strColumnName & "]"
    gstrSQL = gstrSQL & strColumnName
    If blnAutoIncrement Then gstrSQL = gstrSQL & " AUTOINCREMENT"
    If blnPrimaryKey Then gstrSQL = gstrSQL & " PRIMARY KEY"
    If blnEndComma = True Then gstrSQL = gstrSQL & "," 'gstrSQL = gstrSQL & ","
End Sub

' Short Text
Public Sub SQL_COLUMN_TEXT(strColumnName As String, Optional intLength As Integer = 255, Optional strDefault As String = "", Optional blnNullable As Boolean = True, Optional blnBeginSpace As Boolean = True, Optional blnEndComma As Boolean = True)
    If blnBeginSpace Then gstrSQL = gstrSQL & " "
    gstrSQL = gstrSQL & strColumnName & " TEXT(" & intLength & ")"
    If strDefault <> "" Then gstrSQL = gstrSQL & " DEFAULT """ & strDefault & """"
    If Not blnNullable Then gstrSQL = gstrSQL & " NOT NULL"
    If blnEndComma = True Then gstrSQL = gstrSQL & ","
End Sub

' Long Text
Public Sub SQL_COLUMN_MEMO(strColumnName As String, Optional strDefault As String = "", Optional blnNullable As Boolean = True, Optional blnBeginSpace As Boolean = True, Optional blnEndComma As Boolean = True)
    If blnBeginSpace Then gstrSQL = gstrSQL & " "
    gstrSQL = gstrSQL & strColumnName & " MEMO"
    If strDefault <> "" Then gstrSQL = gstrSQL & " DEFAULT " & strDefault
    If Not blnNullable Then gstrSQL = gstrSQL & " NOT NULL"
    If blnEndComma = True Then gstrSQL = gstrSQL & ","
End Sub

' NOTE: Not yet used or tested
Public Sub SQL_COLUMN_NUMBER(strColumnName As String, Optional strFieldSize As String = "LONG", Optional strDefault As String = "", Optional blnNullable As Boolean = True, Optional blnBeginSpace As Boolean = True, Optional blnEndComma As Boolean = True)
    If blnBeginSpace Then gstrSQL = gstrSQL & " "
    Select Case strFieldSize
        Case "BYTE"
            gstrSQL = gstrSQL & strColumnName & " BYTE"
        Case "SHORT"
            gstrSQL = gstrSQL & strColumnName & " SHORT"
        Case "INTEGER" ' Same as SHORT ?
            gstrSQL = gstrSQL & strColumnName & " INTEGER"
        Case "LONG" ' Default
            gstrSQL = gstrSQL & strColumnName & " LONG"
        Case "SINGLE"
            gstrSQL = gstrSQL & strColumnName & " SINGLE"
        Case "DOUBLE"
            gstrSQL = gstrSQL & strColumnName & " DOUBLE"
        Case "REPLICA", "GUID"
            gstrSQL = gstrSQL & strColumnName & " GUID"
        Case "DECIMAL"
            gstrSQL = gstrSQL & strColumnName & " DECIMAL (18, 0)" ' (precision, scale) 9, 4
        Case Else ' LONG
            gstrSQL = gstrSQL & strColumnName & " LONG"
    End Select
    If strDefault <> "" Then gstrSQL = gstrSQL & " DEFAULT " & strDefault
    If Not blnNullable Then gstrSQL = gstrSQL & " NOT NULL"
    If blnEndComma = True Then gstrSQL = gstrSQL & ","
End Sub

Public Sub SQL_COLUMN_BIT(strColumnName As String, Optional strDefault As String = "-1", Optional blnNullable As Boolean = True, Optional blnBeginSpace As Boolean = True, Optional blnEndComma As Boolean = True)
    If blnBeginSpace Then gstrSQL = gstrSQL & " "
    gstrSQL = gstrSQL & strColumnName & " BIT"
    If strDefault <> "" Then gstrSQL = gstrSQL & " DEFAULT " & strDefault
    If Not blnNullable Then gstrSQL = gstrSQL & " NOT NULL"
    If blnEndComma = True Then gstrSQL = gstrSQL & ","
End Sub

' Same as SQL_COLUMN_BIT
Public Sub SQL_COLUMN_YESNO(strColumnName As String, Optional strDefault As String = "Yes", Optional blnNullable As Boolean = True, Optional blnBeginSpace As Boolean = True, Optional blnEndComma As Boolean = True)
    If blnBeginSpace Then gstrSQL = gstrSQL & " "
    gstrSQL = gstrSQL & strColumnName & " YESNO"
    If strDefault <> "" Then gstrSQL = gstrSQL & " DEFAULT " & strDefault
    If Not blnNullable Then gstrSQL = gstrSQL & " NOT NULL"
    If blnEndComma = True Then gstrSQL = gstrSQL & ","
End Sub

Public Sub SQL_COLUMN_DATETIME(strColumnName As String, Optional strDefault As String = "", Optional blnNullable As Boolean = True, Optional blnBeginSpace As Boolean = True, Optional blnEndComma As Boolean = True)
    If blnBeginSpace Then gstrSQL = gstrSQL & " "
    gstrSQL = gstrSQL & strColumnName & " DATETIME"
    If strDefault <> "" Then gstrSQL = gstrSQL & " DEFAULT " & strDefault
    If Not blnNullable Then gstrSQL = gstrSQL & " NOT NULL"
    If blnEndComma = True Then gstrSQL = gstrSQL & ","
End Sub

Public Sub SQL_Comma()
    gstrSQL = gstrSQL & ","
End Sub

Public Sub SQL_Close_Bracket()
    gstrSQL = gstrSQL & ")"
End Sub

Public Sub SQLData_Text(strText As String, Optional blnEndComma As Boolean = True, Optional blnBeginSpace As Boolean = True)
    If blnBeginSpace = True Then
        gstrSQL = gstrSQL & " "
    End If
    gstrSQL = gstrSQL & "'" & CheckString(strText) & "'"
    If blnEndComma = True Then
        gstrSQL = gstrSQL & ","
    End If
End Sub

Public Sub SQLData_Double(dblNumber As Double, Optional blnEndComma As Boolean = True)
    gstrSQL = gstrSQL & " " & dblNumber
    If blnEndComma = True Then
        gstrSQL = gstrSQL & ","
    End If
End Sub

Public Sub SQLData_Long(lngNumber As Long, Optional blnEndComma As Boolean = True)
    gstrSQL = gstrSQL & " " & lngNumber
    If blnEndComma = True Then
        gstrSQL = gstrSQL & ","
    End If
End Sub

Public Sub SQLData_Integer(intNumber As Integer, Optional blnEndComma As Boolean = True)
    gstrSQL = gstrSQL & " " & intNumber
    If blnEndComma = True Then
        gstrSQL = gstrSQL & ","
    End If
End Sub

Public Sub SQLData_Boolean(blnValue As Boolean, Optional blnEndComma As Boolean = True)
    If blnValue Then
        gstrSQL = gstrSQL & " TRUE"
    Else
        gstrSQL = gstrSQL & " FALSE"
    End If
    If blnEndComma = True Then
        gstrSQL = gstrSQL & ","
    End If
End Sub

Public Sub SQLData_DateTime(strDateTime As String, Optional blnEndComma As Boolean = True)
    gstrSQL = gstrSQL & " #" & strDateTime & "#"
    If blnEndComma = True Then
        gstrSQL = gstrSQL & ","
    End If
End Sub
