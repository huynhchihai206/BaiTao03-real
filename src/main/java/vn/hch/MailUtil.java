package vn.hch;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class MailUtil {

    public static void sendMail(String to, String subject, String htmlContent) throws Exception {
        if (Constant.MAIL_AUTH && (Constant.MAIL_USERNAME.isBlank() || Constant.MAIL_PASSWORD.isBlank())) {
            throw new IllegalStateException("Chưa cấu hình MAIL_USERNAME và MAIL_PASSWORD cho SMTP");
        }

        Properties props = new Properties();
        props.put("mail.smtp.auth", String.valueOf(Constant.MAIL_AUTH));
        props.put("mail.smtp.starttls.enable", String.valueOf(Constant.MAIL_STARTTLS));
        props.put("mail.smtp.host", Constant.MAIL_HOST);
        props.put("mail.smtp.port", String.valueOf(Constant.MAIL_PORT));
        props.put("mail.smtp.connectiontimeout", "10000");
        props.put("mail.smtp.timeout", "10000");
        props.put("mail.smtp.writetimeout", "10000");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(Constant.MAIL_USERNAME, Constant.MAIL_PASSWORD);
            }
        });

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(Constant.MAIL_FROM));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject, "UTF-8");
        message.setContent(htmlContent, "text/html; charset=UTF-8");

        Transport.send(message);
    }
}
