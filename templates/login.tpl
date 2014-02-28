{block name=login}
<!--	<header>
		<div id="headout" class="headerbg">
				<div id="videobox">
					<div class="container">
						<div class="row-fluid">
							<div class="span7">
					  			{include file='breadcrumbs.tpl'}
					  			<h3 class="toptitle">{$product_name}</h3>
				  			</div>
						</div>
					</div>
				</div>
			</div>
	</header> -->
	<div class="container">
		<div class="col-sm-5">
			<div class="row error-msg" id="login-error"></div>
			<div class="row success-msg" id="login-success"></div>
		
			
			<!-- LOGIN SECTION  -->
			<div class="row" id="login">
				<h3>Existing Customer</h3>
				<form class="form-horizontal" id="login-form" role="form" accept-charset="UTF-8" action="" method="post">
					<input type="hidden" value="login" name="action" id="action" /> 
					<input type="hidden" value="" name="redirect" class="redirect" /> 
					<input type="hidden" name="formToken" id="formToken" value="{$token}" />
					<div class="form-group">
					    <label for="email" class="col-sm-3 control-label">Email</label>
					    <div class="col-sm-9">
					      	<input type="email" value="{if $post}{$post.email}{/if}" class="form-control" id="email" name="email" required>
					      	<span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
					    <label for="password" class="col-sm-3 control-label">Password</label>
					    <div class="col-sm-9">
					    	<input type="password" value="" class="form-control" id="pass" name="pass" required>
					    	<span class="help-block"></span>
	                        <span class="form-help-block"><a href="javascript:void(0)" onclick="$('#reset-pass').show('slow');$('#login').hide('slow');">Forgotten your password?</a></span>
						</div>
					</div>
				 	<div class="form-group">
				    	<div class="col-sm-offset-2 col-sm-10">
				      		<button type="submit" class="btn btn-primary">Log In</button>
				      		
				    	</div>
				  	</div>
				</form>
				<div class="row" style="margin:20px;">
					 <form id="facebook-form" action="/process/user" method="post">
						<input type="hidden" value="FBlogin" name="action" id="action" /> <!--  onclick="$('#facebook-form').submit();" -->
						<input type="hidden" name="formToken" id="formToken" value="{$token}" />
						<input type="hidden" value="" name="redirect" class="redirect" /> 
						<a href='javascript:void(0)' onclick="FBlogin();"><img src="/images/loginFB.gif" alt="login with facebook"></a>
					</form> 
					<!--<fb:login-button autologoutlink="true" data-scope="email, user_birthday, user_location" >Log In with Facebook</fb:login-button>
					-->
				</div>
				<div class="row" style="margin:20px;">
					<a href="javascript:void(0)" class="btn btn-success" onclick="$('#register').show('slow');$('#login').hide('slow');" >New User</a>
				</div>
				
			</div>
			
	                <!-- RESET PASSWORD SECTION - Hidden by default -->
			<div class="row" id="reset-pass" style="display:none;">
	                    <div class="row">
	                        <h3>Reset password</h3>
	                    </div>
				<form class="form-horizontal" id="reset-pass-form" role="form" accept-charset="UTF-8" action="" method="post">
					<input type="hidden" value="resetPassword" name="action" id="action" /> 
					<input type="hidden" name="formToken" id="formToken" value="{$token}" />
					<div class="form-group">
					    <label for="email" class="col-sm-3 control-label">Email</label>
					    <div class="col-sm-9">
					      	<input type="email" value="{if $post}{$post.email}{/if}" class="form-control" id="email" name="email" required>
							<span class="help-block"></span>
						</div>
					</div>
					<div class="col-md-offset-4" style="margin:20px;">
						<a href="javascript:void(0)" class="btn btn-default" onclick="$('#reset-pass').hide('slow');$('#login').show('slow');" >Back</a>
		                <button type="submit" class="btn btn-primary">Submit</button>
					</div>
				</form>
			</div>
			
			<!-- REGISTER SECTION - Hidden by default -->
			<div class="row" id="register" style="display:none;">
	                    <div class="row">
	                        <h3>Create an account</h3>
	                    </div>
				<form class="form-horizontal" id="register-form" role="form" accept-charset="UTF-8" action="" method="post">
					<input type="hidden" value="create" name="action" id="action" /> 
					<input type="hidden" value="" name="redirect" class="redirect" /> 
					<input type="hidden" name="formToken" id="formToken" value="{$token}" />
					<div class="form-group">
					    <label for="gname" class="col-sm-3 control-label">Given Name</label>
					    <div class="col-sm-9">
					      	<input type="text" value="{if $post}{$post.gname}{/if}" class="form-control" id="gname" name="gname" required>
							<span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
					    <label for="surname" class="col-sm-3 control-label">Surname</label>
					    <div class="col-sm-9">
					      	<input type="text" value="{if $post}{$post.surname}{/if}" class="form-control" id="surname" name="surname" required>
							<span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
					    <label for="email" class="col-sm-3 control-label">Email</label>
					    <div class="col-sm-9">
					      	<input type="email" value="{if $post}{$post.email}{/if}" class="form-control" id="reg-email" name="email" required>
							<span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
					    <label for="confirm_email" class="col-sm-3 control-label">Re-enter Email</label>
					    <div class="col-sm-9">
					      	<input type="text" value="{if $post}{$post.confirm_email}{/if}" class="form-control" id="confirm_email" name="confirm_email" required>
							<span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
					    <label for="password" class="col-sm-3 control-label">Password</label>
					    <div class="col-sm-9">
					    	<input type="password" value="" class="form-control" id="password" name="password" required>
				    		<span class="help-block"></span>
				    	</div>
					</div>
					<div class="form-group">
					    <label for="confirm_password" class="col-sm-3 control-label">Re-enter Password</label>
					    <div class="col-sm-9">
					    	<input type="password" class="form-control req" id="confirm_password" name="confirm_password" required>
							<span class="help-block"></span>
						</div>
					</div>
				 	<div class="form-group">
				    	<div class="col-sm-offset-2 col-sm-10">
				      		<button type="submit" class="btn btn-primary">Sign Up</button>
				    	</div>
				  	</div>
				</form>
				<div class="col-md-offset-4" style="margin:20px;">
					<a href="javascript:void(0)" class="btn btn-success" onclick="$('#register').hide('slow');$('#login').show('slow');" >I'm already registered</a>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function(){

			$('#login-form').validate();
			$('#register-form').validate();
			$('#reset-pass-form').validate({
				onkeyup: false,
				onclick: false
			});
			
			$('#confirm_password').rules("add", {
			      required: true,
			      equalTo: '#password',
			      messages: {
			        equalTo: "The passwords you have entered do not match. Please check them."
			      }
			 });

			$('#confirm_email').rules("add", {
			      required: true,
			      equalTo: '#reg-email',
			      messages: {
			        equalTo: "The emails you have entered do not match. Please check them."
			      }
			 }); 
		})
		
		
		function FBlogin(){
			var datastring = $("#facebook-form").serialize();
			$.ajax({
				type: "POST",
			    url: "/process/user",
				cache: false,
				data: datastring,
				dataType: "html",
			    success: function(data) {
			    	try{
			    		var obj = $.parseJSON(data);
					 	var msg = obj.message;
					 	var login_url = obj.login_url;  
					 	var error = obj.error;  

					 	if (login_url) {
					 		if (obj.new_window) {
						 		var left  = ($(window).width()/2)-(500/2),
						 	    	top   = ($(window).height()/2)-(270/2),
						 	     	popup = window.open (login_url, "Login_with_Facebook", "width=500, height=270, top="+top+", left="+left);
					 		} else {
					 			window.location.href = login_url;
							}    
						}else if (msg && error) {
						 	alert (msg);
					 	}
					}catch(err){
						console.log('TRY-CATCH error');
					}
			    },
				error: function(){
					console.log('AJAX error');
	          	}
			});
			
		}

		function redirectWin(url) {
			window.location.replace(url);
		}
		
		
	</script>
{/block} 