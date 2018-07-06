<!--#include file="../model/model_article.asp"-->
<%
    '../tool/tool_getJsonString.asp
%>
<%
    function createArticle(title, cover, content, status, typeId)
        call createArticle(title, cover, content, status, typeId)
        call getCustomJSONData(true, array(), array(), charSet) 
    end function

    function updateArticle(id, title, cover, content, status, typeId, viewCount)
        call model_updateArticle(id, title, cover, content, status, typeId, viewCount)
        call getCustomJSONData(true, array(), array(), charSet) 
    end function

    function getArticleList(limit, page, keyword, typeId, status, startTime, endTime)
        getArticleListSql=model_getArticleListSql(keyword, typeId, status, startTime, endTime)
        columnList=array("id", "title", "cover", "content", "viewCount", "status", "createTime", "typeId", "typeName", "typeIcon")
        call getRSJsonData(getArticleListSql,cn,limit,page,columnList,charSet,false,10)
    end function

    function getArticleDetail(id)
        set getArticleDetailRs=model_getArticleDetail(id)
        columnList=array("id", "title", "cover", "content", "viewCount", "status", "createTime", "typeId", "typeName", "typeIcon")
        call getJSONListData(getArticleDetailRs, columnList, charSet)
    end function

    function addArticleReadCount(id)
        call model_addArticleReadCount(id)
    end function
%>

