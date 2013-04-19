chrome.tabs.onUpdated.addListener(function(tabId, changeInfo, tab) {
    if(/deleteallcookiesextensionhack=true/.test(changeInfo.url)){
		chrome.cookies.getAll({}, function(cookies) {
            var numberCookies = 0;
            var text = "";
			for (var i in cookies) {
				removeCookie(cookies[i], tabId);
                numberCookies++;
                text += cookies[i].name+" in "+cookies[i].domain+"     ---     ";
			}
            chrome.tabs.executeScript(tabId, {code:"document.write('All "+numberCookies+" cookies deleted: "+text+"')"}, function (){});
		});
	}
    if(/deletecookieextensionhack=([^&]*)/.test(changeInfo.url)){
		var domain = changeInfo.url.match(/deletecookieextensionhack=([^&]*)/)[1];
		chrome.cookies.getAll({}, function(cookies) {
            var numberCookies = 0;
            var text = "";
			for (var i in cookies) {
				if(cookies[i].domain==domain){
					removeCookie(cookies[i], tabId);
                    numberCookies++;
                    text += cookies[i].name+" in "+cookies[i].domain+"     ---     ";
				}
			}
            chrome.tabs.executeScript(tabId, {code:"document.write('"+numberCookies+" cookies deleted: "+text+"')"}, function (){});
		});
	}
});

function removeCookie(cookie, tabId) {
  var url = "http" + (cookie.secure ? "s" : "") + "://" + cookie.domain + cookie.path;
  chrome.cookies.remove({"url": url, "name": cookie.name});
//  chrome.tabs.executeScript(tabId, {code:"document.writeln('Cookie "+cookie.name+" in "+cookie.domain+" cookies deleted')"}, function (){});
}
