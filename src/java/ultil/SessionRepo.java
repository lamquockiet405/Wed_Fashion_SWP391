/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ultil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Model.User;

public class SessionRepo {

    public static SessionRepo INSTANCE = new SessionRepo();

    private SessionRepo() {}


    // user
    public User getUser(HttpServletRequest request, HttpServletResponse response) {
        return (User) request.getSession().getAttribute("acc");
    }

    public void setUser(HttpServletRequest request, HttpServletResponse response, User user) {
        request.getSession().setAttribute("acc", user);
    }

    public static void removeUser(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().removeAttribute("user");
    }

    //user find by email
    public static User getUserFindByEmail(HttpServletRequest request, HttpServletResponse response) {
        return (User) request.getSession().getAttribute("userFindByEmail");
    }

    public static void setUserFindByEmail(HttpServletRequest request, HttpServletResponse response, User user) {
        request.getSession().setAttribute("userFindByEmail", user);
    }


    public static void removeUserFindByEmail(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().removeAttribute("userFindByEmail");
    }

    // search
    public static String getSearch(HttpServletRequest request, HttpServletResponse response) {
        return (String) request.getSession().getAttribute("search");
    }

    public static void setSearch(HttpServletRequest request, HttpServletResponse response, String search) {
        request.getSession().setAttribute("search", search);
    }

    // sort
    public static String getSort(HttpServletRequest request, HttpServletResponse response) {
        return (String) request.getSession().getAttribute("sort");
    }

    public static void setSort(HttpServletRequest request, HttpServletResponse response, String sort) {
        request.getSession().setAttribute("sort", sort);
    }
}