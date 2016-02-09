{block name=body}
<div class="row">
	<div class="col-sm-12">
		<form class="well form-horizontal" id="Edit_Record" accept-charset="UTF-8" method="post">
			<div class="row">
				<div class="col-sm-12 edit-page-header">
							<span class="edit-page-title">{if $fields.listing_id neq ""}Edit{else}New{/if} {$zone}</span>
							{if $cnt eq ""}{assign var=cnt value=0}{/if} 
							<a href="javascript:void(0);" onClick="$('#Edit_Record').submit();" class="btn btn-primary pull-right top-btn"><span class="glyphicon glyphicon-floppy-saved"></span> Save</a>
							<div class="published" {if $fields.listing_published eq 0}style="display:none;"{/if}>
								<!-- PUBLISHED -->
								<a href="javascript:void(0);" onClick="saveDraft('field[1][tbl_listing][{$cnt}][id]','listing_object_id','listing_published','field[1][tbl_listing][{$cnt}][listing_deleted]',false);" class="btn btn-info pull-right top-btn published"><span class="glyphicon glyphicon-floppy-disk"></span> Save Draft Version</a>
								<a href="javascript:void(0);" onClick="unpublish('listing_published');" class="btn btn-warning pull-right top-btn"><span class="glyphicon glyphicon-thumbs-down"></span> Unpublish</a>
							</div>
							<div class="drafts" {if $fields.listing_published eq 1}style="display:none;"{/if}>
								<!-- DRAFT -->
								<a href="javascript:void(0);" onClick="publish('field[1][tbl_listing][{$cnt}][id]','listing_object_id','listing_published','field[1][tbl_listing][{$cnt}][listing_deleted]');" class="btn btn-primary pull-right top-btn drafts"><span class="glyphicon glyphicon-thumbs-up"></span> Save &amp; Publish</a>
							</div>
							<a href="javascript:void(0);" onClick="saveDraft('field[1][tbl_listing][{$cnt}][id]','listing_object_id','listing_published','field[1][tbl_listing][{$cnt}][listing_deleted]', true);" class="btn btn-info pull-right top-btn"><span class="glyphicon glyphicon-eye-open"></span> Preview</a>
					<input type="hidden" value="listing_id" name="primary_id" id="primary_id"/> 
					<input type="hidden" value="listing_id" name="field[1][tbl_listing][{$cnt}][id]" id="id" /> 
					<input type="hidden" value="{$fields.listing_id}" name="field[1][tbl_listing][{$cnt}][listing_id]" id="listing_id" class="key"> 
					<input type="hidden" value="{if $fields.listing_object_id}{$fields.listing_object_id}{else}{$objID}{/if}" name="field[1][tbl_listing][{$cnt}][listing_object_id]" id="listing_object_id"> 
					<input type="hidden" value="{if $fields.listing_created}{$fields.listing_created}{else}{'Y-m-d H:i:s'|date}{/if}" name="field[1][tbl_listing][{$cnt}][listing_created]" id="listing_created">
					<input type="hidden" value="{if $typeID}{$typeID}{else}1{/if}" name="field[1][tbl_listing][{$cnt}][listing_type_id]" id="listing_type_id">
					<input type="hidden" value="{$fields.listing_published}" name="field[1][tbl_listing][{$cnt}][listing_published]" id="listing_published">
					<input type="hidden" value="0" name="field[1][tbl_listing][{$cnt}][listing_parent_flag]" class="value">
					<input type="hidden" value="0" name="field[1][tbl_listing][{$cnt}][listing_display_menu]" class="value">
					<input type="hidden" value="{$rootParentID}" name="field[1][tbl_listing][{$cnt}][listing_parent_id]" id="id_listing_parent">
					<input type="hidden" name="formToken" id="formToken" value="{$token}"/>
				</div>
			</div>
			<div class="row published" {if $fields.listing_published eq 0}style="display:none;"{/if}>
				<div class="alert alert-success text-center">
					<strong>PUBLISHED</strong> 
				</div>
			</div>
			<div class="row drafts" {if $fields.listing_published eq 1}style="display:none;"{/if}>
				<div class="alert alert-info text-center">
					<strong>DRAFT</strong>
				</div>
			</div>
			<ul class="nav nav-tabs" id="myTab">
				<li class="active"><a href="#details" data-toggle="tab">Details</a></li>
				<li><a href="#images" data-toggle="tab">Images</a></li>
				<li><a href="#share" data-toggle="tab">Social Sharing</a></li>
				<li><a href="#files" data-toggle="tab">Files</a></li>
				<li><a href="#tags" data-toggle="tab">Tags</a></li>
				<li><a href="#log" data-toggle="tab">Log</a></li>
			</ul>
		
			<div class="tab-content">
				<!--===+++===+++===+++===+++===+++ DETAILS TAB +++===+++===+++===+++===+++====-->
				<div class="tab-pane active" id="details">
					<div class="row form" data-error="Error found on <b>Details tab</b>. View <b>Details tab</b> to see specific error notices.">
						<div class="row form-group">
              <label class="col-sm-3 control-label" for="id_listing_schedule_start">Scheduled Start *</label>
              <div class="col-sm-2">
                <input class="form-control dates" type="text" value="{if $fields.listing_schedule_start}{$fields.listing_schedule_start|date_format:"%d/%m/%Y"}{else}{$smarty.now|date_format:"%d/%m/%Y"}{/if}"  name="from" id="from" onchange="setDateValue('id_listing_schedule_start',this.value);" required>
                <input type="hidden" value="{if $fields.listing_schedule_start}{$fields.listing_schedule_start}{else}{$smarty.now|date_format:"%Y-%m-%d"}{/if}" name="field[1][tbl_listing][{$cnt}][listing_schedule_start]" id="id_listing_schedule_start">
              </div>
              <label class="col-sm-2 control-label" for="id_listing_schedule_end">Scheduled Archive *</label>
              <div class="col-sm-2">
                <input class="form-control dates" type="text" value="{if $fields.listing_schedule_end}{$fields.listing_schedule_end|date_format:"%d/%m/%Y"}{else}{"+12 months"|date_format:"%d/%m/%Y"}{/if}"  name="to" id="to" onchange="setDateValue('id_listing_schedule_end',this.value);" required>
                <input type="hidden" value="{if $fields.listing_schedule_end}{$fields.listing_schedule_end}{else}{"+12 months"|date_format:"%Y-%m-%d"}{/if}" name="field[1][tbl_listing][{$cnt}][listing_schedule_end]" id="id_listing_schedule_end">
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
							<label class="col-sm-3 control-label" for="id_listing_url">URL *</label>
							<div class="col-sm-5">
								<input class="form-control" type="hidden" value="{$fields.listing_url}" name="field[1][tbl_listing][{$cnt}][listing_url]" id="id_listing_url" onchange="seturl(this.value, true);" >
                <span id="id_listing_url_text" class="form-control url-text edit-url">{$fields.listing_url}&nbsp;</span>
                <a href="javascript:void(0);" class="btn btn-info btn-sm marg-5r edit-url" onclick="$('.edit-url').removeClass('url-text').hide();$('#id_listing_url').get(0).type='text';">Edit URL</a> 
								<span class="help-block"></span>
							</div>
						</div>

						<div class="row form-group">
							<label class="col-sm-3 control-label" for="id_listing_seo_title">SEO Title *</label>
							<div class="col-sm-5">
								<input class="form-control" type="text" onkeyup="$(this).parent().find('.charcount').html($(this).val().length);" value="{$fields.listing_seo_title}" name="field[1][tbl_listing][{$cnt}][listing_seo_title]" id="id_listing_seo_title" required>
								<span class="small pull-right charcount">{$fields.listing_seo_title|count_characters:true}</span><span class="small pull-right">characters: </span><span class="help-block"></span>
							</div>
						</div>
						<div class="row form-group">
							<label class="col-sm-3 control-label" for="id_listing_meta_description">Meta Description</label>
							<div class="col-sm-5">
								<textarea class="form-control" rows="3" onkeyup="$(this).parent().find('.charcount').html($(this).val().length);" name="field[1][tbl_listing][{$cnt}][listing_meta_description]" id="id_listing_meta_description">{$fields.listing_meta_description}</textarea>
								<span class="small pull-right charcount">{$fields.listing_meta_description|count_characters:true}</span><span class="small pull-right">characters: </span>
							</div>
						</div>
						<div class="row form-group">
							<label class="col-sm-3 control-label" for="id_listing_meta_words">Meta Words</label>
							<div class="col-sm-5">
								<input class="form-control" type="text" value="{$fields.listing_meta_words}" name="field[1][tbl_listing][{$cnt}][listing_meta_words]" id="id_listing_meta_words">
							</div>
						</div>
						<div class="row form-group">
								<label class="col-sm-3 control-label" for="listing_image">Header Image<br>
								<small>Size: 1960px Wide x 345px Tall <br>("None" for default image)</small></label>
							<div class="col-sm-9">
								<input type="hidden" value="{$fields.listing_image}" name="field[1][tbl_listing][{$cnt}][listing_image]" id="listing_image_link" class="fileinput"> 
								<span class="file-view" id="listing_image_path"> {if $fields.listing_image}<a href="{$fields.listing_image}" target="_blank" >View</a>{else}None{/if} </span> 
								<a href="javascript:void(0);" class="btn btn-info marg-5r" onclick="getFileType('listing_image','','');">Select File</a> 
								<a href="javascript:void(0);" class="btn btn-info" onclick="$('#listing_image_link').val('');$('#listing_image_path').html('None');">Remove File</a>
							</div>
						</div>
						<div class="row form-group">
							<label class="col-sm-3 control-label" for="id_listing_content1">Content</label>
							<div class="col-sm-5">
								<textarea name="field[1][tbl_listing][{$cnt}][listing_content1]" id="id_listing_content1" class="tinymce">{$fields.listing_content1}</textarea>
							</div>
						</div>
						<div class="row form-group">
              <label class="col-sm-3 control-label" for="id_listing_content2">Content 2</label>
              <div class="col-sm-5">
                <textarea name="field[1][tbl_listing][{$cnt}][listing_content2]" id="id_listing_content2" class="tinymce">{$fields.listing_content2}</textarea>
              </div>
            </div>
					</div>
				</div>
				<!--===+++===+++===+++===+++===+++ IMAGES TAB +++===+++===+++===+++===+++====-->
				<div class="tab-pane" id="images">
					<div class="form" id="images-wrapper">
						{assign var='imageno' value=0}
						{assign var='gTableName' value='listing'}
						{assign var='image_size' value='Size: 1170px Wide x 560px Tall'}
						{foreach $fields.gallery as $images}
							{assign var='imageno' value=$imageno+1}
							{include file='gallery.tpl'}
						{/foreach}
					</div>
					<div class="row btn-inform">
						<a href="javascript:void(0);" class="btn btn-success btn-add-new" onclick="$('.images').slideUp();newImage();"> Add New Image</a>
					</div>
					<input type="hidden" value="{$imageno}" id="imageno">
				</div>
				<!--===+++===+++===+++===+++===+++ SHARE TAB +++===+++===+++===+++===+++====-->
        <div class="tab-pane" id="share">
          <div class="row form" data-error="Error found on <b>Social Sharing tab</b>. View <b>Details tab</b> to see specific error notices.">
            <div class="row form-group">
              <label class="col-sm-3 control-label" for="id_listing_share_title">Share Title</label>
              <div class="col-sm-5">
                <input class="form-control" type="text" value="{$fields.listing_share_title}" name="field[1][tbl_listing][{$cnt}][listing_share_title]" id="id_listing_share_title" >
                <span class="help-block"></span>
              </div>
            </div>
            <div class="row form-group">
                <label class="col-sm-3 control-label" for="listing_share_image">Share Image<br>
                <small>Size: 1200px Wide x 630px Tall (less than 1Mb) <br>("None" for default image)</small></label>
              <div class="col-sm-9">
                <input type="hidden" value="{$fields.listing_share_image}" name="field[1][tbl_listing][{$cnt}][listing_share_image]" id="listing_share_image_link" class="fileinput"> 
                <span class="file-view" id="listing_share_image_path"> {if $fields.listing_share_image}<a href="{$fields.listing_share_image}" target="_blank" >View</a>{else}None{/if} </span> 
                <a href="javascript:void(0);" class="btn btn-info marg-5r" onclick="getFileType('listing_share_image','','');">Select File</a> 
                <a href="javascript:void(0);" class="btn btn-info" onclick="$('#listing_share_image_link').val('');$('#listing_share_image_path').html('None');">Remove File</a>
              </div>
            </div>
            <div class="row form-group">
              <label class="col-sm-3 control-label" for="id_listing_share_text">Share Text <br><span class="small">(120 Characters)</span></label>
              <div class="col-sm-5">
                <textarea class="form-control"name="field[1][tbl_listing][{$cnt}][listing_share_text]" id="id_listing_share_text" maxlength="120">{$fields.listing_share_text}</textarea>
              </div>
            </div>
          </div>
        </div>
				<!--===+++===+++===+++===+++===+++ FILES TAB +++===+++===+++===+++===+++====-->
				<div class="tab-pane" id="files">
					<div class="row form" id="files-wrapper">{assign var='filesno' value=0} {assign var='gTableName' value='listing'} {foreach $fields.files as $files} {assign var='filesno' value=$filesno+1} {include file='files.tpl'} {/foreach}</div>
					<div class="row btn-inform">
						<a href="javascript:void(0);" class="btn btn-success btn-add-new" onclick="$('.files').slideUp();newFile();"> Add New File</a>
					</div>
					<input type="hidden" value="{$filesno}" id="filesno">
				</div>
				<!--===+++===+++===+++===+++===+++ TESTIMONIALS TAB +++===+++===+++===+++===+++====-->
				<div class="tab-pane" id="testimonials">
					<div class="row form" id="testimonials-wrapper">{assign var='testimonialsno' value=0} {assign var='gTableName' value='listing'} {foreach $fields.testimonials as $testimonials} {assign var='testimonialsno' value=$testimonialsno+1} {include file='testimonial.tpl'} {/foreach}</div>
					<div class="row btn-inform">
						<a href="javascript:void(0);" class="btn btn-success btn-add-new" onclick="$('.testimonials').slideUp();newTestimonial();"> Add New Testimonial</a>
					</div>
					<input type="hidden" value="{$testimonialsno}" id="testimonialsno">
				</div>
				<!--===+++===+++===+++===+++===+++ TAGS TAB +++===+++===+++===+++===+++====-->
				<div class="tab-pane" id="tags">
					<div class="form">
						<div class="row form-group">
							<label class="col-sm-2 control-label" for="new_tag">Tag</label>
							<div class="col-sm-5">
								<div class="ui-widget">
									<input class="form-control" id="new_tag">
									<a href="javascript:void(0);" class="btn btn-success btn-add-new" onclick="newTag();"> Add Tag</a>
								</div>
							</div>
						</div>
					</div>
					<div class="row form" id="tags-wrapper">
					{assign var='tagno' value=0}
					{assign var='table_name' value='tbl_listing'}
					{assign var='default' value='listing_id'}
					{foreach $fields.tags as $tag}
						{assign var='tagno' value=$tagno+1}
						{include file='tag.tpl'}
					{/foreach}
					</div>
					<input type="hidden" value="{$tagno}" id="tagno">
				</div>
				<!--===+++===+++===+++===+++===+++ LOG TAB +++===+++===+++===+++===+++====-->
				<div class="tab-pane" id="log">
					<div class="row form" id="tags-wrapper">
						<div class="col-sm-12">
							{if $fields.logs}
								<table class="table table-bordered table-striped table-hover">
									<thead>
										<tr>
											<th>Date-Time</th>
											<th>Action</th>
											<th>User</th>
										</tr>
									</thead>
									<tbody>
									{foreach $fields.logs as $log}
										<tr {if $log.listing_id eq $fields.listing_id}class="info"{/if}>
											<td>{$log.log_created|date_format:"%d/%b/%Y %r"}</td>
											<td>{$log.log_action}{if $log.log_action eq 'Add' || $log.log_action eq 'Delete'} draft{/if}</td>
											<td>{$log.admin_name}</td>
										</tr>
									{/foreach}
									</tbody>
								</table>
							{else}
								Log empty.
							{/if}
						</div>
					</div>
				</div>
			</div>
			<div class="row form-group form-bottom-btns">
				<a href="javascript:void(0);" onClick="$('#Edit_Record').submit();" class="btn btn-primary pull-right top-btn"><span class="glyphicon glyphicon-floppy-saved"></span> Save</a>
				<div class="published" {if $fields.listing_published eq 0}style="display:none;"{/if}>
					<!-- PUBLISHED -->
					<a href="javascript:void(0);" onClick="saveDraft('field[1][tbl_listing][{$cnt}][id]','listing_object_id','listing_published','field[1][tbl_listing][{$cnt}][listing_deleted]', false);" class="btn btn-info pull-right top-btn published"><span class="glyphicon glyphicon-floppy-disk"></span> Save Draft Version</a>
					<a href="javascript:void(0);" onClick="unpublish('listing_published');" class="btn btn-warning pull-right top-btn"><span class="glyphicon glyphicon-thumbs-down"></span> Unpublish</a>
				</div>
				<div class="drafts" {if $fields.listing_published eq 1}style="display:none;"{/if}>
					<!-- DRAFT -->
					<a href="javascript:void(0);" onClick="publish('field[1][tbl_listing][{$cnt}][id]','listing_object_id','listing_published','field[1][tbl_listing][{$cnt}][listing_deleted]');" class="btn btn-primary pull-right top-btn drafts"><span class="glyphicon glyphicon-thumbs-up"></span> Save &amp; Publish</a>
				</div>
				<a href="javascript:void(0);" onClick="saveDraft('field[1][tbl_listing][{$cnt}][id]','listing_object_id','listing_published','field[1][tbl_listing][{$cnt}][listing_deleted]', true);" class="btn btn-info pull-right top-btn"><span class="glyphicon glyphicon-eye-open"></span> Preview</a>
			</div>
		</form>
	</div>
