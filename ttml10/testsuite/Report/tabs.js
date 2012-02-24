var W3C = {
    init: function(menu, tabs) 
    {
	W3C.TabSet = new Array();

	W3C.Tab = function(menu, tab)
	{
	    this.menu = menu;
	    this.tab = tab;
	}

	var p = document.getElementById(tabs);
	var _tabs = new Array();

	for (n = p.firstChild; n != null; n = n.nextSibling) {
	    if (n.nodeType == 1) {
		_tabs[_tabs.length] = n;
	    }
	}    
	p = document.getElementById(menu);
	p.style.cssText = '';
	var i = 0;
	for (n = p.firstChild; n != null; n = n.nextSibling) {
	    if (n.nodeType == 1) {
		W3C.TabSet[W3C.TabSet.length] = new W3C.Tab(n, _tabs[i]);
		n._TABS_item = i;
		n.onclick = W3C.showTab;
		i++;	    
	    }
	}    
	var selectedTab = window.location.hash.replace('#', '');

	var item = -1;
	if (selectedTab != "undefined" && selectedTab) {
	    for (i = 0; i < W3C.TabSet.length; i++) {
		var id = W3C.TabSet[i].tab.getAttribute("id");
		if (selectedTab == id) {
		    item = i;
		}
	    }
	}    
	if (item != -1) {
	    W3C.showTabItem(item);
	} else {
	    W3C.showTab();
	}
    },
    
    showTabItem: function(item)
    {
	for (i = 0; i < W3C.TabSet.length; i++) {
	    if (i == item) {
		W3C.TabSet[i].tab.style.cssText = '';
		W3C.TabSet[i].menu.className = 'selected';
	    } else {
		W3C.TabSet[i].tab.style.cssText = 'display:none';
		W3C.TabSet[i].menu.className = 'not_selected';
	    }
	}    
    },

    showTab: function()
    {
	var item = this._TABS_item;
	if (item == "undefined" || !item) {
	    item = 0;
	}
	var id = W3C.TabSet[item].tab.getAttribute("id");
	//	window.location.hash = "#" + id;
	W3C.showTabItem(item);

    }
}
