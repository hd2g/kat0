---
date: 2022-11-17
article_title: Wantedlyのスカウトメッセージへの反応を忘れないために
article_description: ""
tags: 
  - GAS
  - TypeScript
  - Node.js
---

# TLDR
ざっくり以下のような流れのプログラムをGoogleAppsScriptで書きます。
<ol type="1">
<li>Wantedlyからのメールを集積</li>
<li>スカウトやメッセージについてのメールを抽出</li>
<li>Todoistのタスクを作成</li>
</ol>

[GitHub](https://github.com/hd2g/synchronize-wantedly-with-sns)にてコードを公開していますので、詳細はそちらをご覧ください。


# 動機
## 登録して2週間、スカウトを頂けた
最近、[Wantedly](https://www.wantedly.com/)を始めてみました。  
登録して2週間ほどで、VBAの経験しかないぼくにスカウトメッセージを送ってくださる企業様が数社いらっしゃり、とても驚きました。  
企業様、Wantedlyにはすごく感謝はしているのですが、ぼくにとっての問題というか、不便に思うところがあります。


## 普段のぼくのワークフローに合わせたい
ぼくは通知が苦手で、デスクトップの通知は基本OFFにしています。  
スマホの通知もOFF、着信音も無音、バイブレーションも切っています。  
その代わりに、

「電話折返し every day at 11:00」  
「メール返信 every day at 13:00」  
「チャット返信 every day at 15:00」  

のようなDailyタスクを[Todoist](https://todoist.com/)に登録しています。  
Wantedlyもこのような具合でDailyタスク化し、登録したのですが、  
メッセージは毎日来るものではないので、サイトを開いて閉じるだけという作業になります。  
べつに時間はかからないのでいいのですが、毎日「メッセージ今日も無いな...」と思うのは辛いので、  
メッセージが来た場合のみ返信するようタスクを適宜作成するようにしたいです。


## Webhook,APIを公開していない...
そこで、スクリプトを書くことにしたのですが、  
Wantedlyは、WebhookやAPIを公開していないようです。  
探しても、[Wantedly Open API](https://www.wantedly.com/developers)なるものしか見つけられず、  
たとえば、

「スカウトメッセージが来たらChatworkへメッセージを飛ばす」  
「企業様とのメッセージのやり取りをSlackと連携する」  
「GitHubにて公開しているスキルシートとWantedlyのプロフィールを連携させる」

みたいなことをしようとすると、工夫が必要になります。  
今回のTodoistへのタスク追加のスクリプトも同様です。

私はGmailを使用していることもあり、  
GoogleAppsScriptにてスクリプトを書くことは決めていたので、  
APIを使用せず(できず)、この機能を実現したいと思います。


# やったこと
## ざっくりフローを確認する
ざっくり以下のような流れとなります。

<!-- TODO(#): omdが生成したolの属性に`type="1"`を追加する -->
<!-- TODO(#): markdownに書き直す -->
<ol type="1">
<li>Gmailでフィルターをかける -- label: Wantedly is:unread</li>
<li>種類(DM,スカウト)毎にメールを仕分ける</li>
<li>各種類について</li>
<ol type="2">
<li>Todoistにてタスクを作成する</li>
</ol>
</ol>


## Gmailにてラベル、フィルターを作成する
メールボックスからメールを直接確認したいということもあると思うので、ラベルとフィルターを事前に作成しておきます。

ラベル名は「Wantedly」、  
フィルター条件は、`from:(@wantedly.com)`、  
アクションは、「Wantedly」ラベルの追加、  
としました。

## GoogleAppsScriptコードを書く
実際にコードを書いていきます。が、ブラウザでそのまま書くのではなく、以下を叶えたいので少し準備します。

- npmのパッケージを使いたい
- Gitでバージョン管理をしたい
- GitHubでコードの管理をしたい

詳しくは以下[詳細](#description)に書きます。


<a id="description"></a>
# 詳細
## 環境準備
### GoogleAppsScript(@google/clasp)
```bash
$ yarn init -y .
$ yarn add -D @google/clasp
$ mkdir ./src
$ yarn clasp init --type standalone --title '*** title ***' --rootDir ./src
$ $EDITOR src/index.ts
```

src/index.ts
```typescript src/index.ts
function main() {
}
```


### TypeScript
## コーディング
## 動作テスト
# メリット,デメリット,今後
## メッセージが来ているかどうかを気にする必要がなくなった
## 企業様へ24時間以内に返信できるようになった
## 企業様ごとに、タスクを作成したい
