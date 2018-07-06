<% 
    ' ../conn/conn.asp
%>
<%
    ' requesttip 表字段
    '   rt_status=1 未处理  rt_status＝2 接受  rt_status＝3 拒绝  rt_status＝99 删除
%>
<%
    function createArticle(title, cover, content, status, typeId)
        if status = "" then status = 2
        createArticleSql = "INSERT INTO article "&_
        "(a_title, a_cover, a_content, a_viewCount, a_status, a_createTimeStamp, a_at_id) "&_
        "VALUES('"& title &"', '"& cover &"', '"& content &"', 0, 2, now(), "& typeId &")"
        cn.execute(createArticleSql)
    end function

    function model_updateArticle(id, title, cover, content, status, typeId, viewCount)
        model_updateArticleAppendStr = ""
        if title <> "" then
            model_updateArticleAppendStr = model_updateArticleAppendStr & " a_title = '"& title&"', "
        end if
        if cover <> "" then
            model_updateArticleAppendStr = model_updateArticleAppendStr & " a_cover = '"& cover&"', "
        end if
        if content <> "" then
            model_updateArticleAppendStr = model_updateArticleAppendStr & " a_content = '"& content&"', "
        end if
        if status <> "" then
            model_updateArticleAppendStr = model_updateArticleAppendStr & " a_status = "& status &", "
        end if
        if typeId <> "" then
            model_updateArticleAppendStr = model_updateArticleAppendStr & " a_at_id = "& typeId &", "
        end if
        if viewCount <> "" then
            model_updateArticleAppendStr = model_updateArticleAppendStr & " a_viewCount = "& viewCount&", "
        end if
        if model_updateArticleAppendStr <> "" then
            model_updateArticleSql="UPDATE article SET "& model_updateArticleAppendStr &" WHERE a_id="& id
            cn.execute(model_updateArticleSql)
        end if
    end function

    function model_getArticleListSql(keyword, typeId, status, startTime, endTime)
        model_getArticleListSqlAppendStr=""
        if keyword <> "" then
            model_getArticleListSqlAppendStr = model_getArticleListSqlAppendStr&" and a_title like '&"& keyword &"&' "
        end if
        if typeId <> "" then
            model_getArticleListSqlAppendStr = model_getArticleListSqlAppendStr&" and a_at_id="& typeId&" "
        end if
        if status <> "" then
           model_getArticleListSqlAppendStr = model_getArticleListSqlAppendStr&" and a_status="&status&" "
        end if
        if startTime <> "" then
           model_getArticleListSqlAppendStr = model_getArticleListSqlAppendStr&" and a_createTimeStamp >= #"& startTime &"# "
        end if
        if endTime <> "" then
           model_getArticleListSqlAppendStr = model_getArticleListSqlAppendStr&" and a_createTimeStamp <= #"& startTime &"# "
        end if

        model_getArticleListSql="SELECT a.a_id as id, a.a_title as title, a.a_cover as cover, "&_
        "a.a_content as content, a.a_viewCount as viewCount, a.a_status as status, a.a_createTimeStamp as createTime, "&_
        "at.at_id as typeId, at.at_name as typeName, at.at_icon as typeIcon"&_
        "FROM article a, articleType at "&_
        "WHERE a.a_at_id = at.at_id "&_
        "ORDER BY a.a_id DESC"
    end function

    function model_getArticleDetail(id)
        model_getArticleDetailSql = "SELECT a.a_id as id, a.a_title as title, a.a_cover as cover, "&_
        "a.a_content as content, a.a_viewCount as viewCount, a.a_status as status, a.a_createTimeStamp as createTime, "&_
        "at.at_id as typeId, at.at_name as typeName, at.at_icon as typeIcon"&_
        "FROM article a, articleType at "&_
        "WHERE a.a_at_id = at.at_id and a.a_id="id
        set model_getArticleDetail=cn.execute(model_getArticleDetailSql)
    end function

    function model_addArticleReadCount(id)
        model_addArticleReadCountSql="UPDATE article SET a_viewCount = a_viewCount + 1 WHERE a_id = "&id
        cn.execute(model_addArticleReadCountSql)
    end function
%>