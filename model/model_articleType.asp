<% 
    ' ../conn/conn.asp
%>
<%
    ' requesttip 表字段
    '   rt_status=1 未处理  rt_status＝2 接受  rt_status＝3 拒绝  rt_status＝99 删除
%>
<%
    function model_createArticleType(name, icon, status)
        if status = "" then status = 2
        model_createArticleTypeSql = "INSERT INTO articleType "&_
        "(at_name, at_icon, at_status, at_createTimeStamp ) "&_
        "VALUES('"& name &"', '"& icon &"', "& status&", now())"
        cn.execute(model_createArticleTypeSql)
    end function

    function model_updateArticleType(id, name, icon, status)
        model_updateArticleTypeAppendStr = ""
        if name <> "" then
            model_updateArticleTypeAppendStr=model_updateArticleTypeAppendStr&" at_name='"& name &"', "
        end if
        if icon <> "" then
            model_updateArticleTypeAppendStr=model_updateArticleTypeAppendStr&" at_icon='"& icon &"', "
        end if
        if status <> "" and (status=1 or status=2) then
            model_updateArticleTypeAppendStr=model_updateArticleTypeAppendStr&" at_status="& status &", "
        end if
        if model_updateArticleTypeAppendStr <> "" then
            model_updateArticleTypeSql="UPDATE articleType SET "& model_updateArticleTypeAppendStr &" WHERE at_id="& id
            cn.execute(model_updateArticleTypeSql)
        end if
    end function

    function model_getArticleTypeListSql(keyword, status)
        model_getArticleTypeListSqlAppendStr = ""
        if keyword <> "" then
            model_getArticleTypeListSqlAppendStr = model_getArticleTypeListSqlAppendStr&" and at_name like '%"&keyword&"%' "
        end if
        if status <> "" then
            model_getArticleTypeListSqlAppendStr = model_getArticleTypeListSqlAppendStr&" and at_status = "& status &" "
        end if
        model_getArticleTypeListSql="SELECT at_id as id, at_name as name, at_icon as icon, at_status as status, at_createTimeStamp as createTime "&_
        "FROM articleType WHERE 1=1"& model_getArticleTypeListSqlAppendStr &" ORDER BY at_id ASC"
    end function
%>