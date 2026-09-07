package vn.hch;

public class Constant {
    public static final String DIR = "C:\\upload";
    public static final String UPLOAD_DIRECTORY = DIR;

    public static final String MAIL_HOST = getConfig("MAIL_HOST", "localhost");
    public static final int MAIL_PORT = getIntConfig("MAIL_PORT", 1025);
    public static final boolean MAIL_AUTH = getBooleanConfig("MAIL_AUTH", false);
    public static final boolean MAIL_STARTTLS = getBooleanConfig("MAIL_STARTTLS", false);
    public static final String MAIL_USERNAME = getConfig("MAIL_USERNAME", "");
    public static final String MAIL_PASSWORD = getConfig("MAIL_PASSWORD", "");
    public static final String MAIL_FROM = getConfig("MAIL_FROM", "no-reply@localhost");

    private static String getConfig(String name, String defaultValue) {
        String value = System.getProperty(name);
        if (value == null || value.isBlank()) {
            value = System.getenv(name);
        }
        return value == null || value.isBlank() ? defaultValue : value.trim();
    }

    private static int getIntConfig(String name, int defaultValue) {
        try {
            return Integer.parseInt(getConfig(name, String.valueOf(defaultValue)));
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private static boolean getBooleanConfig(String name, boolean defaultValue) {
        return Boolean.parseBoolean(getConfig(name, String.valueOf(defaultValue)));
    }
}