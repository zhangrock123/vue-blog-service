<%
	'###########################################################################################################################
	'## 
	'## 												��---����˵��---��
	'## 
	'##	chkNULL			��֤�����ֵ�Ƿ�ΪNull								���� ������ֵ or �գ�
	'##	outPrint		��������ֵ										���� ������ֵ��
	'##	outPrintln		�������ֵ�ӻ���									���� ������ֵ+���У�
	'##	getMoney		�������׼��ʽ����λ���ţ�����С�������λ��		���� ������׼��ʽ[������λ]��
	'##	Comma			�����λ���ţ�����ԭʼ���ȣ�						���� ����λ���Ÿ�ʽ������ֵ��
	'## notNullShow     �����ж� str��Ϊ�ռ���								����  �����ֵ returnString1����Ϊ�գ� returnString2 ��Ϊ�գ�
	'##
	'##
	'##
	'##
	'##
	'##
	'##
	'##
	'##
	'##
	'##
	'###########################################################################################################################
%>
<%
	function chkNULL(str)
		outWord=""
		if isnull(str)=false then
			outWord=str
		end if
		chkNULL=outWord
	end function
	
	function notNullShow(str,returnString1,returnString2)
		if str<> "" then
			notNullShow=returnString1
		else
			notNullShow=returnString2
		end if
	end function
	
	function outPrint(str)
		response.Write str
	end function
	
	function outPrintln(str)
		response.Write str&"<br />"
	end function
	
	Function getMoney(s)
		On Error Resume Next
		If Not IsNumeric(s) Then s = 0
		getMoney = FormatNumber(CDbl(s), 2, -1, 0, -1)   
	End Function
	
	Function Comma(str) 
		If Not(IsNumeric(str)) or str = 0 Then 
			Result = 0 
		ElseIf Len(Fix(str)) < 4 Then 
			Result = str 
		Else 
			Pos = Instr(1,str,".") 
			If Pos > 0 Then 
				Dec = Mid(str,Pos) 
			End if 
			Res = StrReverse(Fix(str)) 
			LoopCount = 1 
			While LoopCount <= Len(Res) 
				TempResult = TempResult + Mid(Res,LoopCount,3) 
				LoopCount = LoopCount + 3 
				If LoopCount <= Len(Res) Then 
				TempResult = TempResult + "," 
				End If 
			Wend 
			Result = StrReverse(TempResult) + Dec 
		End If 
		Comma = Result 
	End Function
	
	function chkLen(str,num)
		strLen=len(str)
		if strLen > num then
			chkLen=left(str,num)&"..."
		else
			chkLen=str
		end if
	end function
%>
 