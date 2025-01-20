크롬 브라우저의 **컨텍스트 메뉴(오른쪽 클릭 메뉴)** 에 **"바이러스토탈에서 검색"** 옵션을 추가하려면 **Chrome 확장 프로그램**을 제작 및 등록 방법

---

## 1️⃣ **Chrome 확장 프로그램 설치 및 테스트** 
1. PLURA 확장 프로그램 다운로드 [👉](web-search/)
2. PLURA 폴더에 3가지 파일 옮기기

3. **Chrome 브라우저에서 `chrome://extensions/`로 이동**
4. **"개발자 모드" 활성화**
5. **"압축 해제된 확장 프로그램 로드" 버튼 클릭**
6. **PLURA 폴더를 선택**하여 확장 프로그램을 추가

이제 **텍스트를 선택하고 오른쪽 클릭하면 "바이러스토탈에서 검색" 옵션이 추가**됩니다.  
클릭하면 **VirusTotal 검색 페이지**가 열립니다. 🚀

---

## 2️⃣ **Chrome 확장 프로그램 기본 구성**
확장 프로그램을 만들기 위해 다음 3가지 파일을 준비합니다.

- `manifest.json` (확장 프로그램 정보)
- `background.js` (백그라운드 스크립트)
- `content.js` (웹 페이지에서 실행되는 스크립트)

---

### 📌 **1. `manifest.json` (확장 프로그램 설정 파일)**
먼저 `manifest.json`을 생성하고 다음 내용을 추가하세요.

```json
{
  "manifest_version": 3,
  "name": "VirusTotal Search",
  "version": "1.0",
  "description": "우클릭 메뉴에서 선택한 텍스트를 VirusTotal에서 검색합니다.",
  "permissions": [
    "contextMenus",
    "activeTab",
    "storage"
  ],
  "background": {
    "service_worker": "background.js"
  },
  "icons": {
    "16": "icon.png",
    "48": "icon.png",
    "128": "icon.png"
  }
}
```

> **설명**
> - `"permissions"`: `contextMenus`를 사용하여 우클릭 메뉴를 추가할 수 있도록 설정
> - `"background"`: 백그라운드 스크립트 실행 (우클릭 감지)

### 📌 **2. `background.js` (우클릭 메뉴 추가)**
이제 `background.js` 파일을 만들어 우클릭 메뉴에서 VirusTotal 검색을 추가합니다.

```javascript
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
```

> **설명**
> - `chrome.contextMenus.create`: 우클릭 메뉴에 **"바이러스토탈에서 검색"** 추가
> - `chrome.contextMenus.onClicked`: 클릭 시 선택한 텍스트를 바이러스토탈 검색 페이지로 전송

---

### 📌 **3. 아이콘 이미지 추가 (`icon.png`)**
아이콘 파일(`icon.png`)을 추가하세요.  
(16x16, 48x48, 128x128 크기의 아이콘을 준비)

---

이 방식을 활용하면, 우클릭한 실행 파일의 해시 값을 계산한 후 **바이러스토탈 API로 직접 검색**할 수도 있습니다.

---

## 3️⃣ **바이러스토탈 API 연동 (선택)**
현재는 바이러스토탈의 웹 인터페이스를 여는 방식이지만, API를 사용해 더 정교한 기능을 만들 수 있습니다.

**파일 해시 기반 검색 API 사용 예제 (Node.js)**
```javascript
const axios = require("axios");

async function searchVirusTotal(hash) {
    const API_KEY = "YOUR_VIRUSTOTAL_API_KEY";
    const url = `https://www.virustotal.com/api/v3/files/${hash}`;

    try {
        const response = await axios.get(url, {
            headers: { "x-apikey": API_KEY }
        });
        console.log(response.data);
    } catch (error) {
        console.error("Error:", error.response.data);
    }
}

// 사용 예시
searchVirusTotal("44d88612fe7fc47a3933a703301b8ab6"); // 샘플 해시값
```

---

## 🎯 **결론**
- 기본적으로 **우클릭 메뉴에서 선택한 텍스트를 VirusTotal 검색 페이지로 이동**하도록 구현
- 확장 가능성을 고려하면 **API 연동을 통해 더 정밀한 탐지 기능** 추가 가능

이제 크롬에서 **"바이러스토탈에서 검색"** 옵션을 바로 사용할 수 있습니다! 🚀  
