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
      <div class="col-md-10 col-md-offset-1 text-center">{$listing_content1}</div>
    </div>
  </div>
</div>

<div id="free-resource">
  <div class="container">
    <div class="row">
      <div class="col-sm-6 col-sm-offset-0 col-md-4 col-md-offset-2">
        <img src="/images/refer-info.png" alt="Refer your patients" class="img-responsive" />
      </div>
      <div class="col-sm-6 col-md-6">
        <h3>Order your free resource pack</h3>
        <p>Each pack includes:</p>
        <ul>
          <li>An <span class="bold">A3 poster</span></li>
          <li><span class="bold">Membership flyer</span></li>
          <li><span class="bold">Membership flyer stand and sample bracelet</span></li>
          <li>A sample <span class="bold">membership card</span></li>
        </ul>
      </div>
    </div>
  </div>
</div>

<div id="contact" class="referp">
  <div class="container">
    <div class="row">
      <div class="col-md-offset-1 col-md-10 text-center" id="sharestory">
        <form id="contact_form" accept-charset="UTF-8" method="post" action="/process/resource-contact" novalidate="novalidate">
          <input type="hidden" name="formToken" id="formToken" value="{$token}" />
          <input type="hidden" value="Refer your patient" name="form_name" id="form_name" />
          <input type="hidden" name="timestamp" id="timestamp" value="{$timestamp}" />
          <div class="row">
            <div class="col-sm-6 form-group">
              <label class="visible-ie-only" for="fname">First name<span>*</span>:
              </label>
              <input class="form-control" value="{$post.fname}" type="text" name="fname" id="fname" required="">
              <div class="error-msg help-block"></div>
            </div>
            <div class="col-sm-6 form-group">
              <label class="visible-ie-only" for="lname">Surname<span>*</span>:
              </label>
              <input class="form-control" value="{$post.lname}" type="text" name="lname" id="lname" required="">
              <div class="error-msg help-block"></div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 form-group">
              <label class="visible-ie-only" for="jobtitle">Job title:</label>
              <input class="form-control" value="{$post.jobtitle}" type="text" name="jobtitle" id="jobtitle">
              <div class="error-msg help-block"></div>
            </div>
            <div class="col-sm-6 form-group">
              <label class="visible-ie-only" for="company">Company name<span>*</span>:
              </label>
              <input class="form-control" value="{$post.company}" type="text" name="company" id="company" required="">
              <div class="error-msg help-block"></div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 form-group">
              <label class="visible-ie-only" for="department">Department:</label>
              <input class="form-control" value="{$post.department}" type="text" name="department" id="department">
              <div class="error-msg help-block"></div>
            </div>
            <div class="col-sm-6 form-group">
              <label class="visible-ie-only" for="address">Postal address<span>*</span>:
              </label>
              <input class="form-control" value="{$post.address}" type="text" name="address" id="address" required="">
              <div class="error-msg help-block"></div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 form-group">
              <label class="visible-ie-only" for="suburb">Suburb<span>*</span>:
              </label>
              <input class="form-control" value="{$post.suburb}" type="text" name="suburb" id="suburb" required="">
              <div class="error-msg help-block"></div>
            </div>
            <div class="col-sm-6 form-group">
              <label class="visible-ie-only" for="state">State<span>*</span>:
              </label>
              <select class="form-control" name="state" id="state" required="">
                <option value="">Please select</option>
                <option {if $post.state eq 'ACT'}selected="selected" {/if} value="ACT">ACT</option>
                <option {if $post.state eq 'NSW'}selected="selected" {/if} value="NSW">NSW</option>
                <option {if $post.state eq 'NT'}selected="selected" {/if} value="NT">NT</option>
                <option {if $post.state eq 'QLD'}selected="selected" {/if} value="QLD">QLD</option>
                <option {if $post.state eq 'SA'}selected="selected" {/if} value="SA">SA</option>
                <option {if $post.state eq 'TAS'}selected="selected" {/if} value="TAS">TAS</option>
                <option {if $post.state eq 'VIC'}selected="selected" {/if} value="VIC">VIC</option>
                <option {if $post.state eq 'WA'}selected="selected" {/if} value="WA">WA</option>
              </select>
              <div class="error-msg help-block"></div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 form-group">
              <label class="visible-ie-only" for="postcode">Postcode<span>*</span>:
              </label>
              <input class="form-control" value="{$post.postcode}" maxlength="4" type="text" name="postcode" id="postcode" pattern="[0-9]*" required="">
              <div class="error-msg help-block"></div>
            </div>
            <div class="col-sm-6 form-group">
              <label class="visible-ie-only" for="phone">Phone:</label>
              <input class="form-control" value="{$post.phone}" type="text" name="phone" id="phone" pattern="[0-9]*">
              <div class="error-msg help-block"></div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 form-group">
              <label class="visible-ie-only" for="email">Email<span>*</span>:
              </label>
              <input class="form-control" value="{$post.email}" type="email" name="email" id="email" required="">
              <div class="error-msg help-block"></div>
              <!--<div>By providing your email address, you consent to receive promotional and health related material.</div>-->
            </div>
            <div class="col-sm-6 form-group">
              <label class="visible-ie-only" for="category">Category<span>*</span>:
              </label>
              <select class="form-control" name="category" id="category" required="">
                <option value="">Please select</option>
                <option {if $post.category eq 'Hospital'}selected="selected" {/if} value="Hospital">Hospital</option>
                <option {if $post.category eq 'Pharmacy'}selected="selected" {/if} value="Pharmacy">Pharmacy</option>
                <option {if $post.category eq 'Medical practice'}selected="selected" {/if} value="Medical practice">Medical practice</option>
                <option {if $post.category eq 'Specialist - Cardiac'}selected="selected" {/if} value="Specialist - Cardiac">Specialist - Cardiac</option>
                <option {if $post.category eq 'Specialist - Diabetes'}selected="selected" {/if} value="Specialist - Diabetes">Specialist - Diabetes</option>
                <option {if $post.category eq 'Specialist - Other'}selected="selected" {/if} value="Specialist - Other">Specialist - Other</option>
                <option {if $post.category eq 'Other'}selected="selected" {/if} value="Other">Other</option>
              </select>
              <div class="error-msg help-block"></div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 form-group text-left">
              <input type="checkbox" {if !$post || $post.resource_pack}checked="checked" {/if}name="resource_pack" id="resourcepack" />
              <label class="visible-ie-only" for="resourcepack">I need a resource pack</label>
              <div class="error-msg help-block"></div>
              <!-- <div>(Resource pack contains 1 x A3 poster, a supply of Membership catalogues, Code of Conduct booklet and a sample membership card)</div> -->
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12">
              <h4 class="bold">Additional resources</h4>
            </div>
            <div class="col-sm-6 form-group">
              <label class="visible-ie-only" for="membershipcat">Membership flyer:</label>
              <select class="form-control" name="membership_catalogues" id="membershipcat">
                <option value="0">Please select</option>
                <option {if $post.membership_catalogues eq '20'}selected="selected" {/if} value="20">20</option>
                <option {if $post.membership_catalogues eq '40'}selected="selected" {/if} value="40">40</option>
                <option {if $post.membership_catalogues eq '100'}selected="selected" {/if} value="100">100</option>
              </select>
              <div class="error-msg help-block"></div>
            </div>
            <div class="col-sm-6 form-group">
              <label class="visible-ie-only" for="a3posters">A3 posters:</label>
              <select class="form-control" name="a3_posters" id="a3posters">
                <option value="0">Please select</option>
                <option {if $post.a3_posters eq '1'}selected="selected" {/if} value="1">1</option>
                <option {if $post.a3_posters eq '2'}selected="selected" {/if} value="2">2</option>
                <option {if $post.a3_posters eq '3'}selected="selected" {/if} value="3">3</option>
              </select>
              <div class="error-msg help-block"></div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 form-group">
              <label class="visible-ie-only" for="stands">Membership Flyer Stand &amp; sample bracelet:</label>
              <select class="form-control" name="stands" id="stands">
                <option value="0">Please select</option>
                <option {if $post.stands eq '1'}selected="selected" {/if} value="1">1</option>
                <option {if $post.stands eq '2'}selected="selected" {/if} value="2">2</option>
              </select>
              <div class="error-msg help-block"></div>
            </div>
            <div class="col-sm-6 form-group"></div>
          </div>
          <div class="row">
            <div class="col-sm-12 form-group text-left">
              <label class="visible-ie-only" for="user_want_promo">
              <input type="checkbox" {if !$post || $post.user_want_promo}checked="checked" {/if}name="user_want_promo" id="user_want_promo" />
             Please keep me up to date with the latest information from MedicAlert.</label> <span class="hidden-xs"><a href="privacy-policy" target="_blank">Privacy Policy</a></span>
              <div class="error-msg help-block"></div>
              <span class="text-center visible-xs"><a href="privacy-policy" target="_blank">Privacy Policy</a></span>
            </div>
          </div>
          <div style="height: 0; overflow: hidden;">
            <input value="" type="text" name="honeypot" id="honeypot" tabindex="-1">
          </div>
          <div class="row error-msg" id="form-error" {if !$error}style="display: none"{/if}>{$error}</div>
          <div class="row">
            <div class="col-sm-12">
              <input type="button" value="Order resource pack" onclick="$('#contact_form').submit();" class="btn-red btn" id="fbsub">
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<div id="easyrefer">
  <div class="container">
    <div class="row">
      <div class="col-sm-10 col-sm-offset-1 text-center">
        {$listing_content2}

        <div class="row" id="easyrefermethods">
          <div class="col-sm-3">
            <img src="/images/refer-method1.png" alt="Letter" class="img-responsive" />
            <div>Complete a referral letter and either give it to your client or have your Practice Manager fax it to us on 1800 64 32 59. We'll handle the rest.</div>
          </div>
          <div class="col-sm-1 or">OR</div>
          <div class="col-sm-4">
            <img src="/images/refer-method2.png" alt="Online" class="img-responsive" />
            <div>Complete an online referral form (available on most leading GP software systems).</div>
          </div>
          <div class="col-sm-1 or">OR</div>
          <div class="col-sm-3">
            <img src="/images/refer-method3.png" alt="Form" class="img-responsive" />
            <div>Complete the MedicAlert application form (part of our membership catalogue).</div>
          </div>
        </div>

        {$listing_content3}
      </div>
    </div>
  </div>
</div>

<div id="seconds-count">
  <div class="container">
    <div class="row">
      <div class="col-sm-10 col-sm-offset-1 text-center">{$listing_content4}</div>
      <div class="col-sm-10 col-sm-offset-1 text-center">
        <img src="/images/dashboard-prods.png" alt="Products" class="img-responsive" />
      </div>
      <div class="col-sm-10 col-sm-offset-1 text-center">
        <a href="/products" title="Click to view our product range" class="btn btn-red">View more</a>
      </div>
    </div>
  </div>
</div>
{/block} {block name=tail}
<script src="/includes/js/jquery-ui.js"></script>
<script src="/includes/js/jquery.selectBoxIt.min.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
    
    $('#contact_form').validate();
    
    $('#postcode').rules("add", {
      digits: true,
      minlength: 4
    });
    
    $('#phone').rules("add", {
      digits: true,
      minlength: 8
    });
    
    $("select").selectBoxIt();
    
    $('#email').rules("add", {
      email: true
    });
    
  });
</script>
{/block}
