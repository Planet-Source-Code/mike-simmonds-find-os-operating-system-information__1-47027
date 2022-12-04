Attribute VB_Name = "modOS"
Public Declare Function GetVersionExA Lib "kernel32" _
         (lpVersionInformation As OSVERSIONINFO) As Integer

      Public Type OSVERSIONINFO
         dwOSVersionInfoSize As Long
         dwMajorVersion As Long
         dwMinorVersion As Long
         dwBuildNumber As Long
         dwPlatformId As Long
         szCSDVersion As String * 128
      End Type

      Public Function getVersion() As String
         Dim osinfo As OSVERSIONINFO
         Dim retvalue As Integer

         osinfo.dwOSVersionInfoSize = 148
         osinfo.szCSDVersion = Space$(128)
         retvalue = GetVersionExA(osinfo)

         With osinfo
         Select Case .dwPlatformId

          Case 1
          
              Select Case .dwMinorVersion
                  Case 0
                      getVersion = "Microsoft Windows 95"
                  Case 10
                      If .dwBuildNumber >= 2183 Then
                          getVersion = "Microsoft Windows 98 Second Edition"
                      Else
                          getVersion = "Microsoft Windows 98"
                      End If
                  Case 90
                      getVersion = "Microsoft Windows Mellinnium Edition"
              End Select

          Case 2
              Select Case .dwMajorVersion
                  Case 3
                      getVersion = "Microsoft Windows NT 3.51"
                  Case 4
                      getVersion = "Microsoft Windows NT 4.0"
                  Case 5
                      If .dwMinorVersion = 0 Then
                          getVersion = "Microsoft Windows 2000"
                      ElseIf .dwMinorVersion = 1 Then
                          getVersion = "Microsoft Windows XP"
                      Else
                          getVersion = "Microsoft Windows Sever 2003"
                      End If
              End Select

          Case Else
             getVersion = "Failed"
             
        End Select

         
         Form1.Label1.Caption = getVersion & vbCrLf & "Plat form ID: " & .dwPlatformId & vbCrLf & "Version: " & .dwMajorVersion & "." & .dwMinorVersion & "." & vbCrLf & "Build: " & .dwBuildNumber & vbCrLf & .szCSDVersion

         End With
               
      End Function
