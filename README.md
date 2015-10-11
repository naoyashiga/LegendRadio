# 伝説のラジオ
![](https://raw.githubusercontent.com/naoyashiga/LegendRadio/master/demo.gif)

ラジオ番組「放送室」が聞けるアプリです。全391話を完全収録、バックグランド再生もできるのでラジオを聴きながら、他のアプリを見ることもできます

# 使い方
## Youtube apiの設定
Config.swiftというファイルを作りましょう。
```swift
import Foundation

struct Config {
    static let API_KEY = "YOUR_API_KEY"
    static let REQUEST_BASE_URL = "https://www.googleapis.com/youtube/v3/"
    static let REQUEST_SEARCH_URL = REQUEST_BASE_URL + "search?key=\(API_KEY)&"
    static let REQUEST_CONTENT_DETAILS_URL = REQUEST_BASE_URL + "videos?key=\(API_KEY)&part=contentDetails&"
    static let REQUEST_STATISTICS_URL = REQUEST_BASE_URL + "videos?key=\(API_KEY)&part=statistics&"
}
```
