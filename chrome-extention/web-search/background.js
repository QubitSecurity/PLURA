chrome.runtime.onInstalled.addListener(() => {
    chrome.contextMenus.create({
        id: "virusTotalSearch",
        title: "바이러스토탈에서 '%s' 검색",
        contexts: ["selection"]
    });
});

chrome.contextMenus.onClicked.addListener((info, tab) => {
    if (info.menuItemId === "virusTotalSearch") {
        let query = encodeURIComponent(info.selectionText);
        let url = `https://www.virustotal.com/gui/search/${query}`;
        chrome.tabs.create({ url: url });
    }
});
