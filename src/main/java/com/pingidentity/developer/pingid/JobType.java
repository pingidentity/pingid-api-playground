package com.pingidentity.developer.pingid;

/**
 * Created by dheinisch on 4/25/17.
 */
public enum JobType {
    USER_REPORTS("User_Reports");

    private String jobType;

    JobType(String jobType) {
        this.jobType = jobType;
    }

    @Override
    public String toString() {
        return this.jobType.toUpperCase();
    }

    public static JobType fromString(String jobType) {
        for (JobType type : values()) {
            if (type.jobType.equalsIgnoreCase(jobType)) {
                return type;
            }
        }

        return null;
    }
}
