<%@ page import="com.cshbxy.pojo.Student" %><%--
  Created by IntelliJ IDEA.
  User: Allyn
  Date: 2022/6/1
  Time: 19:45
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
    <script src="../../js/template-web.js"></script>
    <title>首页</title>
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

        tr {
            text-align: center;
            width: auto;
            height: auto;
        }

        td {
            text-align: center;
            width: 100px;
            height: 20px;
            line-height: 20px;
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
            <form id="findStu" class="d-flex " method="post" role="search"
                  action="${pageContext.request.contextPath}/student/findStudentsByName">
                <input class="form-control me-2 form-text" type="search" placeholder="Search" aria-label="Search"
                       name="username"
                       id="username">
                <button class="btn btn-outline-success" type="submit" id="search">Search</button>
            </form>
        </div>
    </div>
</nav>
<div class="container" style="margin-top: 80px">
    <div class="row" style="margin-top: 20px">
        <div class="col-3">
            <div class="list-group">
                <button type="button" class="list-group-item list-group-item-action active" aria-current="true">
                    按姓名查找学生
                </button>
                <button type="button" class="list-group-item list-group-item-action" onclick="findByClass()">
                    按班级查找学生
                </button>
                <button type="button" class="list-group-item list-group-item-action" onclick="toAdd()">添加学生</button>
                <button type="button" class="list-group-item list-group-item-action" disabled>修改学生</button>
            </div>
        </div>
        <div class="col-9 table-responsive" id="tab">
            <table class="table table-striped table-hover" id="Stu">
                <thead>
                <tr>
                    <th>id</th>
                    <th>姓名</th>
                    <th>头像</th>
                    <th>年龄</th>
                    <th>班级</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="tbody">
                <script type="text/html" id="stu_list">
                    {{each}}
                    <tr>
                        <td>{{$value.id}}</td>
                        <td>{{$value.username}}</td>
                        <td><img width="100%" alt="头像加载失败" style="border-radius: 6px;max-width: 30px"
                                 src="{{'../../images/'+$value.filename}}"></td>
                        <td>{{$value.age}}</td>
                        <td>{{$value.userclass}}</td>
                        <td>
                            <button class="btn btn-outline-danger" id="del">删除</button>
                        </td>
                        <td>
                            <button class="btn btn-outline-warning" id="up">修改</button>
                        </td>
                    </tr>
                    {{/each}}
                </script>
                </tbody>
            </table>
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
    $("#findStu").submit(function () {
        // 阻止表单默认提交
        event.preventDefault();
        $.ajax({
            url: "${pageContext.request.contextPath}/student/findStudentsByName",
            type: "post",
            data: {
                username: $("#username").val()
            },
            dataType: "json",
            success: function (data) {
                // 先清空表格
                // $("#tab").empty();
                console.log(data);
                let htmlStr = template("stu_list", data);
                $("#tbody").html(htmlStr);
                // if (data.length > 0) {
                //     // 创建表格
                //     let str = '<table class="table table-striped table-hover" id="Stu">';
                //     // 再添加表头
                //     str += '<thead><tr><th>id</th><th>姓名</th><th>头像</th><th>年龄</th><th>班级</th><th>操作</th></tr></thead>';
                //     // 再添加表格内容
                //     str += '<tbody>';
                //     for (var i = 0; i < data.length; i++) {
                //         str += '<tr><td>' + data[i].id + '</td><td>' + data[i].username + '</td><td><img width="100%" alt="头像加载失败" style="border-radius: 6px;max-width: 30px" src="../../images/' + data[i].filename + '"</td><td>' + data[i].age + '</td><td>' + data[i].userclass + '</td><td><button class="btn btn-outline-danger" id="del">删除</button></td><td><button class="btn btn-outline-warning" id="up">修改</button></td></tr>';
                //     }
                //     str += '</tbody>';
                //     str += '</table>';
                //     $("#tab").append(str);
                //     $("#tab").trigger("create");
                // } else {
                //     $("#toasttext").removeClass();
                //     $("#toasttext").attr("class", "alert alert-danger");
                //     $("#toasttext").text("未查询到匹配的学生");
                //     $("#toast").fadeIn();
                //     setTimeout(function () {
                //         $("#toast").fadeOut();
                //     }, 2000);
                // }
            }
        })
    });
    $(function () {
        // 获取删除的按钮
        $("#tab").on("click", "#del", function () {
            // 弹窗提示
            if (confirm("确定删除吗？")) {
                // 获取当前行的id
                let id = $(this).parent().parent().children().eq(0).text();
                // 获取id在表格中的位置
                let index = $(this).parent().parent().index();
                // 发送ajax请求
                $.ajax({
                    url: "${pageContext.request.contextPath}/student/deleteStudent",
                    type: "post",
                    data: {
                        id: id
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data > 0) {
                            $("#toasttext").removeClass();
                            $("#toasttext").attr("class", "alert alert-success");
                            // 删除成功
                            $("#toasttext").text("删除成功");
                            $("#toast").fadeIn();
                            setTimeout(function () {
                                $("#toast").fadeOut();
                            }, 2000);
                            // 获取到id这一行
                            index += 1;
                            console.log(index);
                            $("#tab").find("tr").eq(index).remove();
                        } else {
                            $("#toasttext").removeClass();
                            $("#toasttext").attr("class", "alert alert-danger");
                            // 删除失败
                            $("#toasttext").text("删除失败");
                            $("#toast").fadeIn(1000);
                            setTimeout(function () {
                                $("#toast").fadeOut(1000);
                            }, 2000);
                        }
                    }
                })
            }
        })
        // 获取修改的按钮
        $("#tab").on("click", "#up", function () {
            // 获取当前行的id
            let id = $(this).parent().parent().children().eq(0).text();
            // 获取当前行的姓名
            let username = $(this).parent().parent().children().eq(1).text();
            // 获取当前行的中的图片的src
            let filename = $(this).parent().parent().children().eq(2).children().attr("src");
            //修改filename的值，去掉../../images/
            filename = filename.substring(filename.indexOf("../../images/") + 13);
            // 获取当前行的年龄
            let age = $(this).parent().parent().children().eq(3).text();
            // 获取当前行的班级
            let userclass = $(this).parent().parent().children().eq(4).text();
            // 储存数据到localStorage
            localStorage.setItem("id", id);
            localStorage.setItem("username", username);
            localStorage.setItem("filename", filename);
            localStorage.setItem("age", age);
            localStorage.setItem("userclass", userclass);
            // 跳转到修改页面
            window.location.href = "${pageContext.request.contextPath}/upStu";
        })
    })

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