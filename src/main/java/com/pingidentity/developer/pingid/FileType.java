package com.pingidentity.developer.pingid;

/**
 * Created by dheinisch on 4/25/17.
 */
public enum FileType {
    CSV("csv"),
    JSON("json");

    private String fileType;

    FileType(String fileType) {
        this.fileType = fileType.toUpperCase();
    }

    @Override
    public String toString() {
        return fileType;
    }

    public static FileType fromString(String fileType) {
        for (FileType type : values()) {
            if (type.fileType.equalsIgnoreCase(fileType)) {
                return type;
            }
        }

        return null;
    }
}
