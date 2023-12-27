<%@ page import ="com.rapidmedico.utility.DBUtil"%>
<%@page import ="java.sql.*"%>
<%
String Uploadprescriptionusername=request.getParameter("Uploadprescriptionusername");
String Uploadprescriptionmedicine=request.getParameter("Uploadprescriptionmedicine");
String Uploadprescriptionaddress=request.getParameter("Uploadprescriptionaddress");
String Uploadprescriptionmobile=request.getParameter("Uploadprescriptionmobile");
String Uploadprescriptionpincode=request.getParameter("Uploadprescriptionpincode");  
String Uploadprescriptionaadharcard=request.getParameter("Uploadprescriptionaadharcard");
String Uploadprescriptiondoctorname=request.getParameter("Uploadprescriptiondoctorname");
try
{
	Connection con = DBUtil.provideConnection();
	PreparedStatement ps =con.prepareStatement("insert into uploadprescription values(?,?,?,?,?,?,?)");
	ps.setString(1, Uploadprescriptionusername);
	ps.setString(2, Uploadprescriptionmedicine);
	ps.setString(3, Uploadprescriptionaddress);
	ps.setString(4, Uploadprescriptionmobile);
	ps.setString(5, Uploadprescriptionpincode);
	ps.setString(6, Uploadprescriptionaadharcard);
	ps.setString(7, Uploadprescriptiondoctorname);
	ps.executeUpdate();
	response.sendRedirect("Uploadprescription.jsp?msg=valid");
}
catch (Exception e)
{
	System.out.println(e);
	response.sendRedirect("Uploadprescription.jsp?msg=invalid");
}
%>