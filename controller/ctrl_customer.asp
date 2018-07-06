<!--#include file="../model/model_customer.asp"-->
<%
    '../tool/tool_getJsonString.asp
    '../tool/tool_md5.asp
%>
<%
    ' 用户登录
    function userLogin(name, pwd)
        pwd=md5(pwd,32)
        set getUserInfoRs=model_getUserInfoRsByNameAndPwd(name, pwd)
        if getUserInfoRs.eof then
            call getCustomJSONErrData("3002","用户名或密码错误",charSet)
        else
            if getUserInfoRs("adm_status") = 1 then
                userId=getUserInfoRs("adm_id")
                call model_resetUserTokenById(userId)
                set userInfoRs=model_getUserInfoRsById(userId)
                columnList=array("userName","userToken","tokenExpire","createTime")
                call getJSONMainData(userInfoRs, columnList,charSet)
            else
                call getCustomJSONErrData("3003","该用户已被冻结",charSet)
            end if
        end if
    end function

    ' 用户注册
    function userRegist(name, pwd)
        pwd=md5(pwd,32)
        call model_createUserInfo(name, pwd)
        call getCustomJSONData(true, array(), array(), charSet)  
    end function


    ' 重置密码
    function changePassword(customerId, oldPwd, newPwd)
        set oldPwdRs=model_getCustomerPasswordRsById(customerId)
        oldPasswordInfo=oldPwdRs("userPwd")
        oldPwd=md5(oldPwd,32)
        newPwd=md5(newPwd,32)
        
        if oldPasswordInfo<>oldPwd then
            call getCustomJSONErrData("3004","原密码不正确",charSet)
            response.end
        end if
        if newPwd <> oldPwd then
            call model_changePassword(customerId, newPwd)
        end if
        call getCustomJSONData(true, array(), array(), charSet)  
    end function

    ' 根据token获取用户自己的信息
    function userInfo(token)
        set userInfoRs=model_getUserInfoRsByToken(token)
        columnList=array("userName","status","userToken","createTime","tokenExpire")
        call getJSONMainData(userInfoRs, columnList,charSet)
    end function

    ' 修改个人信息
    function changeMyInfo(id, photo, remark, email, phone)
        call model_setUserInfo(id, "", "", photo, remark, email, phone, 1)
        call getCustomJSONData(true, array(), array(), charSet)  
    end function
%>

