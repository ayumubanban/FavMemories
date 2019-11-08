<img width="234" alt="favmemories_header" src="https://user-images.githubusercontent.com/35994367/68453702-b6b61880-0239-11ea-9e19-526bdee37f7f.png">

# FavMemories
URL: https://fav-memories.herokuapp.com/

## 概要
何か、いいことあった？<br>
[FavMemories](https://fav-memories.herokuapp.com/)とは、様々な人たちと幸せを共有することができるSNSサービスです。

## 主な機能
- ユーザー管理機能
  - 新規ユーザー登録機能
  - ユーザー詳細表示機能
  - ユーザー一覧表示機能
  - ユーザーアカウント編集機能
  - ユーザーのプロフィール画像アップロード機能
  - ユーザーログイン機能
  - SNS認証（Google/Github）での新規登録・ログイン機能
- 記事管理機能
  - 新規記事投稿機能
  - 記事詳細表示機能
  - 記事への画像アップロード機能
  - 記事編集・削除機能
  - 記事一覧表示機能
  - 記事一覧のページネーション機能
- 記事へのいいね機能
  - Ajaxを用いた非同期での記事へのいいね作成・削除機能
  - ユーザーのいいね一覧表示機能
- 記事へのコメント機能
  - Ajaxを用いた非同期での記事へのコメント作成・削除機能
  - 記事へのコメント一覧表示機能
- ユーザーへのフォロー機能
  - Ajaxを用いた非同期でのユーザーへのフォロー・アンフォロー機能
  - ユーザーのフォロー・フォロワー一覧表示機能

## 使用技術
- 開発環境
  - Docker for Mac
- テスト環境
  - RSpec(単体テスト・結合テスト)
- 本番環境
  - Heroku
- DB
  - PostgreSQL
- CI / CDパイプラインの構築
  - CircleCI
- 画像アップロード機能
  - Active Storage
  - AWS S3
- 静的ファイルのCDN配信
  - AWS CloudFront
- ページネーション機能
  - kaminari
- フロント開発
  - Bulma
  - Ajax(jQuery)

## 依存関係
- Rails: 5.2.3
- Ruby: 2.6.3
- RSpec 3.9.0

## デモ画像
<img width="1439" alt="スクリーンショット 2019-11-08 15 52 26" src="https://user-images.githubusercontent.com/35994367/68456748-03055680-0242-11ea-888f-bc93047f564a.png">
<img width="1439" alt="スクリーンショット 2019-11-08 16 05 06" src="https://user-images.githubusercontent.com/35994367/68456774-0e588200-0242-11ea-9309-55acd1a94c8e.png">
<img width="1439" alt="スクリーンショット 2019-11-08 16 05 58" src="https://user-images.githubusercontent.com/35994367/68456786-17495380-0242-11ea-9c16-68e48b2fae21.png">
<img width="1439" alt="スクリーンショット 2019-11-08 16 22 58" src="https://user-images.githubusercontent.com/35994367/68457658-23ceab80-0244-11ea-8f1b-b7020379161e.png">
