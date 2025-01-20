PLURA-XDR과 연동된 **Popup 창을 띄우는 Chrome 확장 프로그램**을 만들려면 다음과 같은 단계를 따를 수 있습니다.

---

## 📌 **1. Chrome 확장 프로그램 기본 구조**
Chrome 확장 프로그램은 **Manifest v3**를 기반으로 동작하며, Popup 창을 띄우려면 **action (browserAction)**을 사용해야 합니다.

### 🔹 **폴더 및 파일 구성**
```
PLURA-XDR-Extension/
│── manifest.json
│── popup.html
│── popup.js
│── icon.png
```

---

## 📌 **2. `manifest.json` 작성**
Chrome 확장 프로그램의 설정을 정의하는 파일입니다.

```json
{
  "manifest_version": 3,
  "name": "PLURA-XDR Extension",
  "version": "1.0",
  "description": "PLURA-XDR과 연동된 Chrome 확장 프로그램입니다.",
  "permissions": ["storage", "activeTab"],
  "host_permissions": ["*://*.plura.io/*"], 
  "action": {
    "default_popup": "popup.html",
    "default_icon": {
      "16": "icon.png",
      "48": "icon.png",
      "128": "icon.png"
    }
  }
}
```

✅ **설명**  
- `"action"`: 브라우저의 확장 프로그램 아이콘을 클릭했을 때 Popup 창을 띄우도록 설정합니다.
- `"default_popup": "popup.html"`: Popup 창으로 `popup.html` 파일을 사용합니다.
- `"permissions"`: 웹 페이지 정보에 접근하기 위한 권한입니다.

---

## 📌 **3. `popup.html` 작성**
Popup 창의 HTML 파일입니다.

```html
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PLURA-XDR</title>
    <link rel="stylesheet" href="popup.css">
</head>
<body>
    <h2>PLURA-XDR</h2>
    <p>PLURA-XDR 웹사이트에서 검색</p>
    <button id="openPlura">PLURA-XDR 열기</button>

    <script src="popup.js"></script>
</body>
</html>
```

---

## 📌 **4. `popup.js` 작성**
버튼 클릭 시 PLURA-XDR 웹사이트를 새 탭에서 열도록 설정합니다.

```javascript
document.getElementById("openPlura").addEventListener("click", function() {
    chrome.tabs.create({ url: "https://plura.io" });
});
```

---

## 📌 **5. Chrome 확장 프로그램 설치**
1. Chrome에서 `chrome://extensions/`로 이동
2. "개발자 모드" 활성화
3. "압축 해제된 확장 프로그램 로드" 버튼 클릭
4. `PLURA-XDR-Extension` 폴더 선택

---

✅ **결과:**  
Chrome 브라우저에서 확장 프로그램을 설치하면 **확장 아이콘을 클릭하면 Popup 창이 열리며, "PLURA-XDR 열기" 버튼을 클릭하면 PLURA-XDR 웹사이트가 열립니다.**

📌 **추가 기능**  
- 확장 프로그램을 통해 특정 기능(로그 검색, 분석 페이지 열기 등)을 추가하려면 `host_permissions`에 API 호출 권한을 추가할 수 있습니다.
- `contextMenus` API를 사용하면 **텍스트를 선택하고 "PLURA-XDR에서 검색" 옵션을 추가**할 수도 있습니다.

필요한 기능이 더 있다면 알려주세요! 🚀
