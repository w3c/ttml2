
//****************************
// Handling the lists of tests
//****************************


// list of tests
var tests = new Array();

// Some constants to make it easier
var NAME         = 0;
var FILE         = 1;
var DESCRIPTION  = 2;
var CATEGORY     = 3;
var CATEGORY_NUM = 4;

function addTest(filename, name, description, category)
{
    var cat = addCategory(category);
    tests[tests.length] = new Array(name, filename, description, cat);
}

//*********************************
// Handling the lists of categories
//
// each test is attached to one category
//
//*********************************


var categories = new Array();
categories[0] = "All test sets";

var category = 0;

function addCategory(name)
{
    var i = 0;
    while (i < categories.length) {
	if (categories[i] == name) return i;
	i++;
    }
    categories[i] = name;
    return i;
}

function switchCategory(cat)
{
    category = cat;

    var tables = document.getElementById("tables");

    for (var c = 1; c < categories.length; c++ ) {
	if (cat == 0) {
	    tables.childNodes.item(c-1).style.cssText = '';
	} else if (c == category) {
	    // setAttribute("class" or "style" doesn't work in IE :-(
	    tables.childNodes.item(c-1).style.cssText = '';
	} else {
	    // setAttribute("class" or "style" doesn't work in IE :-(
	    tables.childNodes.item(c-1).style.cssText = 'display:none';
	}
    }
    
}

//***************************
// Handling the player to use
//***************************

// list of players
var players = new Array();
// the player in use
var player = -1;
var autostart = false;

// A constant to make it easier to access the array
// var NAME = 0; is already defined
var START_FUNCTION_NAME = 1;
var ACTIVATE_FUNCTION_NAME = 2;
var STOP_FUNCTION_NAME = 3;

function addPlayer(name,
		   startFunctionName,
		   activateFunctionName, 
		   stopFunctionName)
{
    players[players.length] = new Array(name,
					startFunctionName,
					activateFunctionName,
					stopFunctionName);
}


// switch from one player to an other
function switchPlayer(nPlayer) {

    // remove the test currently in use
    clearTestArea();

    // reset the table of pass/fail
    resetAll();

    // reset the report
    var report_content = document.getElementById("report_content");
    report_content.innerHTML = '';

    // switch
    player = nPlayer;

    eval(players[player-1][START_FUNCTION_NAME] + "()");
}

function switchAutostart(nAutostart)
{
    autostart = nAutostart;
}


//***************************
// Handling a test
//***************************

var currentTest = -1;

function source_handler() {
    if (this.readyState == 4
	&& this.status == 200
	&& this.responseText != null) {
	// success!
	var div = document.getElementById('testobject');
	var pre = document.createElement("pre");
	pre.appendChild(document.createTextNode(this.responseText));
	div.appendChild(pre);
    }
}

if (typeof XMLHttpRequest == "undefined" ) {
    // Provide the XMLHttpRequest class for IE 5.x-6.x:
    XMLHttpRequest = function() {
	try { return new ActiveXObject("Msxml2.XMLHTTP.6.0") } catch(e) {}
	try { return new ActiveXObject("Msxml2.XMLHTTP.3.0") } catch(e) {}
	try { return new ActiveXObject("Msxml2.XMLHTTP") } catch(e) {}
	try { return new ActiveXObject("Microsoft.XMLHTTP") } catch(e) {}
	throw new Error( "This browser does not support XMLHttpRequest." )
    };
}

// Display the source of a test
function displayTest(test_number) 
{
    var title=document.getElementById("title");
    var div = document.getElementById('testobject');

    clearTestArea();

    if (test_number > -1 && test_number < tests.length) {
	title.innerHTML = tests[test_number][FILE];
	try {
	    var xhr = new XMLHttpRequest();
	    xhr.onreadystatechange = source_handler;
	    xhr.open("GET", tests[test_number][FILE], true);
	    xhr.send("");
	} catch (e) {
	    div.innerHTML = "<p style='font-weight: bold'>No player selected...</p>";
	}
    }
}

