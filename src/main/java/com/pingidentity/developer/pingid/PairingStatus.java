package com.pingidentity.developer.pingid;


public enum PairingStatus {
	NOT_EXIST("NOT_EXIST"),
	NOT_CLAIMED("NOT_CLAIMED"),
	VERIFIED("VERIFIED"),
	PAIRED("PAIRED"),
	SUCCESS("SUCCESS");

	private final String status;
	
	private PairingStatus(String status) {
		this.status = status;
	}
	
	public String getValue() {
		return this.status;
	}

}
