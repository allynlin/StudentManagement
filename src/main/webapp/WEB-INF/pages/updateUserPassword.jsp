<%--
  Created by IntelliJ IDEA.
  User: Allyn
  Date: 2022/6/16
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <link href="../../css/bootstrap.css" rel="stylesheet" type="text/css">
    <script src="../../js/jquery-3.6.0.js"></script>
    <script src="../../js/bootstrap.js"></script>
    <title>修改密码</title>
    <style>
        #toast {
            display: none;
            /*    悬浮在屏幕顶端*/
            position: fixed;
            top: 10px;
            left: 0;
            width: 100%;
            height: 100%;
            margin: 0 auto;
            z-index: 1200;
        }

        .bg-drop {
            backdrop-filter: blur(20px) saturate(180%);
            -webkit-backdrop-filter: blur(20px) saturate(180%);
        }

        .bg-light-1 {
            background-color: rgba(255, 255, 255, 0.5);
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light fixed-top bg-light-1 bg-drop">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <img src="../../icon/person-fill.svg" alt="" width="30" height="24" class="d-inline-block align-text-top">
            学生管理系统
            <button type="button" class="btn btn-outline-danger" onclick="logOut()">登出</button>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#" onclick="toMain()">首页</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        学生管理
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#" onclick="toMain()">按姓名查找学生</a></li>
                        <li><a class="dropdown-item" href="#" onclick="findByClass()">按班级查找学生</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="#" onclick="toAdd()">添加学生</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        管理员设置
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown2">
                        <li><a class="dropdown-item" href="#" onclick="upUserPassword()">修改密码</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container" style="margin-top: 80px">
    <div class="row" style="margin-top: 20px">
        <div class="col-3">
            <div class="list-group">
                <button type="button" class="list-group-item list-group-item-action active">
                    修改密码
                </button>
            </div>
        </div>
        <div class="col-9 table-responsive" id="tab">
            <form id="myform" method="post" action="">
                <div class="mb-3">
                    <label for="username" class="form-label">用户名</label>
                    <input class="form-control" aria-describedby="usernameHelp" type="text" name="username"
                           id="username" readonly value="">
                    <div id="usernameHelp" class="form-text">当前用户名（从服务器获取）</div>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">修改密码</label>
                    <input class="form-control" aria-describedby="passwordHelp" type="password" name="password"
                           id="password">
                    <div id="passwordHelp" class="form-text">请输入需要修改的密码</div>
                </div>
                <div class="mb-3">
                    <label for="password2" class="form-label">确认密码</label>
                    <input class="form-control" aria-describedby="password2Help" type="text" name="password2"
                           id="password2">
                    <div id="password2Help" class="form-text">请再输入一遍密码确认</div>
                </div>

                <div class="d-grid gap-2 col-6 mx-auto" style="margin-top: 10px">
                    <button type="submit" class="btn btn-outline-danger" id="adSt">修改密码</button>
                    <button type="reset" class="btn btn-outline-secondary">reset</button>
                </div>
            </form>
        </div>
    </div>
    <div id="toast">
        <div class="container">
            <div class="row justify-content-md-center">
                <div class="col-md-auto align-content-center">
                    <div class="alert alert-success" role="alert" id="toasttext">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
    // 页面加载完成的时候，获取当前用户的ID
    $(document).ready(function () {
        $.ajax({
            url: "${pageContext.request.contextPath}/getUsername",
            type: "POST",
            success: function (data) {
                $("#toasttext").removeClass();
                $("#toasttext").attr("class", "alert alert-success");
                $("#username").val(data);
                $("#toasttext").text("获取用户名成功");
                $("#toast").fadeIn();
                setTimeout(function () {
                    $("#toast").fadeOut();
                }, 2000);
            },
            error: function (data) {
                $("#toasttext").removeClass();
                $("#toasttext").attr("class", "alert alert-danger");
                $("#toasttext").text("获取用户名失败");
                $("#toast").fadeIn();
                setTimeout(function () {
                    $("#toast").fadeOut();
                }, 2000);
            }
        });
    });

    // 通过ajax提交表单
    $("#myform").submit(function (e) {
        e.preventDefault();
        let password = $("#password").val();
        let password2 = $("#password2").val();
        if (password2 == null || password2 == "") {
            $("#toasttext").attr("class", "alert alert-danger");
            $("#toasttext").text("请再输入一遍密码确认");
            $("#toast").fadeIn();
            setTimeout(function () {
                $("#toast").fadeOut();
            }, 2000);
            $("#password").val("");
            $("#password2").val("");
            return false;
        }
        if (password != password2) {
            $("#toasttext").attr("class", "alert alert-danger");
            $("#toasttext").text("两次输入的密码不一致");
            $("#toast").fadeIn();
            setTimeout(function () {
                $("#toast").fadeOut();
            }, 2000);
            $("#password").val("");
            $("#password2").val("");
            return false;
        } else {
            $.ajax({
                url: "${pageContext.request.contextPath}/updateUserPassword",
                type: "POST",
                data: {
                    username: $("#username").val(),
                    password: $("#password").val()
                },
                success: function (data) {
                    $("#toasttext").removeClass();
                    $("#toasttext").attr("class", "alert alert-success");
                    $("#toasttext").text("修改密码成功");
                    $("#toast").fadeIn();
                    setTimeout(function () {
                        $("#toast").fadeOut();
                    }, 2000);
                    setTimeout(function () {
                        toMain();
                    }, 3000);
                },
                error: function (data) {
                    $("#toasttext").removeClass();
                    $("#toasttext").attr("class", "alert alert-danger");
                    $("#toasttext").text("修改密码失败");
                    $("#toast").fadeIn();
                    setTimeout(function () {
                        $("#toast").fadeOut();
                    }, 2000);
                }
            });
        }
    });

    function logOut() {
        window.location.href = "${pageContext.request.contextPath}/logout";
    }

    function toAdd() {
        window.location.href = "${pageContext.request.contextPath}/adStu";
    }

    function toMain() {
        window.location.href = "${pageContext.request.contextPath}/toMainPage";
    }

    function findByClass() {
        window.location.href = "${pageContext.request.contextPath}/findByClass";
    }

    function upUserPassword() {
        window.location.href = "${pageContext.request.contextPath}/upUsPa";
    }
</script>