// Run a dedicated test with the appropriate player
function activeTest(test_number) 
{
    var title=document.getElementById("title");
    var descr=document.getElementById("description");

    if (test_number > -1 && test_number < tests.length) {
	title.innerHTML = tests[test_number][NAME];
	descr.innerHTML = tests[test_number][DESCRIPTION];
	if (player == 0) {
	    var div = document.getElementById('testobject');
	    div.innerHTML = '<p><b>Choose a player...</b></p>';	    
	} else {
	    addResultButtons(test_number);
	    
	    eval(players[player-1][ACTIVATE_FUNCTION_NAME] + "("
		 + test_number + ",\""
		 + tests[test_number][FILE] + "\","
		 + autostart
		 + ", document.getElementById('testobject'))");
	}
	currentTest = test_number;
    }
}

// return the next test number to be executed or -1 if none
function nextTestNumber(test_number)
{
    var i = test_number + 1;
    while (i < results.length) {
	if (category == 0 || category == tests[i][CATEGORY]) {
	    return i;
	}
	i++;
    }
    return -1;
}

// stop the current test and move to the next
function moveToNextTest(test_number)
{
    var next = nextTestNumber(test_number);
    if (next == -1) {
	clearTestArea();
    } else {
	stopTest(currentTest);
	activeTest(next);
    }
}

// stop the player if running
function stopTest(test_number)
{
    if (test_number > -1 && test_number < tests.length) {
	if (player > 0) {
	    eval(players[player-1][STOP_FUNCTION_NAME] + "("
		 + test_number + ")");
	    currentTest = -1;
	}
    }
    currentTest = -1;
}

// Remove the current test
// stop the player if running and clear the test area
function clearTestArea()
{
    // first stop the test
    stopTest(currentTest);

    // clean up the HTML elements
    var div = document.getElementById("testobject");
    div.innerHTML = '';
    var title = document.getElementById("title");
    title.innerHTML = "";
    var descr = document.getElementById("description");
    descr.innerHTML = "";
    var p = document.getElementById("result");
    p.innerHTML = "";

}

//************************************
// Handle the fail/pass/unknown status
//************************************

var results = new Array();

var skipOnResult = false;

// Some constants to make it easier to access the array
var UNKNOWN = 0;
var PASS    = 1;
var FAIL    = 2;
var CANT_TELL = 3;

function initResults()
{
    for (i = 0; i < tests.length; i++) {
	results[i] = UNKNOWN;
    }
}

// reset the table of pass/fail
function addResultButtons(test_number)
{
    var p = document.getElementById("result");
    s =
	"<input value='Pass' type='button' onclick='pass(" + test_number 
	+ ");'> <input type='button' value='Fail' onclick='fail("
	+ test_number + ");'> <input type='button' value='Cannot tell' onclick='cant_tell("
	+ test_number + ");'>";
    if (skipOnResult) {
	s += " <input value='Skip' type='button' onclick='skip(" + test_number 
	    + ");'>";
    }
    p.innerHTML = s;
}

function switchSkipOnResult(nSkip)
{
    skipOnResult = nSkip;
}

function setResultElement(e, result)
{
    var s = '';
    if (result == PASS) {
	s = 'pass';
    } else if (result == FAIL) {
	s = 'fail';
    } else if (result == CANT_TELL) {
	s = "cannot tell";
    }
    if (result != UNKNOWN) {
	e.innerHTML = s;
	e.setAttribute('className', s);    
	e.setAttribute('class', s);    
    }
}

// indicate that the test was passed
function pass(test_number)
{
    var e = document.getElementById("r" + test_number);
    setResultElement(e, PASS);

    results[test_number] = PASS;

    if (skipOnResult) {
	moveToNextTest(test_number);
    }
}

// indicate that the test was failed
function fail(test_number)
{
    var e = document.getElementById("r" + test_number);
    setResultElement(e, FAIL);

    results[test_number] = FAIL;

    if (skipOnResult) {
	moveToNextTest(test_number);
    }
}

// can't tell if the test was passed or failed
function cant_tell(test_number)
{
    var e = document.getElementById("r" + test_number);
    setResultElement(e, CANT_TELL);

    results[test_number] = CANT_TELL;
    if (skipOnResult) {
	moveToNextTest(test_number);
    }
}

