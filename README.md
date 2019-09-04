# chatbot-weather-for-slack
## 概要
- SlackからのPOST(テキスト)に対応した天気予報情報を返却するサービス

## 使い方
- 前提
  - セットアップが完了している
- Slackチャンネルにセットアップで作成したBOTをinviteする
- チャンネル内で適当な文字列をPOSTする
- 反応する文字列の例
  - 今日の天気は？
  - 明日の天気は？
  - 1週間の天気は？
  - 今日の大阪の天気は？
  - 明日の大阪の天気は？
  - 1週間の大阪の天気は？
- BOTが反応したときの返却値
  - 対象の日付
  - 天気サマリー
  - 最高気温
  - 最低気温
  - 降水確率
- 地域指定がなければ検索対象地域は東京都になる
- 日付指定(今日、明日、1週間)がなければ対象日付は今日になる

## セットアップ
### Deploy to Heroku
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)
- 環境変数の値は設定フローに従い取得、Herokuに設定する
- workerの起動
- <img width="1219" alt="run-worker" src="https://user-images.githubusercontent.com/8207836/64193642-21ed1280-ceb8-11e9-96e0-f38a9b3bbab7.png">

### 設定フロー
#### Dark Sky API Tokenの取得
- [Dark Sky API](https://darksky.net/dev) に登録しTOKENを取得する
- 赤枠内のTOKENをHerokuに登録する
- <img width="1260" alt="darkskyapi-token-new" src="https://user-images.githubusercontent.com/8207836/64176129-457a7380-ce4c-11e9-9c92-f3aed69c151d.png">

#### Slack Appの作成
- [Slack Appの新規作成](https://api.slack.com/apps?new_app=1)
- <img width="562" alt="create-slack-app" src="https://user-images.githubusercontent.com/8207836/64174359-9b4d1c80-ce48-11e9-9ae7-0deb6746ef9c.png">

#### BOTの作成
- <img width="864" alt="make-bot" src="https://user-images.githubusercontent.com/8207836/64175628-3f37c780-ce4b-11e9-8a7a-69afdad61d01.png">
- <img width="639" alt="make-bot-user" src="https://user-images.githubusercontent.com/8207836/64176302-af931880-ce4c-11e9-8e8f-31b1d1d72a0f.png">

#### BOTのTOKENを取得(Permissionの設定)
- <img width="864" alt="make-permission" src="https://user-images.githubusercontent.com/8207836/64175629-3f37c780-ce4b-11e9-8c57-eb52317f41d3.png">
- <img width="641" alt="click-install-app" src="https://user-images.githubusercontent.com/8207836/64175633-3fd05e00-ce4b-11e9-8380-d78b26ac03b7.png">
- <img width="489" alt="click-allow" src="https://user-images.githubusercontent.com/8207836/64175634-4068f480-ce4b-11e9-9754-d0d06d8d80fd.png">
- 赤枠内のTOKENをHerokuに登録する
- <img width="639" alt="access-token" src="https://user-images.githubusercontent.com/8207836/64175636-4068f480-ce4b-11e9-8546-5bbdcd53b6a8.png">

#### (任意)
- 画像などの変更
- <img width="642" alt="change-info" src="https://user-images.githubusercontent.com/8207836/64175632-3fd05e00-ce4b-11e9-907b-116277accd0e.png">

## 構成
- 利用API
  - [Slack API Bots](https://api.slack.com/bot-users)
  - [Dark Sky API](https://darksky.net/dev)
- 地域検索に[geocoder](https://github.com/alexreisner/geocoder)
