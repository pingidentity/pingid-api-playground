package com.pingidentity.developer.pingid;


public class Application {

	private String name;
	private String logoUrl;
	private String spAlias;
	
	public Application(String name) {

		this.name = name;
		this.spAlias = "web";
	}
	
	public String getName() { return this.name; }
	public String getLogoUrl() { return this.logoUrl; }
	public String getSpAlias() { return this.spAlias; }
	
	public void setName(String name) { this.name = name; }
	public void setLogoUrl(String logoUrl) { this.logoUrl = logoUrl; }
	public void setSpAlias(String spAlias) { this.spAlias = spAlias; }
	
}
