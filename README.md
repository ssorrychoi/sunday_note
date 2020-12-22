# SUNDAY_NOTE

### 설교 노트 앱.

- 첫번째 이유 : 지인중에 한명(ㅈㅅㅎ)이 아이폰을 사용중인데 기본"메모"앱에서 설교노트를 작성하는 점을 보고, UX/UI를 입혀서 기본적인 메모앱을 구현하면 좋을거 같다는 생각을 함. 
  - AppStore에. 설교노트를 찾아본 결과, 검색되는 것이 없었음. => 그래서 만들게 됨. 
- 두번째 이유 : 2020년 취업을 한 뒤, 4월부터 Flutter를 회사에서 배우면서 Apple Developer로 등록은 했지만, 막상 앱을 혼자 만들려니 막막했다.
  - 2020년이 지나기전에 하나를 만들어보자 생각했고,  간단하면서 빠르게 만들수있는 앱을 생각하다가 만들게됨.



## Introduction

This is a type of Memo application for audience who is Christians. It made for Flutter framework. So it can build Android and iOS.

1. First, it should makes Folder lists.
2. Second, it can makes Memo List.
3. Third, the memo can updates.
4. Fourth, the each memo and each folder can delete.



## Development Environment

### aOS

```
minSdkVersion 16
targetSdkVersion 29
```

### iOS

```
iOS Deployment Target : iOS 9.0
```



## Screenshot

<p align = "center">
  <img src="/assets/screenshot/screenshot_1.png" width="220px" height="440px" title="screenshot_1" alt="screenshot_1"></img>
	<img src="/assets/screenshot/screenshot_2.png" width="220px" height="440px" title="screenshot_2" alt="screenshot_2"></img>
	<img src="/assets/screenshot/screenshot_3.png" width="220px" height="440px" title="screenshot_3" alt="screenshot_3"></img>
<img src="/assets/screenshot/screenshot_4.png" width="220px" height="440px" title="screenshot_4" alt="screenshot_4"></img>
<img src="/assets/screenshot/screenshot_5.png" width="220px" height="440px" title="screenshot_5" alt="screenshot_5"></img>
</p>



## Getting Started

- Start : 2020.11.24(Tue) 
- Ux/Ui 구현 : 2020.11.25(Wed)

![IMG_F76B43C00462-1](https://user-images.githubusercontent.com/43080040/100239070-4da06080-2f74-11eb-8cf4-d3ee1609e31f.JPEG)

- 사전조사 11.30 (Mon)
  - Shared_Preferences 사용법 조사
  - 폰트 변경(otf파일 -> ttf로) https://convertio.co/kr/otf-ttf/
- 12.01 (Tue)
  - 홈화면 (메모없을때) 
- 12.02 (Wed)
  - 홈화면 (폴더 생성했을때)