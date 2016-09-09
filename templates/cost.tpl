{block name=head}
<style type="text/css">

</style>
{/block}

{block name=body}
<div id="pagehead">
	{if $listing_image}
	<div class="bannerout">
		<img src="{$listing_image}" alt="{$listing_name} banner" />
	</div>
	{/if}
	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2 text-center">
				<h1>MedicAlert membership is a small price to pay for complete peace of mind</h1>
				{$listing_content1}
			</div>
		</div>
	</div>
</div>

<div id="cost">
	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
			<div class="row">

			<div class="col-sm-3 text-center">
				<img src="/images/cost-medicalid.png" alt="Medical ID" class="img-responsive" />
				<div class="cost-text">Medical ID with free engraving – starting from <span>$35</span></div>
			</div>
			<div class="col-sm-1 text-center">

			</div>
			<div class="col-sm-4 text-center">
				<img src="/images/cost-membership.png" alt="Membeship" class="img-responsive" />
				<div class="cost-text">Membership – <span>{$CONFIG_VARS['membership_fee']}</span></div>
			</div>
			<div class="col-sm-1 text-center">

			</div>
			<div class="col-sm-3 text-center">
				<img src="/images/cost-post.png" alt="Postage" class="img-responsive" />
				<div class="cost-text">Postage – from <span>$</span></div>
			</div>

			</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12 text-center">
				<a href="#" class="btn btn-red">View benefits</a>
				<a href="#" class="btn btn-white">View products</a>
			</div>
		</div>
	</div>
</div>

<div id="cost-grey">
	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2 text-center">
				{$listing_content2}
			</div>
		</div>
	</div>
</div>

<div id="cost-help">
	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2 text-center">
				{$listing_content3}

				<div class="row">
					<div class="col-sm-4 helpimg text-center"><img src="/images/cost-hbf.jpg" class="img-responsive" alt="HBS" /></div>
					<div class="col-sm-4 helpimg text-center"><img src="/images/cost-cbhs.jpg" class="img-responsive" alt="CBHS" /></div>
					<div class="col-sm-4 helpimg text-center"><img src="/images/cost-aca.jpg" class="img-responsive" alt="ACA Health" /></div>
				</div>
				<br />
				<p>To see what you’re covered for, please contact your health fund provider.</p>

				<p>Bupa members receive this exclusive offer:</p>
					<img src="/images/cost-bupa.jpg" class="img-responsive hidden-xs" alt="Bupa offer" />
					<img src="/images/mob-bupa.jpg" class="img-responsive visible-xs" alt="Bupa offer" />
				<br />
				<br />
				<div class="row">
					<div class="col-sm-4 text-center" id="vet-img">
						<img src="/images/cost-ausgov.jpg" class="img-responsive" alt="Government of Australia" />
					</div>

					<div class="col-sm-8 text-left" id="vet-text">
						DVA Gold Card holders can also receive rebates on their annual membership fees and stainless steel medical IDs. <a href="#">Contact us</a> to find out more.
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

{/block}

{* Place additional javascript here so that it runs after General JS includes *}
{block name=tail}
<script type="text/javascript">
jQuery(document).ready(function(){
	$("#readmore").click(function(){
		$(this).hide();
		$("#benefits #benefit1").show();
	});

	$("#readmore2").click(function(){
		$(this).hide();
		$("#benefits #benefit4 .tablebox").css("height","auto");
	});

});
</script>
{/block}
