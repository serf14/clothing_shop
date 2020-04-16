package com.wzx.service;

import java.util.List;


import com.wzx.pojo.Address;

public interface AddressService {

	void add(Address address);
	List<Address> list(int uid);
	void update(Address address);
	void delete(int id);
	Address get(int id);
}