// Just skip the test and move to next
function skip(test_number)
{
    moveToNextTest(test_number);
}

// reset the table of pass/fail/can't tell
function resetAll()
{
    for (i = 0; i < tests.length; i++) {
	var e = document.getElementById("r" + i);
	e.innerHTML = '';
	e.removeAttribute('className');
	e.removeAttribute('class');
	// don't forget to clear the results array as well
	results[i] = UNKNOWN;
    }    
}

//*******************************************
// Generate a report of all pass/fail/unknown
//*******************************************

function getFlashPlayerVersion()
{    
    if (navigator.plugins && navigator.mimeTypes.length) {
        var plugin = navigator.plugins["Shockwave Flash"];
        if (plugin && plugin.description) {
            return plugin.description.replace(/([a-zA-Z]|\s)+/, "").replace(/(\s+r|\s+b[0-9]+)/, ".").split(".");
        }
    }
    return [0, 0, 0];
}

function report()
{
    var pass      = new Array();
    var fail      = new Array();
    var cant_tell = new Array();

    for (i = 0; i < results.length; i++) {
	if (results[i] == PASS) {
	    pass[pass.length] = i;
	} else if (results[i] == FAIL) {
	    fail[fail.length] = i;
	} else if (results[i] == CANT_TELL) {
	    cant_tell[cant_tell.length] = i;
	}
    }
    var total = pass.length+fail.length+cant_tell.length;

    var report_content = document.getElementById("report_content");
    report_content.innerHTML = '';

    if (player == 0 || total == 0) {
	if (player == 0) {
	    var p = document.createElement("p");	    
	    p.innerHTML = "Choose a player.";
	    report_content.appendChild(p);
	}
	if (total == 0) {
	    var p = document.createElement("p");	    
	    p.innerHTML = "Report some results.";
	    report_content.appendChild(p);
	}
	return;
    }


    var p = document.createElement("p");


    p.innerHTML = new Date().toUTCString();
    report_content.appendChild(p);

    p = document.createElement("p");
    p.innerHTML = "DFXP Player: " + players[player-1][NAME];
    report_content.appendChild(p);
    
    var version = getFlashPlayerVersion();
    p = document.createElement("p");
    p.innerHTML = "Shockwave Flash: " + version[0] + "." + version[1] + " r" + version[2];
    report_content.appendChild(p);
    
    p = document.createElement("p");
    p.innerHTML = "Navigator: " + navigator.userAgent;
    report_content.appendChild(p);

    p = document.createElement("p");
    p.innerHTML = total	+ " test result" 
	+ ((total==0)?"":"s")
	+ " collected out of " + tests.length + " tests.";
    report_content.appendChild(p);
    if (total != 0) {
	if (pass.length != 0) {
	    p = document.createElement("p");
	    var s = '';
	    for (i = 0; i<pass.length; i++) {
		if (s != '') {
		    s += ', ';
		}
		s += tests[pass[i]][NAME];
	    }
	    p.innerHTML = pass.length + " test"
		+ ((pass.length>1)?"s":"") + " passed: " + s + ".";
	    report_content.appendChild(p);
	}
	if (fail.length != 0) {
	    p = document.createElement("p");
	    s = '';
	    for (i = 0; i<fail.length; i++) {
		if (s != '') {
		    s += ', ';
		}
		s += tests[fail[i]][NAME];
	    }
	    p.innerHTML = fail.length + " test" 
		+ ((fail.length>1)?"s ":" ") + " failed:" + s + ".";
	    report_content.appendChild(p);
	}
	if (cant_tell.length != 0) {
	    p = document.createElement("p");
	    s = '';
	    for (i = 0; i<cant_tell.length; i++) {
		if (s != '') {
		    s += ', ';
		}
		s += tests[cant_tell[i]][NAME];
	    }
	    p.innerHTML = cant_tell.length + " test" 
		+ ((cant_tell.length>1)?"s ":" ") + " cannot tell:" + s + ".";
	    report_content.appendChild(p);
	}
    }
}

//*************************************************
// handle the selection of a category or the report
//*************************************************

