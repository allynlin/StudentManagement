<%--
  Created by IntelliJ IDEA.
  User: Allyn
  Date: 2022/6/8
  Time: 13:48
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
    <title>修改学生</title>
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
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#" onclick="toMain()">首页</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        学生管理
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#" onclick="toMain()">按姓名查找学生</a></li>
                        <li><a class="dropdown-item" href="#" onclick="findByClass()">按班级查找学生</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#" onclick="toAdd()">添加学生</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button" data-bs-toggle="dropdown" aria-expanded="false">
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
                <button type="button" class="list-group-item list-group-item-action" onclick="toMain()">
                    按姓名查找学生
                </button>
                <button type="button" class="list-group-item list-group-item-action" onclick="findByClass()">
                    按班级查找学生
                </button>
                <button type="button" class="list-group-item list-group-item-action" onclick="toAdd()"
                        aria-current="true">添加学生
                </button>
                <button type="button" class="list-group-item list-group-item-action active" disabled>修改学生</button>
            </div>
        </div>
        <div class="col-9 table-responsive" id="tab">
            <form method="post" id="ph" enctype="multipart/form-data"
                  action="">
                <div class="mb-3" id="userphoto">
                    <label for="pimage" class="form-label">头像</label>
                    <input class="form-control" aria-describedby="filenameHelp" type="file" name="pimage" id="pimage"
                           onchange="previewFile()">
                    <div id="pimageHelp" class="form-text">上传头像到服务器</div>
                </div>
                <!--用于显示上传图片的预览图-->
                <div class="" id="photo">
                    <img src="" id="showImg" class="img-thumbnail rounded mx-auto d-block" alt="该学生暂未设置头像"
                         style="border-radius: 6px;max-width: 200px;">
                </div>
                <button style="display: none" type="submit" class="btn btn-success">添加学生</button>
            </form>
            <form method="post" id="updateStu" action="">
                <div class="mb-3" style="display: none">
                    <label for="filename" class="form-label">文件名</label>
                    <input class="form-control" aria-describedby="filenameHelp" type="text" name="filename"
                           id="filename" value="person-circle.svg">
                    <div id="filenameHelp" class="form-text">上传到服务器的文件名（由后端返回）</div>
                </div>
                <div class="mb-3">
                    <label for="id" class="form-label">ID</label>
                    <input class="form-control" aria-describedby="emailHelp" type="number" name="id" id="id">
                    <div id="idHelp" class="form-text">学生ID</div>
                </div>
                <div class="mb-3">
                    <label for="username" class="form-label">姓名</label>
                    <input class="form-control" aria-describedby="emailHelp" type="text" name="username" id="username">
                    <div id="emailHelp" class="form-text">学生姓名</div>
                </div>
                <div class="mb-3">
                    <label for="age" class="form-label">年龄</label>
                    <input class="form-control" aria-describedby="ageHelp" type="number" type="number" name="age"
                           id="age">
                    <div id="ageHelp" class="form-text">学生年龄</div>
                </div>
                <div class="mb-3">
                    <label for="userclass" class="form-label">班级</label>
                    <input class="form-control" aria-describedby="userclassHelp" type="text" name="userclass"
                           id="userclass">
                    <div id="userclassHelp" class="form-text">学生班级</div>
                </div>
                <div class="d-grid gap-2 col-6 mx-auto" style="margin-top: 10px">
                    <button type="submit" class="btn btn-outline-danger" id="adSt">修改学生</button>
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
    $(function () {
        // 读取localStorage中的filename值，并显示在页面上
        let filename = localStorage.getItem("filename");
        if (filename == null) {
        } else if (filename == "person-circle.svg") {
        } else {
            $("#showImg").attr("src", "../../images/" + filename);
            // 将filename赋值到表单中
            $("#filename").val(filename);
        }
    })

    function previewFile() {
        // 获取显示图片对象
        let preview = document.getElementById("showImg");   // 通过元素节点查找： document.querySelector('img');
        // 获取选中图片对象（包含文件的名称、大小、类型等，如file.size）
        let file = document.getElementById("pimage").files[0];   //document.querySelector('input[type=file]').files[0];
        let reader = new FileReader();
        if (file) {
            // 通过文件流将文件转换成Base64字符串
            reader.readAsDataURL(file);
            // 转换成功后
            reader.onloadend = function () {
                // 将转换结果赋值给img标签
                preview.src = reader.result;
                // 输出结果
                // console.log(reader.result);
                // 输出结果在多行文本框中
                // document.getElementById("showText").value = reader.result;
            }
            document.getElementById("photo").style.display = "block";
        }
        // $("#ph").submit();
        // 使用Ajax上传图片
        $.ajax({
            url: "${pageContext.request.contextPath}/student/addPhoto",
            type: "POST",
            data: new FormData($("#ph")[0]),
            contentType: false,
            processData: false,
            success: function (data) {
                // console.log(data);
                // 将data赋值给fileName
                $("#filename").val(data);
                if (data) {
                    $("#toasttext").removeClass();
                    $("#toasttext").attr("class", "alert alert-success");
                    $("#toasttext").text("图片上传成功");
                    $("#toast").fadeIn();
                    setTimeout(function () {
                        $("#toast").fadeOut();
                    }, 2000);
                } else {
                    $("#toasttext").removeClass();
                    $("#toasttext").attr("class", "alert alert-danger");
                    $("#toasttext").text("图片上传失败");
                    $("#toast").fadeIn();
                    setTimeout(function () {
                        $("#toast").fadeOut();
                    }, 2000);
                    // 清空文件名
                    $("#filename").val("");
                    // 清空图片预览
                    $("#showImg").attr("src", "");
                    document.getElementById("photo").style.display = "none";
                    // 清空文件选择框
                    $("#pimage").val("");
                }
            }
        });
    }

    $(function () {
        // 读取localStorage
        var id = localStorage.getItem("id");
        var username = localStorage.getItem("username");
        var age = localStorage.getItem("age");
        var userclass = localStorage.getItem("userclass");
        // console.log(id);
        // 赋值给input
        $("#id").val(id);
        $("#username").val(username);
        $("#age").val(age);
        $("#userclass").val(userclass);
        $("#updateStu").submit(function () {
            // alert("获取到了点击事件");
            // 阻止默认行为
            event.preventDefault();
            // 确认修改
            var isUpdate = confirm("确定修改吗？");
            if (isUpdate) {
                // 发送ajax请求
                $.ajax({
                    url: "${pageContext.request.contextPath}/student/updateStudent",
                    type: "post",
                    data: {
                        id: $("#id").val(),
                        username: $("#username").val(),
                        age: $("#age").val(),
                        userclass: $("#userclass").val(),
                        filename: $("#filename").val()
                    },
                    success: function (data) {
                        // console.log(data);
                        if (data > 0) {
                            $("#toasttext").removeClass();
                            $("#toasttext").attr("class", "alert alert-success");
                            $("#toasttext").text("修改成功");
                            $("#toast").fadeIn(1000);
                            setTimeout(function () {
                                $("#toast").fadeOut(1000);
                            }, 2000);
                            // 清空localStorage
                            localStorage.removeItem("id");
                            localStorage.removeItem("username");
                            localStorage.removeItem("age");
                            localStorage.removeItem("userclass");
                            localStorage.removeItem("filename");
                            setTimeout(function () {
                                window.location.href = "${pageContext.request.contextPath}/toMainPage";
                            }, 3000);
                        } else {
                            $("#toasttext").removeClass();
                            $("#toasttext").attr("class", "alert alert-danger");
                            $("#toasttext").text("修改失败");
                            $("#toast").fadeIn(1000);
                            setTimeout(function () {
                                $("#toast").fadeOut(1000);
                            }, 2000);
                        }
                    }
                });
            }
        });
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