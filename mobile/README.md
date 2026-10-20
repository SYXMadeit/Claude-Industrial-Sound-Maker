# mobile/ — 应用商店打包（Capacitor）

把网页版原样装进原生壳，先出 **美国区 App Store / Google Play**。网页代码不用改；每次网页更新后在这里跑一次 `npm run sync` 即可。

## 一次性准备

| 平台 | 需要 | 费用 |
|------|------|------|
| iOS | 一台 Mac + Xcode 15+，Apple Developer Program 账号 | 99 美元/年 |
| Android | Android Studio（Mac/Win/Linux 均可），Google Play 开发者账号 | 25 美元一次性 |

```bash
cd mobile
npm install          # 已装过可跳过
npm run sync         # 把 ../index.html css js icons 复制到 www/ 并同步到 ios/ android/
```

## iOS（App Store 美国区）

1. `npm run ios` 会打开 `ios/App/App.xcworkspace`（首次需先 `cd ios/App && pod install`）。
2. Xcode 里选中 App target → Signing & Capabilities → Team 选你的开发者账号；Bundle Identifier 保持 `com.majmanx.industrialsound`（或改成你自己的反向域名）。
3. Assets → AppIcon：把 `../icons/icon-512.png` 放大到 1024×1024 作为商店图标（Xcode 15 只需这一张）。
4. 菜单 Product → Archive → Distribute App → App Store Connect → Upload。
5. 在 [App Store Connect](https://appstoreconnect.apple.com) 新建 App：名称「Industrial Sound Maker」、分类 Music、年龄分级 4+、隐私：**不收集任何数据**（应用无网络请求、无账号、无统计）。
6. 上传截图（6.7" 与 6.5" iPhone 各至少一张；在模拟器里截即可），填描述，提交审核。首次审核通常 1–3 天。

审核备注可写：*All sounds are synthesized on-device with the Web Audio API; the app works fully offline and collects no data.*

## Android（Google Play 美国区）

1. `npm run android` 打开 Android Studio 项目。
2. Build → Generate Signed Bundle → 新建 keystore（**妥善保存，丢了就无法更新**）→ 生成 `.aab`。
3. [Play Console](https://play.google.com/console) 新建应用 → 上传 AAB 到 Production（或先 Internal testing）。
4. 填写「数据安全」表单：不收集、不共享任何数据；内容分级问卷：无敏感内容。
5. 提交审核，通常 1–7 天。

## 注意

- 原生壳内不注册 service worker（Capacitor 本身就是本地文件），`sync-www.sh` 不会复制 `sw.js`。
- iOS 静音键会让 WKWebView 的 Web Audio 静音，这是系统行为；页面里已有提示。
- 国内安卓商店与中国区 App Store 另需软件著作权与 ICP 备案，见仓库根目录 README「部署」一节。
