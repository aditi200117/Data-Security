package com.apps.Mail;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class EmailAttachmentSender {

	public static void sendEmailWithAttachments(String host, String port,
			final String userName, final String password, String toAddress,
			String subject, String message, String username)
			throws AddressException, MessagingException {
		// sets SMTP server properties
		Properties properties = new Properties();
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.port", port);
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.user", userName);
		properties.put("mail.password", password);

		// creates a new session with an authenticator
		Authenticator auth = new Authenticator() {
			public PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(userName, password);
			}
		};
		Session session = Session.getInstance(properties, auth);

		// creates a new e-mail message
		Message msg = new MimeMessage(session);

		msg.setFrom(new InternetAddress(userName));
		InternetAddress[] toAddresses = { new InternetAddress(toAddress) };
		msg.setRecipients(Message.RecipientType.TO, toAddresses);
		msg.setSubject(subject);
		msg.setSentDate(new Date());

		// creates message part
		MimeBodyPart messageBodyPart = new MimeBodyPart();
		//messageBodyPart.setContent(message, "text/html");
                
                String s[] = message.toString().trim().split(":");
                        
                messageBodyPart.setText("<html>"
                  
                  + "<head>"

                  + "<title><h1>Secure data sharing in cloud computing using Revocable storage Identity based encryption</h1></title>"

                  + "</head>"

                  + "<body>"
                  
                  + "<div><strong>Secure data sharing in cloud computing using Revocable storage Identity based encryption</strong></div>"

                  + "<div style='color:red;'>Your Primary Key is : <em>" + s[0] + "</em> and your Master Secret Key is : <em>" + s[1] + "</em> </div>"

                  + "</body>"
                  
                  + "</html>",

                  "ascii", "html");

		// creates multi-part
		Multipart multipart = new MimeMultipart();
		multipart.addBodyPart(messageBodyPart);
		
		// sets the multi-part as e-mail's content
		msg.setContent(multipart);

		// sends the e-mail
		Transport.send(msg);
	}	
}