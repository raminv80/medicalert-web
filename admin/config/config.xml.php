<!-- <?php die(); ?> -->
<!-- THEM CMS configuration file -->
<config debug="true">
	<company></company>
	<database>
		<host>n7-mysql5-3.ilisys.com.au</host>
		<user>themso</user>
		<password>c@^^3L5tRu7s*n9ub11c</password>
		<dbname>themso17_db</dbname>
	</database>
	<resource>
		<url>file-manager</url>
		<template>filemanager.tpl</template>
	</resource>
	<section>
		<url>users</url>
		<title>Admin</title>
		<type>TABLE</type>
		<table>
			<name>tbl_admin</name>
			<id>admin_id</id>
			<field>admin_name</field>
			<deleted>admin_deleted</deleted>
		</table>
		<list_template>list_admin.tpl</list_template>
		<edit_template>edit_admin.tpl</edit_template>
	</section>
	<section>
		<showlist>FALSE</showlist>
		<url>page</url>
		<title>Pages</title>
		<type>LISTING</type>
		<type_id>1</type_id>
		<options>
			<field>
				<name>listing_cateogry_id</name>
				<table>tbl_listing</table>
				<type_id>1</type_id>
				<reference>listing_name</reference>
				<where>listing_type_id = '1'</where>
			</field>
		</options>
		<list_template>list_page.tpl</list_template>
		<edit_template>edit_page.tpl</edit_template>
	</section>

	<section>
		<showlist>FALSE</showlist>
		<url>page-slides</url>
		<type>TABLE</type><type>TABLE</type>
		<table>
			<name>tbl_slide</name>
			<id>slide_id</id>
			<field>slide_text</field>
			<deleted>slide_deleted</deleted>
			<where>slide_type_id = '1'</where>
		</table>
		<slide>1</slide>
		<title>Home Slides</title>
		<list_template>list_slide.tpl</list_template>
		<edit_template>edit_slide.tpl</edit_template>
	</section>
	<section>
		<showlist>FALSE</showlist>
		<url>carpet-page-slides</url>
		<type>TABLE</type><type>TABLE</type>
		<table>
			<name>tbl_slide</name>
			<id>slide_id</id>
			<field>slide_text</field>
			<deleted>slide_deleted</deleted>
			<where>slide_type_id = '2'</where>
		</table>
		<slide>2</slide>
		<title>Carpet and Flooring Slides</title>
		<list_template>list_slide.tpl</list_template>
		<edit_template>edit_slide.tpl</edit_template>
	</section>
	<section>
		<showlist>FALSE</showlist>
		<url>curtains-page-slides</url>
		<type>TABLE</type><type>TABLE</type>
		<table>
			<name>tbl_slide</name>
			<id>slide_id</id>
			<field>slide_text</field>
			<deleted>slide_deleted</deleted>
			<where>slide_type_id = '3'</where>
		</table>
		<slide>3</slide>
		<title>Curtains and Blinds Slides</title>
		<list_template>list_slide.tpl</list_template>
		<edit_template>edit_slide.tpl</edit_template>
	</section>

	<section>
		<showlist>FALSE</showlist>
		<url>specials-page-slides</url>
		<type>TABLE</type><type>TABLE</type>
		<table>
			<name>tbl_slide</name>
			<id>slide_id</id>
			<field>slide_text</field>
			<deleted>slide_deleted</deleted>
			<where>slide_type_id = '4'</where>
		</table>
		<slide>4</slide>
		<title>Special Slides</title>
		<list_template>list_slide.tpl</list_template>
		<edit_template>edit_slide.tpl</edit_template>
	</section>
	<section>
		<showlist>FALSE</showlist>
		<url>product-page-slides</url>
		<type>TABLE</type><type>TABLE</type>
		<table>
			<name>tbl_slide</name>
			<id>slide_id</id>
			<field>slide_text</field>
			<deleted>slide_deleted</deleted>
			<where>slide_type_id = '5'</where>
		</table>
		<slide>5</slide>
		<title>Product care Slides</title>
		<list_template>list_slide.tpl</list_template>
		<edit_template>edit_slide.tpl</edit_template>
	</section>
	<section>
		<showlist>FALSE</showlist>
		<url>contact-page-slides</url>
		<type>TABLE</type><type>TABLE</type>
		<table>
			<name>tbl_slide</name>
			<id>slide_id</id>
			<field>slide_text</field>
			<deleted>slide_deleted</deleted>
			<where>slide_type_id = '6'</where>
		</table>
		<slide>6</slide>
		<title>Contact us Slides</title>
		<list_template>list_slide.tpl</list_template>
		<edit_template>edit_slide.tpl</edit_template>
	</section>
		<section>
		<showlist>FALSE</showlist>
		<url>about-page-slides</url>
		<type>TABLE</type><type>TABLE</type>
		<table>
			<name>tbl_slide</name>
			<id>slide_id</id>
			<field>slide_text</field>
			<deleted>slide_deleted</deleted>
			<where>slide_type_id = '7'</where>
		</table>
		<slide>7</slide>
		<title>About Slides</title>
		<list_template>list_slide.tpl</list_template>
		<edit_template>edit_slide.tpl</edit_template>
	</section>
	<section>
		<url>category</url>
		<showlist>FALSE</showlist>
		<title>Categories</title>
		<type>TABLE</type>
		<table>
			<name>tbl_category</name>
			<id>category_id</id>
			<field>category_name</field>
			<deleted>category_deleted</deleted>
			<where>category_type_id = '4'</where>
			<options>
				<field>
					<name>category_listing_id</name>
					<table>tbl_listing</table>
					<reference>listing_name</reference>
				</field>
				<field>
					<name>category_type_id</name>
					<table>tbl_type</table>
					<reference>type_name</reference>
				</field>
				<field>
					<name>category_parent_id</name>
					<table>tbl_category</table>
					<reference>category_name</reference>
					<where>category_type_id = '4'</where>
				</field>
			</options>
		</table>
		<list_template>list_category.tpl</list_template>
		<edit_template>edit_category.tpl</edit_template>
	</section>
	<section>
		<url>products</url>
		<showlist>FALSE</showlist>
		<title>Products</title>
		<type>LISTING</type>
		<type_id>4</type_id>
		<options>
				<field>
					<name>category_parent_id</name>
					<table>tbl_category</table>
					<reference>category_name</reference>
				</field>
		</options>
		<associated>
			<name>gallery</name>
			<table>tbl_gallery</table>
			<field>gallery_listing_id</field>
		</associated>
		<extends>
			<table>tbl_product</table>
			<field>product_listing_id</field>
		</extends>
		<extends>
			<table>tbl_link</table>
			<field>link_list_id</field>
			<where>link_deleted is NULL</where>
		</extends>
		<list_template>list_product.tpl</list_template>
		<edit_template>edit_product.tpl</edit_template>
	</section>
	<section>
		<url>specials</url>
		<showlist>FALSE</showlist>
		<title>Specials</title>
		<type>LISTING</type>
		<type_id>5</type_id>
		<list_template>list_special.tpl</list_template>
		<edit_template>edit_special.tpl</edit_template>
	</section>
	<section>
		<url>product-care</url>
		<showlist>FALSE</showlist>
		<title>Product care</title>
		<type>LISTING</type>
		<type_id>6</type_id>
		<list_template>list_product_care.tpl</list_template>
		<edit_template>edit_product_care.tpl</edit_template>
	</section>
	<smartytemplate_config><!-- This element contains the smarty template values -->
		<templates>/templates</templates>
		<templates_c>/templates_c</templates_c>
		<cache>/cache</cache>
		<configs>/configs</configs>
		<plugins>/plugins</plugins>
	</smartytemplate_config>
</config>