{block name=body}
{* Define the function *} {function name=options_list level=0} 
	{foreach $opts as $opt}
		{if $fields.listing_id neq $opt.id}
			<option value="{$opt.id}" {if $fields.listing_parent_id eq $opt.id}selected="selected"{/if}>{for $var=1 to $level}- {/for}{$opt.value}</option>
			{if count($opt.subs) > 0} {call name=options_list opts=$opt.subs level=$level+1} {/if} 
		{/if}
	{/foreach} 
{/function}

<div class="row">
	<div class="col-sm-12">
		<form class="well form-horizontal" id="Edit_Record" accept-charset="UTF-8" method="post">
			<div class="row">
				<div class="col-sm-12">
					<fieldset>
						<legend>
							{if $fields.listing_id neq ""}Edit{else}New{/if} {$zone} 
							{if $cnt eq ""}{assign var=cnt value=0}{/if} 
							<a href="javascript:void(0);" onClick="$('#Edit_Record').submit();" class="btn btn-primary pull-right" style="margin-left: 38px;"><i class="icon-ok icon-white"></i> Save</a>
							
						</legend>
					</fieldset>
					<input type="hidden" value="listing_id" name="field[1][tbl_listing][{$cnt}][id]" id="id"/> 
					<input type="hidden" value="{$fields.listing_id}" name="field[1][tbl_listing][{$cnt}][listing_id]" id="listing_id">
					<input type="hidden" value="{$typeID}" name="field[1][tbl_listing][{$cnt}][listing_type_id]" id="listing_type_id"> 
					<input type="hidden" value="1" name="field[1][tbl_listing][{$cnt}][listing_parent_flag]" id="listing_parent_flag"> 
					<input type="hidden" value="0" name="field[1][tbl_listing][{$cnt}][listing_display_menu]" id="listing_display_menu">
					<input type="hidden" name="formToken" id="formToken" value="{$token}" /> 
				</div>
			</div>
			<div class="row form-group">
				<label class="col-sm-3 control-label" for="id_listing_name">Name *</label>
				<div class="col-sm-5">
					<input class="form-control" type="text" value="{$fields.listing_name}" name="field[1][tbl_listing][{$cnt}][listing_name]" id="id_listing_name" onchange="seturl(this.value);" required>
					<span class="help-block"></span>
				</div>
			</div>
			<div class="row form-group">
				<label class="col-sm-3 control-label" for="id_listing_title">Title *</label>
				<div class="col-sm-5">
					<input class="form-control" type="text" value="{$fields.listing_title}" name="field[1][tbl_listing][{$cnt}][listing_title]" id="id_listing_title" required>
					<span class="help-block"></span>
				</div>
			</div>
			<div class="row form-group">
				<label class="col-sm-3 control-label" for="id_listing_url">URL *</label>
				<div class="col-sm-5">
					<input class="form-control" type="text" value="{$fields.listing_url}" name="field[1][tbl_listing][{$cnt}][listing_url]" id="id_listing_url" required>
					<span class="help-block"></span>
				</div>
			</div>
			<div class="row form-group">
				<label class="col-sm-3 control-label" for="id_listing_parent">Parent</label>
				<div class="col-sm-5">
					<select class="form-control" name="field[1][tbl_listing][{$cnt}][listing_parent_id]" id="id_listing_parent">
						<option value="{$rootParentID}">None</option> 
						{call name=options_list opts=$fields.options.listing_parent_id}
					</select>
				</div>
			</div>
			<div class="row form-group">
				<label class="col-sm-3 control-label" for="id_listing_seo_title">SEO Title *</label>
				<div class="col-sm-5">
					<input class="form-control" type="text" value="{$fields.listing_seo_title}" name="field[1][tbl_listing][{$cnt}][listing_seo_title]" id="id_listing_seo_title" required>
					<span class="help-block"></span>
				</div>
			</div>
			<div class="row form-group">
				<label class="col-sm-3 control-label" for="id_listing_meta_description">Meta Description</label>
				<div class="col-sm-5">
					<input class="form-control" type="text" value="{$fields.listing_meta_description}" name="field[1][tbl_listing][{$cnt}][listing_meta_description]" id="id_listing_meta_description">
				</div>
			</div>
			<div class="row form-group">
				<label class="col-sm-3 control-label" for="id_listing_meta_words">Meta Words</label>
				<div class="col-sm-5">
					<input class="form-control" type="text" value="{$fields.listing_meta_words}" name="field[1][tbl_listing][{$cnt}][listing_meta_words]" id="id_listing_meta_words">
				</div>
			</div>
			<div class="row form-group">
				<label class="col-sm-3 control-label" for="id_listing_order">Order</label>
				<div class="col-sm-5">
					<input class="form-control" type="text" value="{$fields.listing_order}" name="field[1][tbl_listing][{$cnt}][listing_order]" id="id_listing_order">
				</div>
			</div>
			<div class="row form-group">
				<label class="col-sm-3 control-label" for="id_listing_published">Published</label>
				<div class="col-sm-5">
					<input type="hidden" value="{if $fields.listing_published eq 1}1{else}0{/if}" name="field[1][tbl_listing][{$cnt}][listing_published]" class="value"> 
					<input class="chckbx" type="checkbox" {if $fields.listing_published eq 1}checked="checked" {/if} 
					onclick="if($(this).is(':checked')){ $(this).parent().children('.value').val('1') }else{ $(this).parent().children('.value').val('0') }" id="id_listing_published">
				</div>
			</div>
			<div class="row form-group">
				<label class="col-sm-3 control-label" for="listing_image">Image<br><small>Size: 480px Wide x 480px Tall</small></label>
				<div class="col-sm-9">
					<input type="hidden" value="{$fields.listing_image}" name="field[1][tbl_listing][{$cnt}][listing_image]" id="listing_image_link" class="fileinput"> 
					<span class="file-view" id="listing_image_path"> {if $fields.listing_image}<a href="{$fields.listing_image}" target="_blank" >View</a>{else}None{/if} </span> 
					<a href="javascript:void(0);" class="btn btn-info marg-5r" onclick="getFileType('listing_image','','');">Select File</a> 
					<a href="javascript:void(0);" class="btn btn-info" onclick="$('#listing_image_link').val('');$('#listing_image_path').html('None');">Remove File</a>
				</div>
			</div>

			<div class="row form-group">
				<div class="col-sm-offset-3 col-sm-9">
					<a href="javascript:void(0);" onClick="$('#Edit_Record').submit();" class="btn btn-primary pull-right" style="margin-top: 50px;"> Save</a>
				</div>
			</div>
		</form>
	</div>
</div>

{include file='jquery-validation.tpl'}
<script type="text/javascript">
function seturl(str){
	$.ajax({
		type: "POST",
	    url: "/admin/includes/processes/urlencode.php",
		cache: false,
		data: "value="+encodeURIComponent(str),
		dataType: "json",
	    success: function(res, textStatus) {
	    	try{
	    		$('#id_listing_url').val(res.url);
	    	}catch(err){ }
	    }
	});
}

$(document).ready(function(){

	$('#Edit_Record').validate({
		onkeyup: false
	});
	
	$('#id_listing_url').rules("add", {
    	  uniqueURL: { id: "{if $fields.listing_id}{$fields.listing_id}{else}0{/if}" }
	 });
});
</script>
{/block}
