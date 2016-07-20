<!-- <?php die(); ?> -->
<!-- THEM CMS configuration file -->
<config debug="true" staging="true">
  <domain></domain>
  <google_analytics>
    <id>UA-</id>
    <old_id></old_id>
  </google_analytics>
  <company>
    <name></name>
    <address>
      <street></street>
        <suburb></suburb>
		<state></state>
		<postcode></postcode>
    </address>
    <phone></phone>
    <email>noreply@themserver.com.au</email>
    <email_from>noreply@themserver.com.au</email_from>
    <email_contact>apolo@them.com.au</email_contact>
    <email_orders>apolo@them.com.au</email_orders>
    <logo>logo.png</logo>
  </company> 
  <database> 
    <host>m4-mysql1-1.ilisys.com.au</host> 
    <user>themso</user> 
    <password>c@^^3L5tRu7s*n9ub11c</password> 
    <dbname>themso3_db</dbname> 
  </database> 
  <page_strut>
    <type>1</type>
    <depth>2</depth>
    <file>ListClass</file>
    <table>
      <name>tbl_listing</name>
	<field>listing_url</field>
	<associated>
        <name>gallery</name>
        <table>tbl_gallery</table>
        <linkfield>listing_id</linkfield>
        <field>gallery_listing_id</field>
        <orderby>gallery_order ASC</orderby>
      </associated>
    </table>
    <template>standardpage.tpl</template>
    <template typeid="2">category.tpl</template>
    <process>
      <file>includes/processes/load-products.php</file>
    </process>
  </page_strut>
  <index_page>
    <template>home.tpl</template>
    <pageID>1</pageID>
  </index_page>
  <error404>
    <header>HTTP/1.0 404 Not Found</header>
    <template>standardpage.tpl</template>
    <pageID>5</pageID>
  </error404>
  <error403>
  <header>HTTP/1.0 403 Forbidden</header>
    <template>standardpage.tpl</template>
    <pageID>15</pageID>
  </error403>
  <error503>
  <header>HTTP/1.0 503 Service Temporarily Unavailable</header>
    <template>503.tpl</template>
  </error503>
  <search>
    <template>search.tpl</template>
    <pageID>16</pageID>
  </search>
  <static_page>
    <url>contact-us</url>
    <template>contact-us.tpl</template>
    <pageID>3</pageID>
  </static_page>
  <static_page>
    <url>password-recovery</url>
    <template>password-recovery.tpl</template>
    <pageID>14</pageID>
  </static_page>
  <static_page>
    <url>thank-you</url>
    <template>thank-you.tpl</template>
    <pageID>4</pageID>
  </static_page>
  <static_page>
    <url>thank-you-for-purchasing</url>
    <template>checkout-complete.tpl</template>
    <pageID>7</pageID>
  </static_page>
	
  <login>
    <url>login-register</url>
    <template>login-register.tpl</template>
    <pageID>8</pageID>
    <fallback_redirect>my-account</fallback_redirect>
  </login>
  <account restricted="true">
    <url>my-account</url>
    <template>account.tpl</template>
    <pageID>9</pageID>
    <fallback_redirect>login-register</fallback_redirect>
  </account>
  <cart>
    <url>shopping-cart</url>
    <pageID>12</pageID>
    <type>1</type>
    <file>ListClass</file>
    <table>
      <name>tbl_cart</name>
      <field>listing_url</field>
    </table>
    <template>shopping-cart.tpl</template>
  </cart>
  <checkout guest="false">
    <url>checkout</url>
    <pageID>13</pageID>
    <type>1</type>
    <file>ListClass</file>
    <table>
      <name>tbl_listing</name>
      <field>listing_url</field>
    </table>
    <template>checkout.tpl</template>
  </checkout>
  
  <product_category name="products">
    <url>products</url>
    <pageID>2</pageID>
    <root_parent_id>0</root_parent_id>
    <type>2</type>
    <file>ListClass</file>
    <table>
      <name>tbl_listing</name>
      <field>listing_url</field>
      <associated>
        <name>gallery</name>
        <table>tbl_gallery</table>
        <linkfield>listing_id</linkfield>
        <field>gallery_listing_id</field>
      </associated>
      <tags>
        <name>associated_categories</name>
        <table>tbl_tag</table>
        <object_table>tbl_listing</object_table>
        <object_value>listing_name</object_value>
      </tags>
    </table>
    <template>category.tpl</template>
    <process>
      <file>includes/processes/force_product_404.php</file>
    </process>
  </product_category>

  <product>
    <file>ProductClass</file>
    <table>
      <name>tbl_product</name>
      <id>product_object_id</id>
      <field>product_url</field>
      <extends>
        <table>tbl_productspec</table>
        <linkfield>product_id</linkfield>
        <field>productspec_product_id</field>
      </extends>
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
      <associated>
        <name>tags</name>
        <table>tbl_tag</table>
        <linkfield>product_id</linkfield>
        <field>tag_object_id</field>
        <where>tag_object_table = 'tbl_product'</where>
      </associated>
      <tags>
        <name>associated_products</name>
        <table>tbl_tag</table>
        <object_table>tbl_product</object_table>
        <object_value>product_group</object_value>
      </tags>
    </table>
    <template>product.tpl</template>
  </product>
  
  <listing_page name="news-and-resources">
    <url>news-and-resources</url>
    <root_parent_id>0</root_parent_id> 
    <type>2</type><!-- articles --> 
    <type>3</type><!-- newsletter -->
    <file>ListClass</file>
    <orderby>listing_schedule_start DESC</orderby>
    <where><![CDATA[(listing_schedule_start < NOW() OR listing_schedule_start IS NULL)]]></where>
    <limit level="1">20</limit>
    <table> 
      <name>tbl_listing</name>
      <field>listing_url</field>  
      <extends>
        <table>tbl_news</table>
        <linkfield>listing_id</linkfield>
        <field>news_listing_id</field>
      </extends>    
      <associated listing="false">
        <name>gallery</name>
        <table>tbl_gallery</table>
        <linkfield>listing_id</linkfield>
        <field>gallery_listing_id</field>
      </associated>
      <associated listing="true">
        <name>tags</name>
        <table>tbl_tag</table>
        <linkfield>listing_id</linkfield>
        <field>tag_object_id</field>
      </associated>
      <template typeid="2">news-article.tpl</template> 
      <template typeid="3">newsletter.tpl</template> 
    </table>
    <template>news-resources.tpl</template>
    <loadmoretemplate>news-resources-structure.tpl</loadmoretemplate>  
  </listing_page>

  <global_process>
    <file>includes/processes/global-shopping-cart.php</file>
  </global_process>
  <process>
    <url>process/cart</url>
    <file>includes/processes/processes-cart.php</file>
    <return_url></return_url>
  </process>  
  <process>
    <url>process/contact-us</url>
    <file>includes/processes/processes-contactus.php</file>
    <return_url></return_url>
  </process>
  <process>
    <url>process/load-more</url>
    <file>includes/processes/load-more.php</file>
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