function handleSelection(index)
{
    var r = document.getElementById("report");
    clearTestArea();
    if (index == categories.length) {
	switchCategory(-1);
	report();
	// setAttribute("class" or "style" doesn't work in IE :-(
	r.style.cssText = '';
    } else {
	// setAttribute("class" or "style" doesn't work in IE :-(
	r.style.cssText = 'display:none';
	switchCategory(index);
    }
}

//********************************************
// onClick handler to display the tests
//********************************************
function onClickHandlerDisplayTest() {
    displayTest(parseInt(this.getAttribute("test")));
}
//********************************************
// onClick handler to activate the tests
//********************************************
function onClickHandlerActiveTest() {
    activeTest(parseInt(this.getAttribute("test")));
}

//********************************************
// init():
// - initialize the results
// - build player list
// - initialize the player
// - build category list
// - build test table
// - initialize skipOnResult and autostart
//********************************************

function init() {
    if (!(document.implementation
	  && document.implementation.hasFeature)) {
	// no DOM support :-(
	return;
    }

    initResults();

    // populate the player list
    var select = document.getElementById("players");

    var opt = document.createElement("option");
    opt.innerHTML = "Choose a player";
    select.appendChild(opt);
    for (i=0; i < players.length; i++) {
	opt = document.createElement("option");
	opt.innerHTML = players[i][NAME];
	select.appendChild(opt);
    }
    if (players.length > 0) {
	player = 0;
    }

    // populate the category list
    var select = document.getElementById("categories");

    for (i=0; i < categories.length; i++) {
	opt = document.createElement("option");
	opt.innerHTML = categories[i];
	select.appendChild(opt);
    }
    opt = document.createElement("option");
    opt.innerHTML = "See the report";
    select.appendChild(opt);

    var tables = document.getElementById("tables");
    var isRemote = false;
    if (document.URL.substring(0, 5) == "http:") {
	isRemote = true;
    }

    for (c=categories.length-1; c>=1;c--) {
	var div = document.createElement("div");
	div.setAttribute("className", "table");
	div.setAttribute("class", "table");
	div.setAttribute("id", "cat" + c);
	var h3 = document.createElement("h3");
	h3.innerHTML = "Test set: " + categories[c];
	div.appendChild(h3);
	// populate the HTML table with the tests
	var table = document.createElement("table");
	// don't forget to add a tbody element for IE!
	var tbody = document.createElement("tbody");
	table.setAttribute("id", "tcat" + c);
	for (i=0; i < tests.length; i++) {
	    if (c == tests[i][CATEGORY]) {
		var tr = document.createElement("tr");
		var th = document.createElement("th");
		var b = document.createElement("input");
		b.setAttribute("type", "button");
		// b.setAttribute("onclick", "activeTest(i)"); doesn't work on IE :-(
		// so here is a workaround
		b.setAttribute("test", (i).toString(10));
		b.onclick = onClickHandlerActiveTest;
		b.setAttribute("value", tests[i][NAME]);
		th.appendChild(b);
		tr.appendChild(th);
		td = document.createElement("td"); // for the source
		if (!isRemote) {
		    var a = document.createElement("a");
		    a.setAttribute("href", tests[i][FILE]);
		    a.innerHTML = "[source]";
		    td.appendChild(a);
		} else {
		    var span = document.createElement("span");
		    span.setAttribute("test", (i).toString(10));
		    span.onclick = onClickHandlerDisplayTest;
		    span.innerHTML = "[source]";
		    td.appendChild(span);		    
		}
		tr.appendChild(td);
		td = document.createElement("td"); // for the result
		td.setAttribute("id", "r" + i);
		tr.appendChild(td);
		tbody.appendChild(tr);
		table.appendChild(tbody);
	    }
	}
	div.appendChild(table);
	tables.insertBefore(div, tables.firstChild);
    }
    handleSelection(0);

    // initialize skipOnResult
    var nSkipOnResult = document.getElementById("skipOnResult").checked;
    switchSkipOnResult(nSkipOnResult);

    // initialize autostart
    var nAutostart = document.getElementById("autostart").checked;
    switchAutostart(nAutostart);
}
