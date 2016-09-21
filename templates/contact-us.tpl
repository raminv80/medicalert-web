{block name=body}

<div id="pagehead">
  <div class="bannerout">
	<img src="{if $listing_image}{$listing_image}{else}/images/newsdet-banner.jpg{/if}" alt="{$listing_name} banner" />
  </div>
  <div class="container" id="contpage">
    <div class="row">
      <div class="col-sm-12 text-center" id="listtoptext">
      	<h1>{$listing_title}</h1>
      </div>
      <div class="col-md-8 col-md-offset-2 text-center">
        {$listing_content1}
      </div>
    </div>
  </div>
</div>
<div id="contact">
  <div class="container">
 	 <div class="row">
		<div class=" col-sm-offset-2 col-sm-8 col-md-offset-0 col-md-7 text-center" id="contform">
    	 	<form id="contact_form" accept-charset="UTF-8" method="post" action="/process/contact-us" novalidate="novalidate">
        	    <input type="hidden" name="formToken" id="formToken" value="{$token}" />
        	  	<input type="hidden" value="Contact" name="form_name" id="form_name" />
    			<input type="hidden" name="timestamp" id="timestamp" value="{$timestamp}" />
    	  		<div class="row">
    				<div class="col-sm-6 form-group">
    				  <label class="visible-ie-only" for="name">Full name<span>*</span>:</label>
    					<input class="form-control" value="{$post.name}" type="text" name="name" id="name" required="">
						<div class="error-msg help-block"></div>
    				</div>
    				<div class="col-sm-6 form-group">
    				  <label class="visible-ie-only" for="email">Email<span>*</span>:</label>
    					<input class="form-control" value="{$post.email}" type="email" name="email" id="email" required="">
						<div class="error-msg help-block"></div>
    				</div>
    			</div>
    			<div class="row">
    				<div class="col-sm-6 form-group">
    				  <label class="visible-ie-only" for="phone">Phone<span>*</span>:</label>
    				  <input class="form-control" value="{$post.phone}" type="text" name="phone" id="phone" required="">
						<div class="error-msg help-block"></div>
    				</div>

                    <div class="col-sm-6 form-group">
                      <label class="visible-ie-only" for="postcode">Postcode<span>*</span>:</label>
                      <input class="form-control" value="{$post.postcode}" maxlength="4" type="text" name="postcode" id="postcode"  required="">
						<div class="error-msg help-block"></div>
                    </div>
    			</div>
    			<div class="row">
    				<div class="col-sm-6 form-group">
    				  <label class="visible-ie-only" for="membership_no">Membership number:</label>
    				  <input class="form-control" value="{$post.membership_no}" type="text" name="membership_no" id="membership_no" >
						<div class="error-msg help-block"></div>
    				</div>

  				    <div class="col-sm-6 form-group">
                      <label class="visible-ie-only" for="nature_enquiry">Nature of enquiry<span>*</span></label>
                      <select class="selectlist-medium" id="nature_enquiry" name="nature_enquiry" required>
                            <option value="">Please select</option>
                          {foreach $reasons as $ha}
                            <option value="{$ha.value}" {if $post.nature_enquiry eq $ha.value} selected="selected"{/if}>{$ha.value}</option>
                          {/foreach}
                      </select>
						<div class="error-msg help-block"></div>
    				</div>
    			</div>

    			<div class="row">
    				<div class="col-sm-12 form-group">
    				  <label class="visible-ie-only" for="enquiry">Message<span>*</span>:</label>
    					<textarea class="form-control" name="enquiry" id="enquiry" required="">{$post.enquiry}</textarea>
						<div class="error-msg help-block"></div>
    				</div>
    			</div>
    			<div style="height:0;overflow:hidden;">
                   <input value="" type="text" name="honeypot" id="honeypot" tabindex="-1">
                </div>
    			<div class="row error-msg" id="form-error" {if !$error}style="display:none"{/if}>{$error}</div>
    			<div class="row">
    				<div class="col-sm-12">
    					<input type="button" value="SEND" onclick="$('#contact_form').submit();" class="btn-red btn" id="fbsub">
    				</div>
    			</div>
    	  </form>
          <br>
          <div>{$listing_content2}</div>
          <br><br>
		</div>

    <div class="col-sm-offset-2 col-sm-8 col-md-offset-1 col-md-4" id="contacttext">
        <div class="h2">Contact details</div>
        <hr>
        <div class="contline">
          <img src="/images/contact-location.png" alt="Location" />
              <div class="cont-text" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
                <span itemprop="streetAddress">{$COMPANY.address.street}</span><br>
                <span itemprop="addressLocality">{$COMPANY.address.suburb}</span>
                <span itemprop="addressRegion"> {$COMPANY.address.state}</span>
                <span itemprop="postalCode"> {$COMPANY.address.postcode}</span>
              </div>
        </div>
        <div class="contline">
          <img src="/images/contact-phone.png" alt="Location" />
          <div class="cont-text">
        <p>Free call <a class="tel" href="tel:{$COMPANY.toll_free}">{$COMPANY.toll_free}</a></p>
          </div>
        </div>
        <div class="contline">
          <img src="/images/contact-fax.png" alt="Location" />
          <div class="cont-text">
        <p>Free fax <a class="tel" href="tel:{$COMPANY.fax}">{$COMPANY.fax}</a></p>
        </div>
        </div>
        <div class="contline">
          <div class="contliner">
          <p class="small"><i>Please note: calls from mobile phones may attract extra charges.</i></p>
          </div>
        </div>
        <div class="contline">
          <img src="/images/contact-phone.png" alt="Location" />
          <div class="cont-text">
        <p><a class="tel" href="tel:{$COMPANY.phone}">{$COMPANY.phone}</a> (outside Australia)</p>
          </div>
        </div>
        <div class="contline">
          <img src="/images/contact-email.png" alt="Location" />
        <div class="cont-text">
        <p>{obfuscate email=$COMPANY.email attr='title="Click to email us"'}</p>

        </div>
        </div>
        <div class="contline">
          <img src="/images/contact-time.png" alt="Location" />
        <div class="cont-text">
        <p>Office hours:<br>Monday - Friday, 9am - 5pm CST</p>
        </div>
        </div>
        <div class="contline">
              <hr />
        <div class="contliner">
        <p>Join the community:</p>
        <div id="contsocial">
          <a target="_blank" href="https://www.facebook.com/AustraliaMedicAlertFoundation" title="Visit our Facebook page" ><img src="/images/contact-fb.png" alt="Facebook" /></a>
          <a target="_blank" href="https://twitter.com/MedicAlert_Aust"><img src="/images/contact-twitter.png" alt="Twitter" title="Find us on Twitter"/></a>
          <a target="_blank" href="https://www.youtube.com/user/MedicAlertFoundation"><img src="/images/contact-yt.png" alt="YouTube" title="Find us on YouTube"/></a>
          <a target="_blank" href="https://www.instagram.com/medicalert_aust/"><img src="/images/contact-insta.png" alt="Instagram" title="Find us on Instagram"/></a>
        </div>
        </div>
        </div>
      </div>

		</div>
	</div>
</div>

<div id="orangebox" class="visible-xs">

</div>
{/block}

{block name=tail}
<script src="/includes/js/jquery-ui.js"></script>
<script src="/includes/js/jquery.selectBoxIt.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	 	$('#contact_form').validate();

	 	$('#postcode').rules("add", {
			digits: true,
			minlength: 4
		});

		$("select").selectBoxIt();


	 	$('#email').rules("add", {
			email: true
		});

});

</script>
{/block}
