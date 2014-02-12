<!-- <?php die(); ?> -->
<!-- THEM CMS configuration file -->
<config debug="true" staging="true">
	<company></company>
	<database>
		<host>m4-mysql1-1.ilisys.com.au</host>
		<user>themso</user>
		<password>c@^^3L5tRu7s*n9ub11c</password>
		<dbname>themso3_db</dbname>
	</database>
	<page_strut>
		<type>1</type>
		<file>ListClass</file>
		<table><!-- This table will be the details table -->
			<name>tbl_listing</name>
			<field>listing_url</field><!-- The field used to match the URL -->
			<associated>
				<name>gallery</name>
				<table>tbl_gallery</table>
				<linkfield>listing_id</linkfield>
				<field>gallery_listing_id</field>
			</associated>
		</table>
		<template>standardpage.tpl</template><!-- The template used if the field is matched -->
		<renting>rentingstandardpage.tpl</renting>
	</page_strut>
	<index_page>
		<template>home.tpl</template>
		<pageID>12</pageID>
	</index_page>
	<error404 standalone="true">
		<template>404.tpl</template>
		<pageID>2</pageID>
	</error404>
	
	<inspections>
		<template>inspections.tpl</template>
		<pageID>35</pageID>
	</inspections>
	<static_page>
		<url>contact-us</url>
		<template>contact-us.tpl</template>
		<pageID>44</pageID>
	</static_page>


	
 	<product_page name="store">
		<url>store</url>
		<pageID>10</pageID>
		<root_parent_id>10</root_parent_id>
		<type>2</type>
		<file>ProductClass</file>
		<table><!-- This table will be the details table -->
			<name>tbl_listing</name>
			<field>listing_url</field><!-- The field used to match the URL -->
			<options>
				<field recursive="true"> 
					<name>options_categories</name>
					<table>tbl_listing</table>
					<reference>listing_name</reference> 
					<where>listing_parent_flag = '1' AND listing_type_id = '2'</where> 
				</field> 
			</options>
			<associated>
				<id>product_id</id>
				<name>product_info</name>
				<table>tbl_product</table>
				<linkfield>listing_id</linkfield>
				<field>product_listing_id</field>
				<orderby>product_order ASC</orderby>
				<associated> 
					<id>attribute_id</id>
					<name>attribute</name>
					<table>tbl_attribute</table>
					<linkfield>product_id</linkfield>
					<field>attribute_product_id</field> 
					<orderby>attribute_order ASC</orderby>
					<associated> 
						<id>attr_value_id</id>
						<name>attr_value</name>
						<table>tbl_attr_value</table>
						<linkfield>attribute_id</linkfield>
						<field>attr_value_attribute_id</field> 
						<orderby>attr_value_order ASC</orderby>
					</associated>
				</associated>
				<associated>
					<name>gallery</name>
					<table>tbl_gallery</table>
					<linkfield>product_id</linkfield>
					<field>gallery_product_id</field>
					<orderby>gallery_ishero DESC</orderby> 
				</associated>
			</associated>
			<template>product.tpl</template>
		</table>
		<template>category.tpl</template>
 	</product_page>

 	<login>
		<url>login</url>
		<template>login.tpl</template>
		<pageID>14</pageID>
	</login>
	<account>
		<url>my-account</url>
		<template>account.tpl</template>
		<pageID>22</pageID>
	</account>
 	<cart> 
		<url>store/shopping-cart</url> 
		<pageID>13</pageID> 
		<type>1</type> 
		<file>ListClass</file>
		<table>			<!-- This table will be the details table -->
			<name>tbl_cart</name>
			<field>listing_url</field>	<!-- The field used to match the URL -->
		</table>
		<template>shopping-cart.tpl</template> 
		<!-- The template used if the field is matched --> 
	</cart>
	<checkout> 
		<url>store/checkout</url> 
		<pageID>15</pageID> 
		<type>1</type> 
		<file>ListClass</file>
		<table>			<!-- This table will be the details table -->
			<name>tbl_listing</name>
			<field>listing_url</field>	<!-- The field used to match the URL -->
		</table>
		<template>checkout.tpl</template> 
		<!-- The template used if the field is matched --> 
	</checkout>

	
	<process>
		<url>process/cart</url>
		<file>includes/processes/processes-cart.php</file>
		<return_url></return_url>
	</process>	
	<process>
		<url>process/user</url>
		<file>includes/processes/processes-user.php</file>
		<return_url></return_url>
	</process>
	<process>
		<url>process/contact-us</url>
		<file>includes/processes/processes-contactus.php</file>
		<return_url></return_url>
	</process>
	 	

	<smartytemplate_config>
		<templates>/templates</templates>
		<templates_c>/templates_c</templates_c>
		<cache>/cache</cache>
		<configs>/configs</configs>
		<plugins>/plugins</plugins>
	</smartytemplate_config>
</config>