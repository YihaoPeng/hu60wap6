{config_load file="conf:site.info"}
{if $fid == 0}
	{$fName=#BBS_INDEX_NAME#}
{else}
	{$fIndex.0.name=#BBS_INDEX_NAME#}
{/if}
{include file="tpl:comm.head" title="{$tMeta.title} - {$fName} - {#BBS_NAME#}"}

<script>
	function atAdd(uid) {
		var nr = document.getElementById("content");
		nr.value += "@"+uid+"，";
	}
</script>

<!--导航栏-->
<div class="tp">
    <a href="index.index.{$BID}">首页</a>
    {foreach $fIndex as $forum}
        &gt; <a href="{$CID}.forum.{$forum.id}.{$BID}">{$forum.name|code}</a>
    {/foreach}
    {if !$forum.notopic}(<a href="{$CID}.newtopic.{$forum.id}.{$BID}">发帖</a>){/if}
</div>

<div>
	{if $p == 1}

		{$v=array_shift($tContents)}
		<p>标题: {$tMeta.title|code}</p>
		<p>作者: <a href="user.info.{$v.uinfo.uid}.{$BID}">{$v.uinfo.name|code}</a> <a href="#" onclick="atAdd('{$v.uinfo.name|code}');return false">@Ta</a></p>
		<p>时间: {date('Y-m-d H:i',$tMeta.mtime)}</p>
		<p>点击: {$tMeta.read_count}</p>
		<hr>
		<div>{$ubb->display($v.content,true)}</div>
	{else}
		<p>{$tMeta.title|code}</p>
	{/if}
</div>
<hr>

<div>
    {foreach $tContents as $v}
		<div>{$v.floor}. {$ubb->display($v.content,true)}</div>
		<p>(<a href="user.info.{$v.uinfo.uid}.{$BID}">{$v.uinfo.name|code}</a>/<a href="#" onclick="atAdd('{$v.uinfo.name|code}');return false">@Ta</a>/{date('Y-m-d H:i',$v.mtime)})</p>
		<hr>
    {/foreach}
</div>

<div>
    {if $maxPage > 1}
        {if $p > 1}<a href="{$cid}.{$pid}.{$tid}.{$p-1}.{$bid}">上一页</a>{/if}
        {if $p < $maxPage}<a href="{$cid}.{$pid}.{$tid}.{$p+1}.{$bid}">下一页</a>{/if}
		{$p}/{$maxPage}页,共{$contentCount-1}楼
		<input placeholder="跳页" id="page" size="2" onkeypress="if(event.keyCode==13){ location='{$CID}.{$PID}.{$tid}.'+this.value+'.{$BID}'; }">
		<hr>
    {/if}
</div>

<!--回复框-->
<div>
    {if $USER->islogin}
        <form method="post" action="{$CID}.newreply.{$tid}.{$p}.{$BID}">
            <textarea id="content" name="content" style="width:80%;height:100px">{$smarty.post.content}</textarea>
            <input type="hidden" name="token" value="{$token->token()}">
            <p><input type="submit" name="go" value="评论该帖子"></p>
		</form>
    {else}
        回复需要<a href="user.login.{$BID}?u={$PAGE->geturl()|urlencode}">登录</a>。
    {/if}
</div>

{include file="tpl:comm.foot"}