package com.coor.controller;

import com.coor.domain.CategoryVO;
import com.coor.domain.CollectionVO;
import com.coor.domain.MemberVO;
import com.coor.service.AdProductService;
import com.coor.service.CartService;
import com.coor.service.CollectionService;
import com.coor.service.ProductService;

import lombok.Setter;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice(basePackages = {"com.coor.controller"})
public class GlobalControllerAdvice {
	
	@Setter(onMethod_ = {@Autowired})
    private ProductService productService;

	@Setter(onMethod_ = {@Autowired})
    private AdProductService adProductService;

	@Setter(onMethod_ = {@Autowired})
    private CollectionService collectionService;

	@Setter(onMethod_ = {@Autowired})
    private CartService cartService;

   @ModelAttribute
   public void categoryList(Model model) {
      List<CategoryVO> cateList = this.adProductService.getCategoryList();
      model.addAttribute("cateList", cateList);
      List<CategoryVO> subCateList = this.productService.subCategoryList2();
      model.addAttribute("subCateList", subCateList);
   }

   @ModelAttribute
   public void collectionList(Model model) {
      List<CollectionVO> colList = this.collectionService.getCollectionList();
      model.addAttribute("colList", colList);
   }

   @ModelAttribute
   public void cart_amount(Model model, HttpSession session) {
      if (session.getAttribute("loginStatus") != null) {
         int cart_amount = 0;
         String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
         int amount = this.cartService.cart_amount(mb_id);
         model.addAttribute("cart_amount", amount);
      }

   }

   @Autowired
   public void setProductService(ProductService productService) {
      this.productService = productService;
   }

   @Autowired
   public void setAdProductService(AdProductService adProductService) {
      this.adProductService = adProductService;
   }

   @Autowired
   public void setCollectionService(CollectionService collectionService) {
      this.collectionService = collectionService;
   }

   @Autowired
   public void setCartService(CartService cartService) {
      this.cartService = cartService;
   }
}