</div>

{include file='jquery-validation.tpl'}

<script type="text/javascript">

function seturl(str){
	seturl(str,false);
}
function seturl(str,editexisting){
	$.ajax({
		type: "POST",
	    url: "/admin/includes/processes/urlencode.php",
		cache: false,
		data: "value="+encodeURIComponent(str),
		dataType: "json",
	    success: function(res, textStatus) {
	    	try{
	    		if($('#listing_id').val() == "" || editexisting == true){
	    		$('#id_listing_url').val(res.url);
	    		$('#id_listing_url_text').html(res.url);
	    		}
	    	}catch(err){ }
	    }
	});
}

$(document).ready(function(){

	$('#Edit_Record').validate({
		onkeyup: false
	});
	$('.images').hide();
	$('.files').hide();
	
	$('#id_listing_url').rules("add", {
    	  uniqueURL: { 
        	  	id: $('#listing_object_id').val(),
        	  	idfield: "listing_object_id",
	        	table : "tbl_listing",
	        	field : "listing_url",
	        	field2 : "listing_parent_id",
	        	value2 : "id_listing_parent"
		  }
	 });

	$("#from").datepicker({
      changeMonth : true,
      changeYear : true,
      dateFormat : "dd/mm/yy",
      onSelect : function(selectedDate) {
        $("#id_listing_schedule_start").val( convert_to_mysql_date_format(selectedDate) );
        $("#to").datepicker("option", "minDate", selectedDate);
      }
    });

    $("#to").datepicker({
      changeMonth : true,
      changeYear : true,
      dateFormat : "dd/mm/yy",
      onSelect : function(selectedDate) {
        $("#id_listing_schedule_end").val( convert_to_mysql_date_format(selectedDate) );
        $("#from").datepicker("option", "maxDate", selectedDate);
      }
    });
});

