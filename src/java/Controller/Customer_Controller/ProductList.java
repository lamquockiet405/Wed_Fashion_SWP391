/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Customer_Controller;

import DAO.DAO_Admin.DAOAdmin;
import DAO.DAO_Customer.DAOProduct;
import DAO.DAO_User.DAOUsers;
import Model.Chinh.Categories;
import Model.Chinh.MinMaxPrice;
import Model.Chinh.Products;
import Model.Chinh.ProductsVariant;
import Model.Users;
import Model.Chinh.images;
import Model.Shop;
import Model.TotalOrderItemsByProduct;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

import java.util.List;

/**
 *
 * @author Dell
 */
@WebServlet(name = "ProductList", urlPatterns = {"/productList"})
public class ProductList extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String searchText = req.getParameter("query");
        if (searchText != null && !searchText.isEmpty()) {
            req.getSession().setAttribute("query", searchText);
        } else {
            req.getSession().removeAttribute("query");
        }
        String categories = req.getParameter("categoryID");
        String minPriceStr = req.getParameter("minPrice");
        String maxPriceStr = req.getParameter("maxPrice");
        String sort = req.getParameter("sort");
        // Chuyển đổi minPrice và maxPrice về dạng số
        Float minPrice = null;
        Float maxPrice = null;

        try {
            if (minPriceStr != null && !minPriceStr.isEmpty()) {
                minPrice = Float.parseFloat(minPriceStr);
            }
            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                maxPrice = Float.parseFloat(maxPriceStr);
            }
        } catch (NumberFormatException e) {
            minPrice = null;
            maxPrice = null;
        }
        DAOProduct pd = new DAOProduct();
        List<TotalOrderItemsByProduct> total_orderproduct = pd.getAllProductsWithTotalOrdered();
        List<Shop> shop_list = null;
        List<Products> list_menu = null;
        List<Products> list_filter = null;
        List<images> list_image = null;
        List<MinMaxPrice> list_price = null;
        List<Categories> list_categories = null;
        List<Users> users = null;
        list_image = pd.getAllImagesDistinctList();
        list_price = pd.getPriceMinMax();
        list_categories = pd.getAllCategories();
        shop_list=pd.getAllShops();
        users = pd.GetUserList();
        if (searchText == null && categories == null && minPriceStr == null && maxPriceStr == null && sort == null) {
            list_menu = pd.getAllProducts();
            req.setAttribute("TotalOrder", total_orderproduct);
            req.setAttribute("MenuChose", list_menu);
            req.setAttribute("ListUsers", users);
            req.setAttribute("Shop", shop_list);
            req.setAttribute("Listimage", list_image);
            req.setAttribute("Listprice", list_price);
            req.setAttribute("ListCategories", list_categories);
            req.getRequestDispatcher("View/Product/ProductList.jsp").forward(req, resp);
            return;
        } else {
            if (list_menu == null) {
                list_menu = new ArrayList<>();
            }
            list_filter = pd.getFilteredProducts(searchText, categories, minPrice, maxPrice, sort);

            for (Products filterProduct : list_filter) {
                boolean exists = false;

                // Kiểm tra xem productID đã có trong list_menu chưa
                for (Products existingProduct : list_menu) {
                    if (existingProduct.getProductID() == filterProduct.getProductID()) {
                        exists = true;
                        break; // Nếu đã tồn tại, không cần kiểm tra tiếp
                    }
                }

                // Nếu chưa có, mới thêm vào list_menu
                if (!exists) {
                    list_menu.add(pd.getProductsById(filterProduct.getProductID()));
                }
            }
            req.setAttribute("TotalOrder", total_orderproduct);
            req.setAttribute("ListUsers", users);
            req.setAttribute("MenuChose", list_menu);
            req.setAttribute("Listimage", list_image);
            req.setAttribute("Listprice", list_price);
            req.setAttribute("Shop", shop_list);
            req.setAttribute("ListCategories", list_categories);
            req.getRequestDispatcher("View/Product/ProductList.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

}
