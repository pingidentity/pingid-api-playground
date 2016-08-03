package com.pingidentity.developer.pingid;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import org.json.simple.JSONObject;


public class DeviceDetails {
	
	private final String appVersion;
	private final long availableClaimedSms;
	private final long availableNotClaimedSms;
	private final long countryCode;
	private final String email;
	private final Date enrollment;
	private final Boolean hasWatch;
	private final String osVersion;
	private final String phoneNumber;
	private final Boolean pushEnabled;
	private final String type;

	public DeviceDetails() {

		appVersion = "";
		availableClaimedSms = 0;
		availableNotClaimedSms = 0;
		countryCode = 0;
		email = "";
		enrollment = new Date();
		hasWatch = false;
		osVersion = "";
		phoneNumber = "";
		pushEnabled = false;
		type = "";
	}

	public DeviceDetails(JSONObject deviceDetailsJSON) {
		
		if (deviceDetailsJSON != null) {
			appVersion = (deviceDetailsJSON.get("appVersion") != null ? (String)deviceDetailsJSON.get("appVersion") : "");
			availableClaimedSms = (deviceDetailsJSON.get("availableClaimedSms") != null ? (long)deviceDetailsJSON.get("availableClaimedSms") : 0);
			availableNotClaimedSms = (deviceDetailsJSON.get("availableNotClaimedSms") != null ? (long)deviceDetailsJSON.get("availableNotClaimedSms") : 0);
			countryCode = (deviceDetailsJSON.get("countryCode") != null ? (long)deviceDetailsJSON.get("countryCode") : 0);
			email = (String)deviceDetailsJSON.get("email");
			enrollment = parseDate((String)deviceDetailsJSON.get("enrollment"));
			hasWatch = (Boolean)deviceDetailsJSON.get("hasWatch");
			osVersion = (String)deviceDetailsJSON.get("osVersion");
			phoneNumber = (String)deviceDetailsJSON.get("phoneNumber");
			pushEnabled = (Boolean)deviceDetailsJSON.get("pushEnabled");
			type = (String)deviceDetailsJSON.get("type");
		} else {
			appVersion = "";
			availableClaimedSms = 0;
			availableNotClaimedSms = 0;
			countryCode = 0;
			email = "";
			enrollment = new Date();
			hasWatch = false;
			osVersion = "";
			phoneNumber = "";
			pushEnabled = false;
			type = "";
		}
	}

	public String getAppVersion() { return appVersion; }
	public long getAvailableClaimedSms() { return availableClaimedSms; }
	public long getAvailableNotClaimedSms() { return availableNotClaimedSms; }
	public long getCountryCode() { return countryCode; }
	public String getEmail() { return email; }
	public Date getEnrollment() { return enrollment; }
	public Boolean getHasWatch() { return hasWatch; }
	public String getOsVersion() { return osVersion; }
	public String getPhoneNumber() { return phoneNumber; }
	public Boolean getPushEnabled() { return pushEnabled; }
	public String getType() { return type; }

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

}
