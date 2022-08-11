package com.csmtech.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.csmtech.model.Sales;

public interface SalesRepository extends JpaRepository<Sales, Integer> {
	
	@Query("select p.productName, sum(s.salesQuantity) from Sales s inner "
			+ "join Product p on p.productId=s.product.productId where "
			+ "s.customer.customerId=:productId group by s.product.productId")
	public List<Object[]> getTableData(Integer productId);
	
}