function saveDraft(id_name,objId_name,publish_name, field_name, preview){
	if ($('#Edit_Record').valid()) { 
		$('body').css('cursor', 'wait');
		$('#'+publish_name).val('0');
		var id_key0 = encodeURIComponent(id_name+'[0]');
		var id_key1 = encodeURIComponent(id_name+'[1]');
		var objId_key = encodeURIComponent($('#'+objId_name).attr('name'));
		var publish_key = encodeURIComponent($('#'+publish_name).attr('name'));
		var field_key = encodeURIComponent(field_name);
		var field_value = encodeURIComponent(mysql_now());
		$.ajax({
			type : "POST",
			url : "/admin/includes/processes/processes-record.php",
			cache: false,
			async: false,
			data : id_key0+'='+objId_name+'&'+id_key1+'='+publish_name+'&'+objId_key+"="+$('#'+objId_name).val()+"&"+publish_key+"=0&"+field_key+"="+field_value+'&formToken='+$('#formToken').val(),
			dataType: "html",
			success : function(data, textStatus) {
				try {
					var obj = $.parseJSON(data);
					if(obj.notice){ 
						$('.key').val('');
						$('#Edit_Record').submit();
						$('.published').hide();
						$('.drafts').show();
						buildUrl('tbl_listing','listing_parent_id',objId_name, preview);
					}
				} catch (err) {}
				$('body').css('cursor', 'default');
			}
		});
		$('body').css('cursor', 'default');
	} 
}

