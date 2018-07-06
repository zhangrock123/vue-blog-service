<!--#include file="controller/ctrl_overall.asp"-->
<!--#include file="controller/ctrl_article.asp"-->
<!--#include file="controller/ctrl_articleType.asp"-->

<%
    if action="createArticleType" then
        adminToken=request.form("token")
        name=request.form("name")
        icon=request.form("icon")

        paramArr=array(adminToken, name, icon)
        errArr=array("token信息为空","类别名称为空","类别图标为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(adminToken)

        call createArticleType(name, icon, 2)
    ' 用户注册
    elseif action="setArticleTypeStatus" then
        adminToken=request.form("token")
        id=request.form("id")
        status=request.form("status")

        paramArr=array(adminToken, id, status)
        errArr=array("token信息为空","id为空", "状态为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(adminToken)
        call updateArticleType(id, "", "", status)
    ' 设置头像
    elseif action="updateArticleType" then
        adminToken=request.form("token")
        id=request.form("id")
        name=request.form("name")
        icon=request.form("icon")
        status=request.form("status")

        paramArr=array(adminToken, id)
        errArr=array("token信息为空","id为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(adminToken)
        call updateArticleType(id, name, icon, status)
    ' 设置密码
    elseif action="getArticleTypeList" then
        adminToken=request.queryString("token")
        limit=request.queryString("limit")
        page=request.queryString("page")
        keyword=request.queryString("keyword")
        status=request.queryString("status")

        paramArr=array(adminToken)
        errArr=array("token信息为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(adminToken)

        if page ="" then
            page=1
        end if
        if limit="" then
            limit=10
        end if

        call getArticleTypeList(limit, page, keyword, status)
    ' 查找用户
    elseif action="createArticle" then
        adminToken=request.form("token")
        title=request.form("title")
        cover=request.form("cover")
        content=request.form("content")
        typeId=request.form("typeId")

        paramArr=array(adminToken, title,cover,content,typeId)
        errArr=array("token信息为空", "标题为空","封面照为空","内容为空","类别为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(adminToken)

        call createArticle(title, cover, content, 2, typeId)
    elseif action="setArticleStatus" then
        adminToken=request.form("token")
        id=request.form("id")
        status=request.form("stauts")

        paramArr=array(adminToken, id, status)
        errArr=array("token信息为空","id为空", "状态为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(adminToken)
        call updateArticle(id, "", "", "", status, "", "")
    elseif action="updateArticle" then
        adminToken=request.form("token")
        id=request.form("id")
        title=request.form("title")
        cover=request.form("cover")
        content=request.form("content")
        typeId=request.form("typeId")

        paramArr=array(adminToken, id)
        errArr=array("token信息为空", "id为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(adminToken)

        call createArticle(id, title, cover, content, "", typeId, "")
    elseif action="getArticleList" then
        adminToken=request.queryString("token")
        limit=request.queryString("limit")
        page=request.queryString("page")
        keyword=request.queryString("keyword")
        status=request.queryString("status")
        typeId=request.queryString("typeId")
        startTime=request.queryString("start")
        endTime=request.queryString("end")

        paramArr=array(adminToken)
        errArr=array("token信息为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(adminToken)

        if page ="" then
            page=1
        end if
        if limit="" then
            limit=10
        end if

        call getArticleList(limit, page, keyword, typeId, status, startTime, endTime)
    elseif action="getArticleDetail" then
        adminToken=request.queryString("token")
        id=request.queryString("id")
        ' isNoUpdateCount  为1表示不更新文章阅读量
        isNoUpdateCount=request.queryString("update") 

        paramArr=array(adminToken, id)
        errArr=array("token信息为空", "id为空")
        call checkParam(paramArr, errArr)

        call checkCustomerAuth(adminToken)

        if isNoUpdateCount = "" then
            call addArticleReadCount(id)
        end if

        call getArticleDetail(id)
    end if
%>

<!--#include file="controller/ctrl_error.asp"-->