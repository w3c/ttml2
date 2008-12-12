/*
 * Based on jQuery srt
   http://v2v.cc/~j/jquery.srt/

  usage:
    <video src="example.movie" id="video" controls>
      <text lang='en' type="application/ttaf+xml" src="testsuite/Content/Br001.xml"></text>
    </video>

  license:
    You can do whatever you want with this code, except for the playSRT function
    See the jQuery srt license for playSRT function at
      http://v2v.cc/~j/jquery.srt/
*/

if (typeof XMLHttpRequest == "undefined" ) {
    // Provide the XMLHttpRequest class for IE 5.x-6.x:
    XMLHttpRequest = function() {
	try { return new ActiveXObject("Microsoft.XMLHTTP") } catch(e) {}
	try { return new ActiveXObject("Msxml2.XMLHTTP.6.0") } catch(e) {}
	try { return new ActiveXObject("Msxml2.XMLHTTP.3.0") } catch(e) {}
	try { return new ActiveXObject("Msxml2.XMLHTTP") } catch(e) {}
	throw new Error( "This browser does not support XMLHttpRequest." )
    };
}

HTML5Caption_toSeconds = function(t) {
    var s = 0.0;
    if(t) {
	var p = t.split(':');
	for(i=0;i<p.length;i++)
	    s = s * 60 + parseFloat(p[i].replace(',', '.'));
    }
    return s;
}
    
HTML5Caption_strip = function(s) {
   return s.replace(/^\s+|\s+$/g,"");
}

HTML5Caption_playSRT = function(video, srt) {    

    srt = srt.replace('\r\n|\r|\n', '\n');
	
    var subtitles = {};
    srt = HTML5Caption_strip(srt);
    var srt_ = srt.split('\n\n');
    for(s in srt_) {
	st = srt_[s].split('\n');
	if(st.length >=2) {
	    n = st[0];
	    i = strip(st[1].split(' --> ')[0]);
	    o = strip(st[1].split(' --> ')[1]);
	    t = st[2];
	    if(st.length > 2) {
		for(j=3; j<st.length;j++)
		    t += '\n'+st[j];
	    }
	    is = HTML5Caption_toSeconds(i);
	    os = HTML5Caption_toSeconds(o);
	    subtitles[is] = {i:is, o: os, t: t};
	}
    }
    var currentSubtitle = -1;

    // create the subtitle area
    var div = document.createElement("div");
    div.className = 'srt';
    video.parentNode.insertBefore(div, video.nextSibling);

    var currentTime = video.currentTime;

    if (typeof currentTime == "undefined") {
	throw new Error("currentTime is not supported by the Video element");
    } else {
	var ival = setInterval(function() {
		var currentTime = video.currentTime;
		var subtitle = -1;
		for (s in subtitles) {
		    if (s > currentTime)
			break;
		    subtitle = s;
		}
		if (subtitle != -1) {
		    if (subtitle != currentSubtitle) {
			div.innerHTML = subtitles[subtitle].t;
			currentSubtitle=subtitle;
		    } else if (subtitles[subtitle].o < currentTime) {
			div.innerHTML = '';
		    }
		}
	    }, 100);
    }
}

var DFXP = "http://www.w3.org/2006/10/ttaf1";
var DFXP_TTS = "http://www.w3.org/2006/10/ttaf1#style";

