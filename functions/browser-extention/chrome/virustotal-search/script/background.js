chrome.runtime.onInstalled.addListener(() => {
    // 브라우저의 기본 언어 설정 가져오기
    chrome.i18n.getAcceptLanguages((languages) => {
        let userLang = languages[0]; // 사용자의 첫 번째 언어 코드
        let title;

        if (userLang.startsWith("ko")) {
            title = "바이러스토탈에서 '%s' 검색";
        } else if (userLang.startsWith("ja")) {
            title = "「VirusTotalで『%s』を検索」";
        } else {
            title = "Search for '%s' on VirusTotal";
        }

        // 우클릭 메뉴 생성
        chrome.contextMenus.create({
            id: "virusTotalSearch",
            title: title,
            contexts: ["selection"]
        });
    });
});

chrome.contextMenus.onClicked.addListener((info, tab) => {
    if (info.menuItemId === "virusTotalSearch") {
        let query = encodeURIComponent(info.selectionText);
        let url = `https://www.virustotal.com/gui/search/${query}`;
        chrome.tabs.create({ url: url });
    }
});
