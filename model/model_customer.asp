<% 
    ' ../conn/conn.asp
%>
<%
    ' 根据用户名密码获取用户信息sql
    function model_getUserInfoRsByNameAndPwd(name, pwd)
        model_getUserInfoRsByNameAndPwdSql="SELECT TOP 1 * FROM admin WHERE adm_name='"& name &"' and adm_pwd='"& pwd &"'"
        set model_getUserInfoRsByNameAndPwd=cn.execute(model_getUserInfoRsByNameAndPwdSql)
    end function

    ' 注册用户信息
    function model_createUserInfo(name, pwd)
        if status = "" then status = 1
        model_createUserInfoSql="INSERT INTO admin "&_
        "( adm_name, adm_pwd, adm_status, adm_createStamp) "&_
        "VALUES( '"& name &"', '"& pwd &"', 1, now())"
        cn.execute(model_createUserInfoSql)
    end function


    ' 根据用户token信息获取用户信息
    function model_getUserInfoRsByToken(token)
        model_getUserInfoRsByTokenSql="SELECT TOP 1 "&_
            "adm_name as userName, adm_status as status, "&_
            "adm_token as userToken, adm_tokenExpire as tokenExpire, "&_
            "c_createStamp as createTime "&_
        "FROM admin WHERE adm_token='"& token &"'"
        set model_getUserInfoRsByToken=cn.execute(model_getUserInfoRsByTokenSql)
    end function

    function model_getUserInfoRsById(id)
        model_getUserInfoRsByIdSql="SELECT TOP 1 "&_
            "adm_name as userName, adm_status as status, "&_
            "adm_token as userToken, adm_tokenExpire as tokenExpire, "&_
            "c_createStamp as createTime "&_
        "FROM admin WHERE adm_id="&id
        set model_getUserInfoRsById = cn.execute(model_getUserInfoRsByIdSql)
    end function

    ' 根据用户id重置用户token信息
    function model_resetUserTokenById(id)
        model_resetUserTokenById_expire=CDate(DateAdd("d",30,date()))
        model_resetUserTokenById_token=getToken()
        model_resetUserTokenByIdSql="UPDATE admin SET adm_token = '"& model_resetUserTokenById_token &"', adm_tokenExpire=#"& model_resetUserTokenById_expire &"# WHERE adm_id="& id
        cn.execute(model_resetUserTokenByIdSql)
    end function


    ' 设置某用户的密码
    function model_changePassword(customerId, newPwd)
        model_changePasswordSql="UPDATE admin SET adm_pwd='"&newPwd&"' WHERE adm_id="&customerId
        cn.execute(model_changePasswordSql)
    end function

    ' 查询某用户的密码
    function model_getCustomerPasswordRsById(customerId)
        model_getCustomerPasswordRsByIdSql="SELECT adm_pwd as userPwd FROM admin WHERE adm_id="&customerId
        set model_getCustomerPasswordRsById=cn.execute(model_getCustomerPasswordRsByIdSql)
    end function
%>