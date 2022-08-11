package com.csmtech.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.csmtech.model.Customer;

public interface CustomerRepository extends JpaRepository<Customer, Integer> {

}
