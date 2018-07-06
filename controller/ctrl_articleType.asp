<!--#include file="../model/model_articleType.asp"-->
<%
    '../tool/tool_getJsonString.asp
%>
<%
    function createArticleType(name, icon, status)
        call model_createArticleType(name, icon, status)
        call getCustomJSONData(true, array(), array(), charSet) 
    end function

    function updateArticleType(id, name, icon, status)
        call model_updateArticleType(id, name, icon, status)
        call getCustomJSONData(true, array(), array(), charSet) 
    end function

    function getArticleTypeList(limit, page, keyword, status)
        getArticleTypeListSql=model_getArticleTypeListSql(keyword, status)
        columnList=array("id","name","icon","status","createTime")
        call getRSJsonData(getArticleTypeListSql,cn,limit,page,columnList,charSet,false,10)
    end function
%>

