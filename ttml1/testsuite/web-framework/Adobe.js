
function Adobe() {
}

Adobe.prototype.name = function() {
    return "Adobe Flash DFXP prototype";
}

Adobe.prototype.startPlayer = function() {
    // nothing needs to be done
}

Adobe.prototype.startTest = function(test_number, filename, autostart, div) {
    var value = "flv=dfxp_movie.flv&cc=" + filename + "&autoplay=" + autostart;
    if (-1 != navigator.userAgent.indexOf("MSIE")) {
	// once again, a workaround for IE :-/
	div.innerHTML =
	    '<OBJECT width="335" height="282" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" '
	    + 'codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0"'
	    + ' type="application/x-shockwave-flash" align="middle">'
	    + '<PARAM name="movie" class="object" value="adobeflashcc.swf"/>'
	    + '<PARAM name="bgcolor" value="#000000"/><PARAM name="allowScriptAccess" value="always"/>'
	    + '<PARAM name="quality" value="high"/><PARAM name="allowFullScreen" value="false"/>'
	    + '<PARAM name="flashvars" value="' + value + '"/>'
	    + '<EMBED width="335" height="282" src="adobeflashcc.swf"'
	    + ' bgcolor="#000000" quality="high" allowFullScreen="false"'
	    + ' flashvars="' + value + '"'
	    + ' pluginspage="http://www.macromedia.com/go/getflashplayer"'
	    + ' type="application/x-shockwave-flash"/></OBJECT>';
    } else {
	div.innerHTML = '';
	// Create the object
	var obj = document.createElement("object");
	obj.setAttribute("classid", "clsid:d27cdb6e-ae6d-11cf-96b8-444553540000");
	obj.setAttribute("codebase", "http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0");
	obj.setAttribute("width", "335");
	obj.setAttribute("height", "282");
	obj.setAttribute("align", "middle");
	obj.setAttribute("type", "application/x-shockwave-flash");
	var p = document.createElement("param");
	p.setAttribute("name", "movie");
	p.setAttribute("value", "adobeflashcc.swf");
	obj.appendChild(p);
	p = document.createElement("param");
	p.setAttribute("name", "bgcolor");
	p.setAttribute("value", "#000000");
	obj.appendChild(p);
	p = document.createElement("param");
	p.setAttribute("name", "allowScriptAccess");
	p.setAttribute("value", "always");
	obj.appendChild(p);
	p = document.createElement("param");
	p.setAttribute("name", "allowFullScreen");
	p.setAttribute("value", "false");
	obj.appendChild(p);
	p = document.createElement("param");
	p.setAttribute("name", "flashvars");
	p.setAttribute("value", value);
	obj.appendChild(p);
	var embed = document.createElement("embed");
	embed.setAttribute("src", "adobeflashcc.swf");
	embed.setAttribute("bgcolor", "#000000");
	embed.setAttribute("width", "335");
	embed.setAttribute("height", "282");
	embed.setAttribute("allowScriptAccess", "always");
	embed.setAttribute("type", "application/x-shockwave-flash");
	embed.setAttribute("flashvars", value);
	embed.setAttribute("align", "middle");
	embed.setAttribute("quality", "high");
	embed.setAttribute("allowFullScreen", "false");
	obj.appendChild(embed);
	
	// append the object
	div.appendChild(obj);
    }

}

Adobe.prototype.stopTest = function(test_number)
{
    // nothing needs to be done
}

Adobe.prototype.stopPlayer = function()
{
    // nothing needs to be done
}

addPlayer(new Adobe());

