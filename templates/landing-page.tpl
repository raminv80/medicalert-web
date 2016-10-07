{block name=head}
<style type="text/css">

</style>
{/block}

{block name=body}
<div id="pagehead">
	<div class="bannerout">
      <img src="{if $listing_image}{$listing_image}{else}/images/newsdet-banner.jpg{/if}" alt="{$listing_name} banner" />
	</div>
	<div class="container">
		<div class="row">
			<div class="{if $listing_object_id eq 10}col-md-12{else}col-md-8 col-md-offset-2{/if} text-center">
				<h1>{if $listing_title}{$listing_title}{else}{$listing_name}{/if}</h1>
				{$listing_content1}
			</div>
		</div>
	</div>
</div>
{if $listing_content2}
<div id="cost-grey" class="pinkh4">
  <div class="container">
    <div class="row">
      <div class="col-md-12 text-center">
        {$listing_content2}
      </div>
    </div>
  </div>
</div>
{/if}
{if $listing_content3 || $listing_content4}
<div>
<div id="landing-page-middle" class="container">
    <br>
    <div class="row">
      <div class="col-md-12 text-center">
        {$listing_content3}
      </div>
    </div>
</div>
</div>
<br>
<div class="grey-bg-area video-wrapper">
<div class="container">
    <div class="row">
      <div class="col-md-12 text-center">
        {$listing_content4}
      </div>
    </div>
  </div>
</div>
{/if}

{if $popular_products && $listing_flag1}
<div id="popular">
  <div class="container">
    <div class="row">
      <div class="col-sm-12 text-center">
      <br><br>
        <h2>Popular Products</h2>
      </div>
    </div>


    <div class="row">
      <div id="popslide" class="flexslider">
        <ul class="slides">
    {foreach $popular_products as $item}
          <li>
            <div class="prod">
                <a href="/{$item.product_url}"> <img src="{$item.general_details.image}?width=770&height=492&crop=1" alt="{$item.product_name} image" class="img-responsive" title="{$item.product_name} image" />
        </a>
        <div class="prod-labels">
              {if $item.general_details.limitedstock.flag eq 1}
          <div class="prod-label btn btn-white">Limited stock</div>
          {/if}
          {if $item.general_details.new.flag eq 1}
          <div class="prod-label btn btn-white">New</div>
          {/if}
          {if $item.general_details.sale.flag eq 1}
          <div class="prod-label btn btn-red">Sale</div>
          {/if}
        </div>
        <div class="prod-info">
                  <div class="prod-name">
          <a href="/{$item.product_url}">{$item.product_name}</a>
          </div>
          <div class="prod-price">${$item.general_details.price.min|number_format:0:'.':','}{if $item.general_details.price.min neq $item.general_details.price.max} - ${$item.general_details.price.max|number_format:0:'.':','}{/if}</div>
          {if $item.general_details.has_attributes.2}
          <div class="colours">Available colours
            <div class="colourbox">
            {foreach $item.general_details.has_attributes.2 as $colour}
            <img src="{$colour.values.attr_value_image}?height=22&width=22" alt="{$colour.values.attr_value_name}" title="{$colour.values.attr_value_name}" />
            {/foreach}
          </div>
          </div>
          {/if}
        <div class="prod-wishlist"><img src="/images/prod-wishlist.png" alt="Wishlist"></div>
            </div>
          </li>
    {/foreach}
        </ul>
      </div>
    </div>
  </div>
</div>
{else}
<div class="container">
    <div class="row">
      <div class="col-md-12 text-center">
        &nbsp;
      </div>
    </div>
</div>
{/if}

{/block}

{* Place additional javascript here so that it runs after General JS includes *}
{block name=tail}
<script type="text/javascript" src="/includes/js/jquery.flexslider-min.js"></script>
<script type="text/javascript">

  (function() {

    // store the slider in a local variable
    var $window = $(window), flexslider;

    // tiny helper function to add breakpoints
    function getGridSize() {
      return (window.innerWidth < 768) ? 1 : (window.innerWidth < 992) ? 2 : 4;
    }

    $window.load(function() {
      $('.flexslider').flexslider({
        animation: "slide",
        controlNav: false,
        animationLoop: false,
        itemWidth: 210,
        itemMargin: 20,
        minItems: getGridSize(), // use function to pull in initial value
        maxItems: getGridSize(),
		start: function(slider){
			flexslider = slider;
		}
      });
    });

    // check grid size on resize event
    $window.resize(function() {
      var gridSize = getGridSize();

      flexslider.vars.minItems = gridSize;
      flexslider.vars.maxItems = gridSize;
    });
  }());
</script>
{/block}