package com.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import com.shop.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.shop.util.Page;
import com.shop.pojo.User;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    UserService userService;

    /*
     * 跳转功能：到用户登录界面
     * */
    @RequestMapping("Login")
    public String Login(){
        return "user/login";
    }
    /*
    * 跳转功能：到用户注册界面
    * */
    @RequestMapping("Register")
    public String Register(){
        return "user/register";
    }
    /*
     * 用户登录后台处理
     * */
    @RequestMapping("user_login")
    public String forelogin(HttpServletRequest request, String name, String password, HttpSession session){
        if(null==name||null==password){
            return "redirect:/fore/foreHome";
        }
        User user = userService.queryForLogin(name,password);
        if (null == user){
            request.setAttribute("message","账号密码有误");
            return "user/login";
        }
        // 用户已登录, 保存用户名, 跳转到前台首页
        session.setAttribute("user",user);
        return "redirect:/fore/foreHome";
    }
    /*
    * 用户注册后台处理
    * */
    @RequestMapping("user_register")
    public String user_register(User user,HttpServletRequest request){
        if (null == user.getName()){
            return "redirect:/fore/foreHome";
        }
        List<User> old_users = userService.getByName(user.getName());
        if (old_users.isEmpty()){
            userService.addUser(user);
            String s = "注册成功!请登录 ";
            request.setAttribute("message",s);
            return "user/login";

        }else{
            String s = "用户名已经存在! ";
            request.setAttribute("message",s);
            return "user/register";
        }
    }
    /*
    * 检查用户是否登陆
    * */
    @RequestMapping("forecheckLogin")
    @ResponseBody
    public String checkLogin(HttpSession session){
        User user = (User) session.getAttribute("user");
        if (null != user)
            return "success";
        return "fail";
    }
    /*
    *Ajax验证 模态窗口登录账号密码是否正确
    * */
    @RequestMapping("foreloginAjax")
    @ResponseBody
    public String loginAjax(String name, String password, HttpSession session){
        if(null==name||null==password){
            return "redirect:/fore/foreHome";
        }
        User user = userService.queryForLogin(name,password);
        if (null == user){
            return "fail";
        }
        session.setAttribute("user",user);
        return "success";
    }

    /*
     * 用户退出登录
     * */
    @RequestMapping("logout")
    public String logout(HttpSession session){
        session.removeAttribute("user");
        return "redirect:/fore/foreHome";
    }
    /*
    * 用户详情展示
    * */
    @RequestMapping("information")
    public String showInformation(HttpSession session){
        User user = (User) session.getAttribute("user");
        if (null == user){
            return "fail";
        }
        session.setAttribute("user",user);
        return "user/userHome";
    }
    /*
    * 跳转功能：修改用户信息
    * */
    @RequestMapping("userInformation")
    public String userInformation(Integer id, HttpSession session){
        User user =  userService.getById(id);
        session.setAttribute("u",user);
        return "user/editUser";
    }
    /*
    * 跳转功能：修改用户密码
    * */
    @RequestMapping("userPassword")
    public String userPassword(Integer id, HttpSession session){
        User user =  userService.getById(id);
        session.setAttribute("u",user);
        return "user/editPassword";
    }
    /*
    * 修改用户信息
    * */
    @RequestMapping("editUser")
    public String editUser(User user, HttpSession session){
        userService.editUser(user);
        user =  userService.getById(user.getId());
        session.setAttribute("user",user);
        return "redirect:userInformation?id="+user.getId();
    }
    /*
    * 修改用户密码
    * */
    @RequestMapping("editPassword")
    public String editPassword(User user, HttpSession session, HttpServletResponse response) throws IOException {
        userService.editUserByPassword(user);
        //重新得到用户修改后的信息
        session.removeAttribute("user");
        PrintWriter out = response.getWriter();
        out.print("<script language=\"javascript\">alert('修改成功！请重新登录')</script>");
        return "redirect:editUser";
    }

}