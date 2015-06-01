{block name=body}
   
<div id="enroltrialhead">
	<div class="container">
		<div class="row">
			<div class="col-sm-12 text-center">
				<span>Reset Password</span>
			</div>
		</div>
	</div>
</div>

<div id="enroltrialmain">
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2">
			<form class="form-horizontal" id="reset-password" data-attr-id="login-form" role="form" accept-charset="UTF-8" action="" method="post">
	    	<input type="hidden" value="passwordreset" name="action" id="action" /> 
	    	<input type="hidden" value="/my-account" name="redirect" class="redirect" /> 
	      <input type="hidden" name="formToken" id="formToken" value="{$token}" />
				<input type="hidden" name="userToken" id="userToken" value="{$request.token}" />
				<div class="row">
					<div class="form-group">
          <div class="col-sm-12">
            <label for="email" class="control-label">Email*:</label>
            <input type="email" value="{if $post}{$post.email}{/if}" class="form-control email req" id="email" name="email" onblur="$('#reset-email').val( this.value )" required autocomplete="off">
            <span class="help-block"></span>
          </div>
					</div>
	      	<div class="form-group">
          <div class="col-sm-12">
            <label for="password" class="control-label">New Password*:</label>
            <input class="form-control" type="text" id="password1" name="pass" autocomplete="off" required/>
            <a class="showhide" style="line-height: 34px;position: absolute;right: 23px;top: 31px;" href="javascript:void(0);" onclick="if($(this).html() == 'Show'){ $(this).closest('div').find('input[name=pass]').get(0).type='text';$(this).html('Hide'); }else{ $(this).closest('div').find('input[name=pass]').get(0).type='password';$(this).html('Show'); }" >Hide</a>
            <span class="help-block"></span>
	      	</div>
					</div>
	      	<div class="col-sm-12 error-alert" style="display:none;">
	       		<div class="alert alert-danger fade in ">
							<button class="close" aria-hidden="true" type="button" onclick="$(this).closest('.error-alert').fadeOut('slow');">&times;</button>
							<strong></strong>
						</div>
	      	</div>
	      	<div class="form-group">
	      		<div class="col-sm-12">
	       		<button type="submit" class="enquire">Reset Password</button>
	      		</div>
	    		</div>
      	</div> 
	    </form>
			</div>
		</div>
	</div>
</div>

<div id="helpblock">
<div class="top">
	<img src="/images/helpcircle.png" alt="" />
</div>

<div class="container">
	<div class="row">
		<div class="col-sm-12 text-center">
			<span class="vanish">Need help?</span> <span class="vanish">Call <a href="tel://1300 766 892">1300 766 892</a></span> <span class="vanish">or <a href="/contact-us#form">email us now</a>!</span>
		</div>
	</div>
</div>
</div>

{/block}

{* Place additional javascript here so that it runs after General JS includes *}
{block name=tail}
{literal}
<script type="text/javascript">
    $(document).ready(function(){

      $('#reset-password').validate({
        onkeyup: false,
        onclick: false,
				submitHandler: function (form) {
	    		$('.error-textbox').hide();
        	$('body').css('cursor','wait');
					var datastring = $(form).serialize();
					$.ajax({
						type: "POST",
	    			url: "/process/user",
						cache: false,
						data: datastring,
						dataType: "json",
	    			success: function(obj) {
	    				if (obj.success) {
			 					window.location.href = obj.url;
			 				} else {
								$(form).find('.success-alert').hide();
			 					$(form).find('.error-alert').find('strong').html(obj.error);
			 					$(form).find('.error-alert').fadeIn('slow');
								$('body').css('cursor','default'); 
			 				}
	   				},
						error: function(){
							$('body').css('cursor','default'); 
							console.log('AJAX error');
      			}
					});
				}
      });
      
    });


	function redirectWin(url) {
		window.location.replace(url);
	}
  </script>{/literal}
{/block}


                    
            
