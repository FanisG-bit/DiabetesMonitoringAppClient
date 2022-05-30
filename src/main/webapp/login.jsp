<%--
  Created by IntelliJ IDEA.
  User: Fanis
  Date: 5/25/2022
  Time: 1:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<head>
    <title>Login Page</title>
</head>
<style type="text/css">
    * {
        margin: 0px;
        padding: 0px;
        box-sizing: border-box;
    }
</style>
<body>
<div style="width: 100%;">
    <div style="width: 175px; margin-left: auto; margin-right: auto; margin-top: 100px; display: block;">
        Username: <input id="username" name="username" type="text"><br><br>
        Password: <input id="password" name="password" type="password"><br><br>
        <input type="submit" id="submit" style="margin-left:auto;margin-right:auto; display: block;"><br>
    </div>
</div>
</body>
<script type="application/javascript">
    $('#submit').click(function(){
        var credentials = {
            username : $('#username').val(),
            password : $('#password').val()
        };
        $.ajax({
            type : "POST",
            dataType : "json",
            contentType : "application/json",
            data : JSON.stringify(credentials),
            url : "http://localhost:8090/DiabetesMonitoringApp_war_exploded/api/operations/validateUser",
            async : false,
            success : function(responseData) {
                if (responseData === true) {
                    window.location.href = "<%=request.getContextPath()%>/userValidationServlet?username="
                        + credentials.username + "&password=" + credentials.password;
                } else {
                    console.log('Access Denied');
                }
            },
            error : function(error) {}
        });
    });
</script>
</html>
