// Display a video with the specified DFXP captioning document

function JWP() {
}

JWP.prototype.name = function() {
    return "JW FLV Media Player 4.6";
}

JWP.prototype.startPlayer = function ()
{
    if (document.URL.substring(0, 5) != "http:") {
	alert("Note that the "
	      + this.name()
	      + " only works properly when accessing captioning files from a web server.");
    }
}

JWP.prototype.startTest = function (test_number, filename, autostart, div) 
{

    div.innerHTML = '';

    // @@ to be replaced with more appropriate code...
    var embed = document.createElement("embed");
    embed.setAttribute("src", "player.swf");
    embed.setAttribute("flashvars", 
		       "bufferlength=5&file=dfxp_movie.flv&plugins=captions-1&captions.file=" 
		       + filename
		       + "&autostart="
		       + autostart);
    embed.setAttribute("seamlesstabbing", "true");
    embed.setAttribute("bgcolor", "white");
    embed.setAttribute("width", "340");
    embed.setAttribute("height", "376");
    embed.setAttribute("align", "middle");
    embed.setAttribute("allowScriptAccess", "always");
    embed.setAttribute("type", "application/x-shockwave-flash");

    // append the object
    div.appendChild(embed);
}

JWP.prototype.stopTest = function (test_number) 
{
}

JWP.prototype.stopPlayer = function ()
{
    // nothing can be done
}

addPlayer(new JWP());
