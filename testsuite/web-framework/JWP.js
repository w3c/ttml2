// Display a video with the specified DFXP captioning document

var JWP_NAME = "JW FLV Media Player 4.2";

addPlayer(JWP_NAME, "startJWPPlayer", "activeJWPTest", "stopJWPTest", "stopJWPPlayer");

function startJWPPlayer()
{
    if (document.URL.substring(0, 5) != "http:") {
	alert("Note that the "
	      + JWP_NAME
	      + " only works properly when accessing captioning files from a web server.");
    }
}

function activeJWPTest(test_number, filename, autostart, div) 
{

    div.innerHTML = '';

    // @@ to be replaced with more appropriate code...
    var embed = document.createElement("embed");
    embed.setAttribute("src", "player.swf");
    embed.setAttribute("flashvars", 
		       "bufferlength=5&file=dfxp_movie.flv&captions=" 
		       + filename
		       + "&mute=true&plugins=accessibility&autostart="
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

function stopJWPTest(test_number) 
{
}

function stopJWPPlayer()
{
    // nothing can be done?
}