function publish(id_name,objId_name,publish_name,field_name){
	if ($('#Edit_Record').valid()) { 
		$('body').css('cursor', 'wait');
		$('#'+publish_name).val('1');
		var id_key0 = encodeURIComponent(id_name+'[0]');
		var id_key1 = encodeURIComponent(id_name+'[1]');
		var objId_key = encodeURIComponent($('#'+objId_name).attr('name'));
		var publish_key = encodeURIComponent($('#'+publish_name).attr('name'));
		var field_key = encodeURIComponent(field_name);
		var field_value = encodeURIComponent(mysql_now());
		$.ajax({
			type : "POST",
			url : "/admin/includes/processes/processes-record.php",
			cache: false,
			data : id_key0+'='+objId_name+'&'+id_key1+'='+publish_name+'&'+objId_key+"="+$('#'+objId_name).val()+"&"+publish_key+"=1&"+field_key+"="+field_value+'&formToken='+$('#formToken').val(),
			dataType: "html",
			success : function(data, textStatus) {
				try {
					var obj = $.parseJSON(data);
					if(obj.notice){ 
						$('#Edit_Record').submit();
						$('.drafts').hide();
						$('.published').show();
					}
				} catch (err) {}
				$('body').css('cursor', 'default');
			}
		});
		$('body').css('cursor', 'default');
	} 
}

