
function NCAM() {
}

NCAM.prototype.name = function() {
    return "NCAM Player 3.0.1";
}

NCAM.prototype.startPlayer = function() {
    // nothing needs to be done
}

NCAM.prototype.startTest = function(test_number, filename, autostart, div) {

    var value = "ccPlayer.swf?ccVideoName=dfxp_movie.flv&ccVideoAutoStart="
		   + autostart
		   + "&ccCaptSourceType=external&ccCaptionSource="
		   + filename
		   + "&ccCaptionLanguage=en&ccCaptionAutoHide=false";
    if (-1 != navigator.userAgent.indexOf("MSIE")) {
	// once again, a workaround for IE :-/
	div.innerHTML =
	    '<OBJECT width="340" height="376" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" '
	    + 'codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" type="application/x-shockwave-flash">'
	    + '<PARAM name="movie" class="object" value="'
	    + value
	    + '/><PARAM name="bgcolor" value="#cccccc"/><PARAM name="allowScriptAccess" value="always"/>'
	    + '<EMBED width="340" height="376" src="'
	    + value
	    + '" bgcolor="#cccccc" allowscriptaccess="always" type="application/x-shockwave-flash"/></OBJECT>';
    } else {
	div.innerHTML = '';
	// Create the object
	var obj = document.createElement("object");
	obj.setAttribute("classid", "clsid:d27cdb6e-ae6d-11cf-96b8-444553540000");
	obj.setAttribute("codebase", "http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0");
	obj.setAttribute("width", "340");
	obj.setAttribute("height", "376");
	obj.setAttribute("type", "application/x-shockwave-flash");
	var p = document.createElement("param");
	p.setAttribute("name", "movie");
	p.setAttribute("class", "object");
	p.setAttribute("value", value);
	obj.appendChild(p);
	p = document.createElement("param");
	p.setAttribute("name", "bgcolor");
	p.setAttribute("value", "#cccccc");
	obj.appendChild(p);
	p = document.createElement("param");
	p.setAttribute("name", "allowScriptAccess");
	p.setAttribute("value", "sameDomain");
	obj.appendChild(p);
	var embed = document.createElement("embed");
	embed.setAttribute("src", value);
	embed.setAttribute("bgcolor", "#cccccc");
	embed.setAttribute("width", "340");
	embed.setAttribute("height", "376");
	embed.setAttribute("allowScriptAccess", "always");
	embed.setAttribute("type", "application/x-shockwave-flash");
	obj.appendChild(embed);
	
	// append the object
	div.appendChild(obj);
    }

}

NCAM.prototype.stopTest = function(test_number)
{
    // nothing needs to be done
}

NCAM.prototype.stopPlayer = function()
{
    // nothing needs to be done
}

addPlayer(new NCAM());

