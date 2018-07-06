<!--#include file="controller/ctrl_overall.asp"-->
<!--#include file="controller/ctrl_customer.asp"-->

<%
    ' 用户登录
    if action="userLogin" then
        userName=request.form("name")
        userPassword=request.form("pasword")
        imgToken=request.form("imgToken")
        imgCode=request.form("code")


        paramArr=array(userName, userPassword, imgToken, imgCode)
        errArr=array("用户名为空","密码为空","图片token信息缺失","验证码为空")
        call checkParam(paramArr, errArr)

        call checkImgCodeAuth(imgToken, imgCode)
        call userLogin(userName, userPassword)
        call setImgTokenExpire(imgToken)

    elseif action="changePassword" then
        customerToken=request.form("token")
        oldPassword=request.form("oldPassword")
        newPassword=request.form("newPassword")

        paramArr=array(customerToken, oldPassword, newPassword)
        errArr=array("token信息为空","原始密码为空","新密码为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        customerId=getCustomerId(customerToken)

        call changePassword(customerId, oldPassword, newPassword)
    elseif action="myInfo" then
        customerToken=request.queryString("token")

        paramArr=array(customerToken)
        errArr=array("token信息为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(customerToken)
        call userInfo(customerToken)
    elseif action="ttxx" then
        call userRegist("rock", "rock")
        call getCustomJSONData(true, array(), array(), charSet)  

    end if
%>

<!--#include file="controller/ctrl_error.asp"-->