function unpublish(publish_name){
	$('#'+publish_name).val('0');
	$('#Edit_Record').submit();
	$('.published').hide();
	$('.drafts').show();
}

function newImage() {
	$('body').css('cursor', 'wait');
	var no = $('#imageno').val();
	no++;
	$('#imageno').val(no);
	$.ajax({
		type : "POST",
		url : "/admin/includes/processes/load-template.php",
		cache : false,
		data : "template=gallery.tpl&imageno=" + no + "&gTableName=listing&image_size="+ encodeURIComponent('Size: 1170px Wide x 560px Tall'),
		dataType : "html",
		success : function(data, textStatus) {
			try {
				$('#images-wrapper').append(data);
				$('body').css('cursor', 'default');
				scrolltodiv('#image_wrapper' + no);
				if (no == 1) {
					$('#gallery_ishero_1').val('1');
				}
			} catch (err) {
				$('body').css('cursor', 'default');
			}
		}
	});
}

function toggleImage(ID) {
	if ($('#image' + ID).is(':visible')) {
		$('.images').slideUp();
	} else {
		$('.images').slideUp();
		$('#image' + ID).slideDown();
	}
}

function deleteImage(ID) {
	if (ConfirmDelete()) {
		var count = $('#' + ID).attr('rel');
		var today = mysql_now();

		html = '<input type="hidden" value="'+today+'" name="field[10][tbl_gallery]['+count+'][gallery_deleted]" />';
		$('#' + ID).append(html);
		$('#' + ID).css('display', 'none');
		$('#' + ID).removeClass('images');
	} else {
		return false;
	}
}

