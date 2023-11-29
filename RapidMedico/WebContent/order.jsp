<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page
	import="com.rapidmedico.service.impl.*, com.rapidmedico.service.*,com.rapidmedico.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Cart Details</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<%
	/* Checking the user credentials */
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {

		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}
	UserService dao = new UserServiceImpl();
	UserBean user = dao.getUserDetails(userName, password);
	if (user == null)
		user = new UserBean("Test User", 98765498765L, "mohit@gmail.com", "ABC colony, Patna, bihar", 87659, "lksdjf");
	%>


	<div class="text-center"
		style="color: green; font-size: 50px; font-weight: bold;">OrdersDetails</div>
		
	<!-- <script>document.getElementById('mycart').innerHTML='<i data-count="20" class="fa fa-shopping-cart fa-3x icon-white badge" style="background-color:#333;margin:0px;padding:0px; margin-top:5px;"></i>'</script>
 -->
	<!-- Start of Product Items List -->
	<div class="container">
	<table class="table table-hover">
			<thead
				style="background-color: #186188; color: white; font-size: 16px; font-weight: bold;">
				<tr>
					<th>Picture</th>
					<th>Products</th>
					<th>Price</th>
					<th>Quantity</th>
					<th>Amount</th>
				</tr>
			</thead>
			<tbody
				style="background-color: white; font-size: 15px; font-weight: bold;">
                <%
				CartServiceImpl cart = new CartServiceImpl();
				List<CartBean> cartItems = new ArrayList<CartBean>();
				cartItems = cart.getAllCartItems(userName);
				double totAmount = 0;
				for (CartBean item : cartItems) {

					String prodId = item.getProdId();

					int prodQuantity = item.getQuantity();

					ProductBean product = new ProductServiceImpl().getProductDetails(prodId);

					double currAmount = product.getProdPrice() * prodQuantity;

					totAmount += currAmount;

					if (prodQuantity > 0) {
				%>

				<tr>
					<td><img src="./ShowImage?pid=<%=product.getProdId()%>"
						style="width: 50px; height: 50px;"></td>
					<td><%=product.getProdName()%></td>
					<td><%=product.getProdPrice()%></td>
					<td><form method="post" action="">
							<input type="number" name="pqty" value="<%=prodQuantity%>"
								style="max-width: 70px;" min="0">
						</form></td>
					<td><%=currAmount%></td>
				</tr>

				<%
				}
				}
				%>

				<tr style="background-color: grey; color: white;">
					<td colspan="4" style="text-align: center;">Total Amount to
						Pay (in Rupees)</td>
					<td><%=totAmount%></td>
				</tr>
				<%
				if (totAmount != 0) {
				%>
				<tr style="background-color: grey; color: white;">
					<td colspan="4" style="text-align: center;">
					<td><a onclick="window.print();"><button class="button right-button">Print</button></a></td>
						<td colspan="4" align="center"><form method="post">
							<button style="background-color: blue; color: white;"
								formaction="payment.jsp?amount=<%=totAmount%>">Pay Now</button>
						</form></td>
						
				</tr>
				
				<%
				}
				%>
				<div class="col-lg-8">
				<div class="card mb-4">
					<div class="card-body">
						<div class="text-center"style="color: red; font-size: 24px; font-weight: bold;">
							<div class="col-sm-3">
								<p class="mb-0">Full Name</p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"style="color: green; font-size: 24px; font-weight: bold;"><%=user.getName()%></p>
							</div>
						</div>
						<hr>
						<div class="text-center"style="color: red; font-size: 24px; font-weight: bold;">
							<div class="col-sm-3">
								<p class="mb-0">Email</p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"style="color: green; font-size: 24px; font-weight: bold;"><%=user.getEmail()%>
								</p>
							</div>
						</div>
						<hr>
						<div class="text-center"style="color: red; font-size: 24px; font-weight: bold;">
							<div class="col-sm-3">
								<p class="mb-0">Phone</p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"style="color: green; font-size: 24px; font-weight: bold;"><%=user.getMobile()%>
								</p>
							</div>
						</div>
						<hr>
						<div class="text-center"style="color: red; font-size: 24px; font-weight: bold;">
							<div class="col-sm-3">
								<p class="mb-0">Address</p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"style="color: green; font-size: 24px; font-weight: bold;"><%=user.getAddress()%>
								</p>
							</div>
						</div>
						<hr>
						<div class="text-center"style="color: red; font-size: 24px; font-weight: bold;">
							<div class="col-sm-3">
								<p class="mb-0">PinCode</p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"style="color: green; font-size: 24px; font-weight: bold;"><%=user.getPinCode()%>
								</p>
							</div>
						</div>
						<hr>
						<div class="text-center"style="color: red; font-size: 24px; font-weight: bold;">
							<div class="col-sm-3">
								<p class="mb-0">Total Price</p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"style="color: green; font-size: 24px; font-weight: bold;"><%=totAmount%>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			</tbody>
	</table>
		<center><a href="userHome.jsp"><button class="Back">Back</button></a></center>
</body>
</html>