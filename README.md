# RenFa<ランファ>
”Rencontre en famille”（ラカントファミーユ）家族との出会いのフランス語を縮めました。

## サイト概要
ペットの里親探しサイト。  
条件をクリアすれば引き取ることも可能な、ふれあいカフェを経営している人のサイトを想定しています。  
引取の際のやり取りは、コメントか可能であればDMでできるように実装します。  
メインはカフェのメンバー紹介。画像と、犬、猫などのジャンル登録、紹介文を投稿する。  
タグ付け昨日も実装した場合、犬種などのタグを付け、タグで絞り込む機能もつける余裕があれば、実装します。  
会員登録することで、個人の家で生まれた子犬などの里親を募集すること(投稿)も可能にしたいと思っています。  
非同期通信でコメント・いいね機能も実装します。  



### サイトテーマ
家族（飼い主）を必要とする動物と家族（動物）を迎えたいユーザーを繋ぐ。  

### テーマを選んだ理由
自身が動物が好きなことと、殺処分される動物を減らしたいため。

### ターゲットユーザ
主なターゲットは犬、猫を家族に迎えたい人  
エキゾチックアニマルも可。  

### 主な利用シーン
家族（ペット）を迎えたいとき。  
子犬などの里親を探したいとき。  

## 設計書
詳細設計
https://docs.google.com/spreadsheets/d/1kud66mTRPjKk-vBFWTlCOBtSbmrS8u-L1ffHB1nUmHo/edit#gid=822203042

##ワイヤーフレーム
https://drive.google.com/file/d/16v-P0TIQ-YpJiWODGu7nuQ_24yn7BHx4/view?usp=sharing

##ER図
https://drive.google.com/file/d/1EXh4njIKo-OSSYC0efWbadpesheOMs_h/view?usp=sharing

##テーブル一覧
https://docs.google.com/spreadsheets/d/13yGmqGXRnHOyQRL2cDb_HXY7IEvTQZAb/edit#gid=1020123394

### 機能一覧
https://docs.google.com/spreadsheets/d/1Bwhw4nPSSRVUj7hQZSrJBvo4JUvz407r6XpfyW7k2oY/edit#gid=0

## 使用言語・技術
###言語
HTML/SCSS/JavaScript Ruby 2.5.7

###技術
####フレームワーク
Rails 5.2.4

####ライブラリ
jQuery 1.12.4


####インフラ
vagrant AWS(EC2/RDS/Route53) gem(devise/refile/refile-mini_magick/kaminari/dotenv/bootstrap-sass) MySQL 5.7.22