HTML5Caption_transDFXPAttributes = function(dp, ht) {
    var v;
    v = dp.getAttribute("style");

    if (v != null) {
	// @@TODO v is an IDREFS!
	var el = dp.ownerDocument.getElementById(v);
	
	if (el == null) {
	    // getElementById doesn't work, let's try something else
	    var styles = dp.ownerDocument.getElementsByTagNameNS(DFXP, "style");

	    for (var i = 0; i < styles.length; i++) {
		var s = styles.item(i);
		var id = s.getAttribute("xml:id");
		if (id == v) {
		    el = s;
		    break;
		}
	    }
	}
	if (el != null) {
	    HTML5Caption_transDFXPAttributes(el, ht);	    
	} else {
            // the DFXP is invalid. Should fail silently in the future
	    alert("can't find " + v);
	}
    }
    v = dp.getAttributeNS(DFXP_TTS, "backgroundColor");
    if (v != "") {
	ht.style.setProperty("background-color", v, "");
    }
    v = dp.getAttributeNS(DFXP_TTS, "color");
    if (v != "") {
	ht.style.setProperty("color", v, "");
    }
    v = dp.getAttributeNS(DFXP_TTS, "direction");
    if (v != "") {
	ht.style.setProperty("direction", v, "");
    }
    v = dp.getAttributeNS(DFXP_TTS, "display");
    if ((v == "") || (v == "auto")) {
	if (ht.tagName == "SPAN") {
	    v = "inline";
	} else {
	    v = "block";
	}
    }
    ht.df_displayValue = v;

    v = dp.getAttributeNS(DFXP_TTS, "fontFamily");
    if (v != "") {
	ht.style.setProperty("font-family", v, "");
    }
    v = dp.getAttributeNS(DFXP_TTS, "fontSize");
    if (v != "") {
	ht.style.setProperty("font-size", v, "");
    }
    v = dp.getAttributeNS(DFXP_TTS, "fontStyle");
    if (v != "") {
	ht.style.setProperty("font-style", v, "");
    }
    v = dp.getAttributeNS(DFXP_TTS, "fontWeight");
    if (v != "") {
	ht.style.setProperty("font-weight", v, "");
    }
    v = dp.getAttributeNS(DFXP_TTS, "lineHeight");
    if (v != "") {
	ht.style.setProperty("line-height", v, "");
    }
    v = dp.getAttributeNS(DFXP_TTS, "opacity");
    if (v != "") {
	ht.style.setProperty("opacity", v, "");
    }
    v = dp.getAttributeNS(DFXP_TTS, "padding");
    if (v != "") {
	ht.style.setProperty("padding", v, "");
    }
    v = dp.getAttributeNS(DFXP_TTS, "textAlign");
    if (v != "") {
	// REVISIT to take into account text direction...
	if (v == "start") {
	    ht.style.setProperty("text-align", "left", "");
	} else if (v == "end") {
	    ht.style.setProperty("text-align", "right", "");
	} else {
	    ht.style.setProperty("text-align", v, "");
	}
    }
    v = dp.getAttributeNS(DFXP_TTS, "textDecoration");
    if (v != "") {
	if (v == "noUnderline" || v == "noOverline" || v == "noLineThrough") {
	    // this is not accurate
	    v = "none";
	} else if (v == "lineThrough") {
	    v = "line-through";
	}
	ht.style.setProperty("text-decoration", v, "");
    }
    v = dp.getAttributeNS(DFXP_TTS, "unicodeBidi");
    if (v != "") {
	if (v == "bidiOverride") {
	    v = "bidy-override";
	}
	ht.style.setProperty("unicode-bidi", v, "");
    }
    v = dp.getAttributeNS(DFXP_TTS, "visibility");
    if (v != "") {
	ht.style.setProperty("visibility", v, "");
    }
    v = dp.getAttribute("xml:space");
    if (v != "") {
	if (v == "preserve") {
	    v = "pre";
	    ht.spaces = true;
	} else {
	    v = "normal";
	}
	ht.style.setProperty("white-space", v, "");
    }
}

HTML5Caption_transDFXPElement = function(dp) {
    if (dp != null) {	
	if (dp.nodeType == 3) {
	    return document.createTextNode(dp.data);
	} else if (dp.nodeType == 1) {
	    var n = null;
	    if (dp.localName == "span") {
		n = document.createElement("span");
	    } else if (dp.localName == "p") {
		n = document.createElement("p");
	    } else if (dp.localName == "br") {
		n = document.createElement("br");
	    }
	    if (n!= null) {
		HTML5Caption_transDFXPAttributes(dp, n);
		var child = dp.firstChild;
		while (child!= null) {
		    var r = HTML5Caption_transDFXPElement(child);
		    if (r!= null) {
			n.appendChild(r);
		    }
		    child=child.nextSibling;
		}
	    }
	    return n;
	}
    }
    return null;
}

HTML5Caption_convertDFXPDuration = function(d) {
    var i = 0;
    if (d.indexOf(':') != -1) {
	return HTML5Caption_toSeconds(d);
    } else if ((i = d.indexOf('h')) != -1) {
	return parseFloat(d.substring(0, i)) * 3600;
    } else if ((i = d.indexOf('m')) != -1) {
	return parseFloat(d.substring(0, i)) * 60;
    } else if ((i = d.indexOf('s')) != -1) {
	return parseFloat(d.substring(0, i));
    } else if ((i = d.indexOf('ms')) != -1) {
	return parseFloat(d.substring(0, i)) / 1000;
    } else if ((i = d.indexOf('t')) != -1) {
	throw new Error("tick duration is not supported");
    } else if ((i = d.indexOf('f')) != -1) {
	throw new Error("frame duration is not supported");
    }
}

HTML5Caption_ParentStyle = function(parent, ht) {
    if (parent != null) {
	if (parent.parentNode == null) {
	    // nothing
	} else if (parent.parentNode.localName == "div") {
	    HTML5Caption_ParentStyle(parent.parentNode, ht);
	} else if (parent.parentNode.localName == "body") {
	    HTML5Caption_ParentStyle(parent.parentNode, ht);
	} else if (parent.parentNode.localName == "tt") {
	    HTML5Caption_ParentStyle(parent.parentNode, ht);
	}
	HTML5Caption_transDFXPAttributes(parent, ht);
    }
    
}

