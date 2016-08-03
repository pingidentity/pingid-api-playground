package com.pingidentity.developer.pingid;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class User {

	private String userName;
	private String fName;
	private String lName;
	private String email;
	private UserRole role;
	
	private String phoneNumber;
	private DeviceDetails deviceDetails;
	
	private Date lastAuthentication;
	private Boolean enabled;
	private UserStatus status;
	
	private Map<String, Date> bypassInfo;

	public User() {
		
		this.userName = null;
		this.fName = null;
		this.lName = null;
		this.email = null;
		this.phoneNumber = null;
		
		this.role = UserRole.REGULAR;
		this.bypassInfo = new HashMap<String, Date>();
	}

	public User(String userName) {
		
		this.userName = userName;
		this.fName = null;
		this.lName = null;
		this.email = null;
		this.phoneNumber = null;
		
		this.role = UserRole.REGULAR;
		this.bypassInfo = new HashMap<String, Date>();
	}

	public User(String userName, String firstName, String lastName, String email) {
		
		this.userName = userName;
		this.fName = firstName;
		this.lName = lastName;
		this.email = email;
		this.phoneNumber = null;
		
		this.role = UserRole.REGULAR;
		this.bypassInfo = new HashMap<String, Date>();
	}

	public User(JSONObject userDetailsJSON) {

		if (userDetailsJSON != null) {
			
			this.email = (String)userDetailsJSON.get("email");
			this.fName = (String)userDetailsJSON.get("fname");
			this.lName = (String)userDetailsJSON.get("lname");
			this.userName = (String)userDetailsJSON.get("userName");
			this.enabled = (Boolean)userDetailsJSON.get("userEnabled");
			this.lastAuthentication = parseDateFromEpoch((Long)userDetailsJSON.get("lastLogin"));
			this.role = UserRole.REGULAR;
			this.status = UserStatus.valueOf((String)userDetailsJSON.get("status"));
			
			this.bypassInfo = new HashMap<String, Date>();
			JSONArray spList = (JSONArray)userDetailsJSON.get("spList");
			for(Object spObject : spList) {
				JSONObject sp = (JSONObject)spObject;
				String spAlias = (String)sp.get("spAlias");
				if (sp.get("bypassExpiration") != null) {
					Date bypassExpiration = parseDateFromEpoch((long)sp.get("bypassExpiration"));
					if (bypassExpiration.after(new Date())) {
						this.bypassInfo.put(spAlias, bypassExpiration);
					}
				} else {
					this.bypassInfo.remove(spAlias);
				}
			}
			
		}
	}

	public String getUserName() { return this.userName; }
	public String getFirstName() { return this.fName; }
	public String getLastName() { return this.lName; }
	public String getEmail() { return this.email; }
	public String getPhoneNumber() { return this.phoneNumber; }
	public UserRole getRole() { return this.role; }
	public DeviceDetails getDeviceDetails() { return this.deviceDetails; }
	public Boolean isBypassed(String spAlias) { return this.bypassInfo.containsKey(spAlias); }
	public Boolean isEnabled() { return this.enabled; }
	public UserStatus getStatus() { return this.status; }
	public Date getBypassedUntil(String spAlias) { return this.bypassInfo.get(spAlias); }
	public Date getLastAuthentication() { return this.lastAuthentication; }
	
	public void setUserName(String userName) { this.userName = userName; }
	public void setFirstName(String firstName) { this.fName = firstName; }
	public void setLastName(String lastName) { this.lName = lastName; }
	public void setEmail(String email) { this.email = email; }
	public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
	public void setRole(UserRole role) { this.role = role; }
	public void setDeviceDetails(DeviceDetails deviceDetails) { this.deviceDetails = deviceDetails; }
	
	@SuppressWarnings("unused")
	private Date parseDate(String dateToParse) {

		SimpleDateFormat PingIDDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		PingIDDateFormat.setTimeZone(TimeZone.getTimeZone("America/Denver"));
		
		if (dateToParse != null) {
			try {
				return PingIDDateFormat.parse(dateToParse);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		return null;
	}

	private Date parseDateFromEpoch(Long unixEpoch) {

		Date date = new Date();

		if (unixEpoch != null) {
			date.setTime(unixEpoch);
		} else {
			date.setTime(0);
		}

		return date;
	}
}
