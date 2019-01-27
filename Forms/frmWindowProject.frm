VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmWindowProject 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "Project"
   ClientHeight    =   3495
   ClientLeft      =   120
   ClientTop       =   390
   ClientWidth     =   3765
   Icon            =   "frmWindowProject.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3495
   ScaleWidth      =   3765
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList istIcons 
      Left            =   2880
      Top             =   2640
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      UseMaskColor    =   0   'False
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmWindowProject.frx":000C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmWindowProject.frx":62A6
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmWindowProject.frx":7168
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmWindowProject.frx":7FBA
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmWindowProject.frx":8E7C
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmWindowProject.frx":9B56
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.TreeView tvwFiles 
      Height          =   3135
      Left            =   0
      TabIndex        =   0
      Top             =   360
      Width           =   3735
      _ExtentX        =   6588
      _ExtentY        =   5530
      _Version        =   393217
      Indentation     =   573
      Style           =   7
      ImageList       =   "istIcons"
      Appearance      =   1
   End
End
Attribute VB_Name = "frmWindowProject"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
    ReadItemsData
End Sub

Public Sub ReadItemsData()
Dim DB As New OmlDatabase
Dim SQ As New OmlSQLBuilder
Dim rst As ADODB.Recordset
Dim i As Integer
Dim strLabel As String
Dim strKey As String
Dim nod As Node
On Error GoTo Catch
    If gstrProjectName = "" Then Exit Sub
    With tvwFiles
        .Enabled = False
        .Nodes.Clear
    End With
    With DB
        DB.DataPath = gstrProjectDataPath & "\"
        DB.DataFile = gstrProjectItemsFile
        DB.OpenMdb
        SQ.SELECT_ALL "Project"
        SQ.WHERE_Text "ProjectName", gstrProjectName
        Set rst = DB.OpenRs(SQ.Text)
        If DB.ErrorDesc <> "" Then
            LogError "Error", "ReadItemsData/frmWindowProject", DB.ErrorDesc
            DB.CloseRs rst
            DB.CloseMdb
            Exit Sub
        End If
        If Not (rst Is Nothing Or rst.EOF) Then
            rst.MoveFirst
            strKey = "G1"
            strLabel = rst!ProjectName & " (" & rst!ProjectFile & ")"
            Set nod = tvwFiles.Nodes.Add(, tvwChild, strKey, strLabel, 1)
            nod.Bold = True
            nod.Expanded = True
        End If
        DB.CloseRs rst
            
        SQ.SELECT_ALL "Forms"
        Set rst = DB.OpenRs(SQ.Text)
        If DB.ErrorDesc <> "" Then
            LogError "Error", "ReadItemsData/frmWindowProject", DB.ErrorDesc
            DB.CloseRs rst
            DB.CloseMdb
            Exit Sub
        End If
        If Not (rst Is Nothing Or rst.EOF) Then
            strKey = "Forms"
            strLabel = "Forms"
            Set nod = tvwFiles.Nodes.Add("G1", tvwChild, strKey, strLabel, 2)
            nod.Expanded = True
            'rst.MoveFirst
            While Not rst.EOF
                i = i + 1
                strKey = "Item" & i
                strLabel = rst!FormName & " (" & rst!FormFile & ")"
                Set nod = tvwFiles.Nodes.Add("Forms", tvwChild, strKey, strLabel, 3)
                rst.MoveNext
            Wend
        End If
        DB.CloseRs rst
        
        SQ.SELECT_ALL "Modules"
        Set rst = DB.OpenRs(SQ.Text)
        If DB.ErrorDesc <> "" Then
            LogError "Error", "ReadItemsData/frmWindowProject", DB.ErrorDesc
            DB.CloseRs rst
            DB.CloseMdb
            Exit Sub
        End If
        If Not (rst Is Nothing Or rst.EOF) Then
            strKey = "Modules"
            strLabel = "Modules"
            Set nod = tvwFiles.Nodes.Add("G1", tvwChild, strKey, strLabel, 2)
            nod.Expanded = True
            'rst.MoveFirst
            While Not rst.EOF
                i = i + 1
                strKey = "Item" & i
                strLabel = rst!ModuleName & " (" & rst!ModuleFile & ")"
                Set nod = tvwFiles.Nodes.Add("Modules", tvwChild, strKey, strLabel, 4)
                rst.MoveNext
            Wend
        End If
        DB.CloseRs rst
        
        SQ.SELECT_ALL "Class"
        Set rst = DB.OpenRs(SQ.Text)
        If DB.ErrorDesc <> "" Then
            LogError "Error", "ReadItemsData/frmWindowProject", DB.ErrorDesc
            DB.CloseRs rst
            DB.CloseMdb
            Exit Sub
        End If
        If Not (rst Is Nothing Or rst.EOF) Then
            strKey = "Class"
            strLabel = "Class"
            Set nod = tvwFiles.Nodes.Add("G1", tvwChild, strKey, strLabel, 2)
            nod.Expanded = True
            'rst.MoveFirst
            While Not rst.EOF
                i = i + 1
                strKey = "Item" & i
                strLabel = rst!ClassName & " (" & rst!ClassFile & ")"
                Set nod = tvwFiles.Nodes.Add("Class", tvwChild, strKey, strLabel, 5)
                rst.MoveNext
            Wend
        End If
        DB.CloseRs rst
        DB.CloseMdb
    End With
    tvwFiles.Enabled = True
    Exit Sub
Catch:
    LogError "Error", "ReadItemsData/frmWindowProject", Err.Description
    DB.CloseRs rst
    DB.CloseMdb
End Sub