function newFile() {
	$('body').css('cursor', 'wait');
	var no = $('#filesno').val();
	no++;
	$('#filesno').val(no);
	$.ajax({
		type : "POST",
		url : "/admin/includes/processes/load-template.php",
		cache : false,
		data : "template=files.tpl&filesno=" + no + "&gTableName=listing",
		dataType : "html",
		success : function(data, textStatus) {
			try {
				$('#files-wrapper').append(data);
				$('body').css('cursor', 'default');
				scrolltodiv('#file_wrapper' + no);
			} catch (err) {
				$('body').css('cursor', 'default');
			}
		}
	});
}

function toggleFile(ID) {
	if ($('#file' + ID).is(':visible')) {
		$('.files').slideUp();
	} else {
		$('.files').slideUp();
		$('#file' + ID).slideDown();
	}
}

function deleteFile(ID) {
	if (ConfirmDelete()) {
		var count = $('#' + ID).attr('rel');
		var today = mysql_now();

		html = '<input type="hidden" value="'+today+'" name="field[10][tbl_files]['+count+'][files_deleted]" />';
		$('#' + ID).append(html);
		$('#' + ID).css('display', 'none');
		$('#' + ID).removeClass('files');
	} else {
		return false;
	}
}

//START TESTIMONIALS
function newTestimonial() {
	$('body').css('cursor', 'wait');
	var no = $('#testimonialsno').val();
	no++;
	$('#testimonialsno').val(no);
	$.ajax({
		type : "POST",
		url : "/admin/includes/processes/load-template.php",
		cache : false,
		data : "template=testimonial.tpl&testimonialsno=" + no + "&gTableName=listing",
		dataType : "html",
		success : function(data, textStatus) {
			try {
				$('#testimonials-wrapper').append(data);
				$('body').css('cursor', 'default');
				scrolltodiv('#testimonial_wrapper' + no);
			} catch (err) {
				$('body').css('cursor', 'default');
			}
		}
	});
}

