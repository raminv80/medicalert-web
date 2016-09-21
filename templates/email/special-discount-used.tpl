<html>
<head>
<style>
body {
	font-family: calibri, Helvetica, sans-serif;
	font-size: 16px;
	line-height: 18px;
}
table{
	font-size: 13px;
}
.container {
	padding: 25px;
}
</style>
</head>
<body>
<div class="container">
<div class="title"><h2>Discount Management System</h2></div>
<div class="form">
	<b>Name:</b> {$discount.discount_name}
	<br>
	<b>Code:</b> {$discount.discount_code}
	<br>
	<br>
	<b>User:</b> {$user.gname}
	<br>
	<b>Email:</b> {$user.email}
	<br>
	<br>
	<b>Order No:</b> {$payment.payment_transaction_no}
	<br>
	<b>Order Date:</b> {$payment.payment_created|date_format:"%e %B %Y"}
	<br>
	<b>Discount Amount:</b> $ -{$payment.payment_discount|number_format:2:".":","}
	<br>
</div>
</div>
<div class="container footer">
<hr>
<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr>
		<td width="30%"><img src="{$DOMAIN}/images/{$COMPANY.logo}" alt="logo"></td>
		<td width="10%">&nbsp;</td>
		<td width="60%"><b>{$COMPANY.name}</b>
			<br>{$COMPANY.address.street} {$COMPANY.address.suburb} {$COMPANY.address.state} {$COMPANY.address.postcode}
			{if $COMPANY.phone}<br>Ph: <a href="tel:{$COMPANY.phone}">{$COMPANY.phone}</a>{/if}
			{if $COMPANY.fax}<br>Fax: {$COMPANY.fax}{/if}
		</td>
	</tr>
</table>
</div>
</body>
</html>
