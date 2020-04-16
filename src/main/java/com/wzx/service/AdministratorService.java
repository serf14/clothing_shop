package com.wzx.service;

import java.util.List;

import com.wzx.pojo.Administrator;

public interface AdministratorService {

	boolean isExist(String account);
	boolean isRight(String account,String password);
	Administrator get(String account,String password);
	List<Administrator> list();
	void add(Administrator administrator);
}
