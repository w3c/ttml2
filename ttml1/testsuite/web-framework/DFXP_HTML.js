function DFXPHTML() {
}

// The name of your player.

DFXPHTML.prototype.name = function () {
  return "HTML5 DFXP Player prototype";
}

DFXPHTML.prototype.startPlayer = function() {
    //    if (-1 == navigator.userAgent.indexOf("Firefox/3.1") &&
    //        -1 == navigator.userAgent.indexOf("Shiretoko/3.1")) {
    //	alert("This player only works in Firefox 3.1.");
    //    }
}

var DFXPHTML_video = null;

DFXPHTML.prototype.startTest = function(test_number, filename, autostart, div) {

	div.innerHTML = '';
	// Create the object
	var obj = document.createElement("video");
	obj.setAttribute("width", "320px");
	obj.setAttribute("src", "dfxp_movie.ogv");
	obj.setAttribute("controls", "true");
	if (autostart) {
	    obj.setAttribute("autoplay", "true");
	}
	
	// append the object
	div.appendChild(obj);

	var xhr = new XMLHttpRequest();

	xhr.onreadystatechange = function () {
	    if (this.readyState == 4
		&& this.status == 200) {
		
		if (this.responseXML != null) {
		    HTML5Caption_playDFXP(this.video, this.responseXML);
		} else {
		    throw new Error("Can't read DFXP resource");
		}
	    }
	};
	xhr.video = obj;

	xhr.open("GET", filename, true);
	xhr.send("");
}

DFXPHTML.prototype.stopTest = function(test_number)
{
}

DFXPHTML.prototype.stopPlayer = function()
{
}
    
addPlayer(new DFXPHTML());

