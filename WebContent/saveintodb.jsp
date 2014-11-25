<%@page import="java.net.URLConnection" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*, java.net.*, java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Save into db</title>
</head>
<body>
<%
String var1 = request.getParameter("text1");
out.println("Hi Indistry" + var1);
Connection conn = null; 
//Connection conn1=null;
     Statement stmt = null; 
     ResultSet rset = null; 
     try {
    System.out.println(" ****** 1 ****** ");
        Class.forName("com.ibm.db2.jcc.DB2Driver");
        out.println("Driver found</br>");
         System.out.println(" ****** 2 ****** ");
        out.println("1</br>"); 
         URL url = new URL("http://supportproject.mybluemix.net/NewFile.jsp");
         out.println("2</br>");
         URLConnection urlCon = url.openConnection();
         out.println("3</br>");
          BufferedReader in = new BufferedReader(new InputStreamReader(
                                   urlCon.getInputStream()));
                                   out.println("4</br>");
        String line="";
        String inputLine;
        while ((inputLine = in.readLine()) != null) {
        line = line + inputLine;
            System.out.println(inputLine);
            }
        in.close();
    
         String[] uidpwd = line.split("<>");
         out.println("5</br>");
        conn = DriverManager.getConnection("jdbc:db2://75.126.155.142:50000/I_977485",uidpwd[0], uidpwd[1]);
         System.out.println(" ****** 3 ****** ");
         out.println("6</br>");
        stmt = conn.createStatement();
         System.out.println(" ****** 4 ****** ");
         out.println("7</br>");
        // dynamic query
        stmt.execute("insert into BIP.INDUSTRY (INDUSTRYID) VALUES('" + var1 + "')");
         System.out.println(" ****** 5 ****** ");
         out.println("8</br>");
         rset = stmt.executeQuery(" Select * from BIP.INDUSTRY ");
         out.println("9</br>");
         while(rset.next()){
          out.println( rset.getString(1) );
         }
         
        conn.close();
     } catch (Exception e) { 
      out.println("Error: 1 *****" + e.getMessage());
      }
     
 %>
</body>
</html>