function toggleTestimonial(ID) {
	if ($('#testimonial' + ID).is(':visible')) {
		$('.testimonials').slideUp();
	} else {
		$('.testimonials').slideUp();
		$('#testimonial' + ID).slideDown();
	}
}

function deleteTestimonial(ID) {
	if (ConfirmDelete()) {
		var count = $('#' + ID).attr('rel');
		var today = mysql_now();

		html = '<input type="hidden" value="'+today+'" name="field[10][tbl_testimonial]['+count+'][testimonial_deleted]" />';
		$('#' + ID).append(html);
		$('#' + ID).css('display', 'none');
		$('#' + ID).removeClass('testimonials');
	} else {
		return false;
	}
}
//END TESTIMONIALS

function newTag() {
	if ( $('#new_tag').val() != '' ) { 
		$('body').css('cursor', 'wait');
		var no = $('#tagno').val();
		no++;
		$('#tagno').val(no);
		$.ajax({
			type : "POST",
			url : "/admin/includes/processes/processes-tags.php",
			cache : false,
			data : "template=tag.tpl&tagno=" + no + "&tag%5Btag_value%5D="	+  $('#new_tag').val() + "&table_name=tbl_listing&default=listing_id&objId=" + $('#listing_id').val(),
			dataType : "html",
			success : function(data, textStatus) {
				try {
					$('#tags-wrapper').prepend(data);
					$('#new_tag').val('');
					$('body').css('cursor', 'default');
					$('#new_tag').closest('.form-group').removeClass('has-success').removeClass('has-error');
				} catch (err) {
					$('body').css('cursor', 'default');
				}
			}
		});
	} else {
		$('#new_tag').closest('.form-group').removeClass('has-success').addClass('has-error');
	}
}

function deleteTag(ID) {
	if (ConfirmDelete()) {
		var count = $('#' + ID).attr('rel');
		var today = mysql_now();

		html = '<input type="hidden" value="'+today+'" name="field[15][tbl_tag]['+count+'][tag_deleted]" />';
		$('#' + ID).append(html);
		$('#' + ID).css('display', 'none');
		$('#' + ID).removeClass('tags');
	} else {
		return false;
	}
}

</script>
{/block}