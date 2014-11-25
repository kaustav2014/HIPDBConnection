<%@page import="javax.jms.MessageProducer"%>
<%@page import="javax.jms.Destination"%>
<%@page import="javax.jms.JMSException"%>
<%@page import="javax.jms.TextMessage"%>
<%@page import="javax.jms.QueueSender"%>
<%@page import="javax.jms.Session"%>
<%@page import="javax.jms.QueueSession"%>
<%@page import="javax.jms.QueueConnection"%>
<%@page import="javax.jms.QueueConnectionFactory"%>
<%@page import="javax.jms.ConnectionFactory"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.jms.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.beans.Statement"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String var1 = request.getParameter("text1");
out.println("messaging 1" + var1 + "<br/>");
Properties properties=new Properties();
properties.put(Context.PROVIDER_URL,"http://mqlightprod-lookup.ng.bluemix.net/Lookup?serviceId=716242b9-f22b-448a-a228-0128f9885acd");
properties.put(Context.SECURITY_CREDENTIALS,"x7T9wmKVZPEg");
properties.put(Context.SECURITY_PRINCIPAL,"Jv33tAu9tqP2");
InitialContext ctx = new InitialContext(properties);    		
ConnectionFactory mqlightCF = (ConnectionFactory)ctx.lookup("java:comp/env/jms/" + "MQLight-sampleservice");
 System.out.println("Connection factory successfully created");
 out.println("messaging 2" + "<br/>");
  
 
 Connection jmsConn = null;
     try {
     	
         jmsConn = mqlightCF.createConnection();

	    	// Create a session.
	    	Session jmsSess = jmsConn.createSession(false, Session.AUTO_ACKNOWLEDGE);
	    	out.println("messaging 3" + "<br/>");
	    	// Create a producer on our topic
	    	Destination publishDest = jmsSess.createTopic("mqlight/sample/words");
	    	MessageProducer producer = jmsSess.createProducer(publishDest);
 			out.println("messaging 4" + "<br/>");
 			// Create our message
		    	TextMessage textMessage = jmsSess.createTextMessage(var1);
	    		
	    		// Send it
		    	System.out.println("Sending message " + textMessage.getText());
		    	producer.send(textMessage);
         out.println("messaging 4" + "<br/>");
         
     } catch (JMSException e) {
     
		 out.println("messaging 5" + e.getMessage()+ "<br/>");    
         throw new RuntimeException(e);
     } finally {
         // Ensure we cleanup our connection
    		try {
    			if (jmsConn != null) jmsConn.close();
    		}
    		catch (Exception e) {
    			System.out.println("Exception closing connection to MQ Light");
    		}
    		ctx.close();
     }        
         
 %>
<H1>Submitting Text Fields</H1>
<FORM ACTION="index.jsp" METHOD="POST">
Please enter your message:
<INPUT TYPE="TEXT" NAME="text1">
<BR>

<INPUT TYPE="SUBMIT" value="Submit">


</FORM>
</body>
</html>