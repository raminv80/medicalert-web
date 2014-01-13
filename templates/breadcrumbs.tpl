{block name=breadcrumb} 
	{* Define the function *} 
	{function name=breadcrumbs level=0 parenturl=""} 
		{foreach $items as $item} 
			{if count($item.subs) > 0} >
				<a href="{$parenturl}/{$item.url}" title="{$item.title}">{$item.title}</a>
				{call name=breadcrumbs items=$item.subs level=$level+1 parenturl=$parenturl|cat:"/"|cat:$item.url}
			{else} 
				> {$item.title}
			{/if} 
		{/foreach} 
	{/function}
	
<div class="breadcrumbs">
	<a href="/" title="Home">Home</a>{call name=breadcrumbs items=$breadcrumbs}
</div>
{/block}
