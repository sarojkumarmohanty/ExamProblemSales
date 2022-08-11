package com.csmtech.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.csmtech.model.Product;
import com.csmtech.model.Sales;
import com.csmtech.repository.CustomerRepository;
import com.csmtech.repository.ProductRepository;
import com.csmtech.repository.SalesRepository;

@Controller
public class MainController {

		@Autowired
		private CustomerRepository customerRepository;
		@Autowired
		private ProductRepository productRepository;
		@Autowired
		private SalesRepository salesRepository;
	
		@RequestMapping("/getForm")
		public String getSalesForm(Model model) {
			
			model.addAttribute("customerList", customerRepository.findAll());
			model.addAttribute("productList", productRepository.findAll());			
			return "page";
		}		
		
		@RequestMapping("/saveSales")
		public String saveSales(@ModelAttribute("sales") Sales sales, RedirectAttributes redirectAttributes ) {
			sales.setSalesDate(new Date());
			if(salesRepository.save(sales)!=null) {
				redirectAttributes.addFlashAttribute("msg", "record saved");
				//redirectAttributes.addFlashAttribute(null, redirectAttributes)
			}
				
			
			Product product=productRepository.findById(sales.getProduct().getProductId()).get();
			product.setQuantity(product.getQuantity()-sales.getSalesQuantity());
			productRepository.save(product);
			
			
			return "redirect:/getForm";			
		}
		
		@RequestMapping("/getSalesDataBycustomerId")
		public void getSalesDataBycustomerId(@RequestParam("cId") Integer cId, HttpServletResponse resp) throws IOException{
			PrintWriter pw=resp.getWriter();
			List<Object[]> lib=salesRepository.getTableData(cId);
			String r="";
			for(Object[] obj:lib) 
				r+="<tr><td>"+obj[0]+"</td><td>"+obj[1]+"</td></tr>";
			pw.print(r);
		}
		@RequestMapping("/getAvailabeQntyByProductId")
		public void getAvailabeQntyByProductId(@RequestParam("pId") Integer pId, HttpServletResponse resp) throws IOException{
			PrintWriter pw=resp.getWriter();
			Product prod=productRepository.findById(pId).get();			
			pw.print(prod.getQuantity());
		}
}
