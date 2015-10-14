package com.pingidentity.developer.pingid;


public enum UserRole {
	REGULAR("REGULAR"),
	ADMIN("ADMIN");

	private final String role;
	
	private UserRole(String role) {
		this.role = role;
	}
	
	public String getValue() {
		return this.role;
	}

}
