package vn.hch;

import java.util.regex.Pattern;
import java.net.URI;
import java.net.URISyntaxException;

public final class ValidationUtil {
    private static final Pattern PHONE_PATTERN = Pattern.compile("^0\\d{9,10}$");
    private static final Pattern IMAGE_PATTERN = Pattern.compile("(?i)^[a-z0-9]+\\.(jpg|jpeg|png|gif|webp)$");
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[\\w.+-]+@[\\w-]+\\.[\\w.-]+$");
    private static final Pattern OTP_PATTERN = Pattern.compile("^\\d{6}$");

    private ValidationUtil() {
    }

    public static String required(String value, String label) {
        return value == null || value.trim().isEmpty() ? label + " không được để trống" : null;
    }

    public static String phone(String value) {
        if (value == null || value.trim().isEmpty()) {
            return "Số điện thoại không được để trống";
        }
        return PHONE_PATTERN.matcher(value.trim()).matches()
                ? null
                : "Số điện thoại phải có 10 hoặc 11 chữ số và bắt đầu bằng 0";
    }

    public static String email(String value) {
        if (value == null || value.trim().isEmpty()) {
            return "Email không được để trống";
        }
        return EMAIL_PATTERN.matcher(value.trim()).matches() ? null : "Email không đúng định dạng";
    }

    public static String otp(String value) {
        return value != null && OTP_PATTERN.matcher(value.trim()).matches()
                ? null
                : "Mã OTP phải gồm đúng 6 chữ số";
    }

    public static String imageUrl(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            URI uri = new URI(value.trim());
            return ("http".equalsIgnoreCase(uri.getScheme()) || "https".equalsIgnoreCase(uri.getScheme()))
                    && uri.getHost() != null ? null : "Link ảnh phải là URL http hoặc https hợp lệ";
        } catch (URISyntaxException e) {
            return "Link ảnh không hợp lệ";
        }
    }

    public static String imageFilename(String filename) {
        if (filename == null || filename.isBlank()) {
            return "Tên file không hợp lệ";
        }
        String safeName = filename.replace('\\', '/');
        safeName = safeName.substring(safeName.lastIndexOf('/') + 1);
        return IMAGE_PATTERN.matcher(safeName).matches() ? null
                : "Chỉ chấp nhận file ảnh jpg, jpeg, png, gif hoặc webp";
    }
}
