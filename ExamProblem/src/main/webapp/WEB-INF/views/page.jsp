<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Form</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap4.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js">
	
</script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/js/bootstrap.min.js">
	
</script>
<script
	src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js">
	
</script>
<script
	src="https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap4.min.js">
	
</script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.8.0/js/bootstrap-datepicker.min.js"></script>
</head>
<body>
	<div class="container">
		<label style="font-weight: bold;" class="text-success">${msg}</label>
		<div class="display-4 text-primary">Sales Form</div>
		<div class="row">
			<form action="saveSales" method="post" class="form-controll" id="salesForm" onsubmit="return validateForm();">
				<div class="form-group">
					<label>Customer Name:</label> <select name="customer" id="customer"
						onchange="getSalesDataBycustomerId()" class="form-control">
						<option value="0">-select-</option>
						<c:forEach items="${customerList}" var="cList">
							<option value="${cList.customerId}">${cList.customerName}</option>
						</c:forEach>

					</select>
				</div>
				<div class="form-group">
					<label>Product Name:</label> <select name="product" id="product"
						class="form-control">
						<option value="0">-select-</option>
						<c:forEach items="${productList}" var="pList">
							<option value="${pList.productId}">${pList.productName}</option>
						</c:forEach>

					</select>
				</div>
				<div class="form-group">
					<label>Quantity:</label> <input type="text" name="salesQuantity" id="salesQuantity"
						class="form-control" onblur="getQuantityByProductId()">
				</div>
				<input type="hidden" name="hqn" id="hqn">
				<div>
					<input type="submit" value="save" class="btn btn-success"> <input type="reset" class="btn btn-warning"
						value="reset">
				</div>
			</form>
			<div class="ml-5">
				<label id="tlabel" style="color: red; font-weight: normal;"></label>
				<table style="width: auto;" class="table table-striped">
					<thead></thead>
					<tbody id="stbody">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	function getSalesDataBycustomerId() {
		var custId = $("#customer").val();
		var custName = $("#customer").find("option:selected").text();

		$.ajax({
			type : "GET",
			url : "./getSalesDataBycustomerId",
			data : "cId=" + custId,
			success : function(response) {

				$("#tlabel").html("Purchase of " + custName);
				$("#stbody").html(response);
			}
		});
	}
	
	function getQuantityByProductId() {
		var prodId = $("#product").val();		
		var salesQnty = $("#salesQuantity").val();
		$.ajax({
			type : "GET",
			url : "./getAvailabeQntyByProductId",
			data : "pId=" + prodId,
			success : function(response) {
					$("#hqn").val(response);				
			}
		});
		
	}
	
	function validateForm(){
		var salesQnty = $("#salesQuantity").val();
		var availableQnty = $("#hqn").val();
		
		if(!(Number(salesQnty) <= Number(availableQnty))){
			alert("insufficient qnty");
			$("#salesQuantity").focus();
			return false;
		}
		return true;
	}
</script>
</html>