HTML5Caption_playDFXP = function(video, dfxp) {    

    // @@grabing all paragraph elements. ugly but effective so far...
    // wouldn't work with WGBH files with multiple languages
    // REVISIT
    var paras = dfxp.getElementsByTagNameNS(DFXP, "p");

    if (paras.length == 0) {
        // fail silently in the future
	alert("No paragraph in DFXP?!?");
	return;
    }

    // create the subtitle area
    // mainDiv is here to prevent the DFXP style from messing up with
    // with the main container. mainDiv represents the body
    // element of DFXP
    var mainDiv = document.createElement("div");
    mainDiv.className = 'dfxp';
    var w = video.getAttribute("width");
    if (w!="") {
	// the main container gets the size of the video
	mainDiv.style.setProperty("width", w, "");
    }
    var div = document.createElement("div");

    HTML5Caption_ParentStyle(paras.item(0).parentNode, div);
    div.style.display = div.displayValue;

    // initialize the subtitles
    for (var i = 0; i < paras.length; i++) {
	var p = paras.item(i);

	var begin   = p.getAttribute("begin");
	var end     = p.getAttribute("end");
	var dur     = p.getAttribute("dur");
	var element = HTML5Caption_transDFXPElement(p);
	var sbegin  = -1;
	var send    = -1;

	// TODO: take into account the timeContainers

	if (div.spaces && div.spaces == true) {
	    // work around the inheritance ?
	    // cf tt002.xml
	    element.style.setProperty("white-space", "pre", "");
	}
	if (begin != null && end != null) {
	    sbegin=HTML5Caption_convertDFXPDuration(begin);
	    send=HTML5Caption_convertDFXPDuration(end);
	} else if (begin != null && dur != null) {
	    sbegin=HTML5Caption_convertDFXPDuration(begin);
	    send=sbegin + HTML5Caption_convertDFXPDuration(dur);
	} else if (begin != null) {
	    sbegin=HTML5Caption_convertDFXPDuration(begin);
	    var next = paras.item(i+1);
	    send = 10000000;
	    if (next != null) {
		var nbegin=next.getAttribute("begin");
		if (nbegin!= null) {
		    send= HTML5Caption_convertDFXPDuration(nbegin);
		}
	    }
	}
	if (sbegin != -1) {
	    element.df_begin         = sbegin;
	    element.df_end           = send;	    
	    element.style.display = "none";
	    element.df_isInTime      = false;
	    div.appendChild(element);
	}
    }

    mainDiv.appendChild(div);

    video.parentNode.insertBefore(mainDiv, video.nextSibling);

    var currentTime = video.currentTime;

    if (typeof currentTime == "undefined") {
	throw new Error("currentTime is not supported by the Video element");
    } else {
	setInterval(function() {
		if (!video.paused) {
		    var currentTime = video.currentTime;
		    var nodes = div.childNodes;
		    var length = nodes.length;
		    for (var i = 0; i < length; i++) {
			node = nodes.item(i);
			// this might get slow if too many subtitles?
			if (node.df_isInTime) {
			    if (node.df_end < currentTime
				|| node.df_begin > currentTime)  {
				// remove the element from the display since
				// it's in a node in the past or future
				node.style.display = "none";
				node.df_isInTime = false;
			    }
			} else if (node.df_begin < currentTime 
				   && node.df_end > currentTime) {
			    node.style.display = node.df_displayValue;
			    node.df_isInTime = true;
			}			    
		    }
		}
	    }, 100);
    }
}


HTML5Caption_playVideo = function(video, caption) {
    var xhr = new XMLHttpRequest();
    var type = caption.getAttribute("type");
    
    if (type == "application/ttaf+xml") {
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
    } else if (type == "text/x-srt") {
	xhr.onreadystatechange = function () {
	    if (this.readyState == 4
		&& this.status == 200) {
		if (this.responseText != null) {
		    // success!
		    HTML5Caption_playSRT(this.video, this.responseText);
		} else {
		    throw new Error("Can't read DFXP resource");
		}
	    }
	};
    } else {
	throw new Error("Caption format not supported");
    }
    xhr.video = video;

    xhr.open("GET", caption.getAttribute("src"), true);
    xhr.send("");
}




function init_captions() {
    var textElements = document.getElementsByTagName("text");
    var srtElement = null;
    var dfxpElement = null;

    for (var i = 0; i < textElements.length; i++) {
	var e = textElements.item(i);
	var type = e.getAttribute("type");
	// @@ should take into account @lang
	if (type == "application/ttaf+xml" && e.getAttribute("src")) {
	    dfxpElement = e;
	} else if (type == "text/x-srt" && e.getAttribute("src")) {
	    srtElement = e;
	}
    }

    if (dfxpElement != null) {
	HTML5Caption_playVideo(dfxpElement.parentNode, dfxpElement);
    } else if (srtElement != null) {
	HTML5Caption_player.playVideo(srtElement.parentNode, srtElement);
    }
}


