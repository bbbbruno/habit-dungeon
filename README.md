[![CircleCI](https://circleci.com/gh/bbbbruno/habit-dungeon/tree/master.svg?style=svg)](https://circleci.com/gh/bbbbruno/habit-dungeon/tree/master)

# HabitDungeon

![logo](https://user-images.githubusercontent.com/41530576/78524286-7cfc3480-780e-11ea-94e1-0ed3df1ec0fa.png)

HabitDungeon（ハビットダンジョン）というサービスは、  
習慣化にいつも挫折してしまうという問題を解決したい、  
新しい習慣を身に付けたい人向けの習慣化支援サービスです。

ユーザーは自分または他人が作成したダンジョンを攻略しながら習慣化を行うことができ、  
目標自体が少しずつレベルアップする機能が備わっている事が特徴です。

# サイトリンク

https://habit-dungeon.com

# 使用技術

- Ruby 2.6.5
- Ruby on Rails 6.0.2.2
- postgreSQL 11.5
- Nginx
- AWS
  - VPC
  - EC2
  - ALB
  - RDS
  - S3
  - Route53
  - CloudFront
- Docker
- CircleCI
- GitHub
- Vue.js

# クラウドアーキテクチャ

![cloud](https://user-images.githubusercontent.com/41530576/78524121-019a8300-780e-11ea-8f84-734ad70dfaf5.png)

# インストール

```
$ docker-compose build
$ docker-compose run -rm app bin/setup
$ docker-compose up
```

# テスト

```
$ bundle exec rspec
```

# Lint

```
$ ./bin/lint
```

# 資料

エレベーターピッチ、ペーパープロトタイプ、DB設計図を作成しました。
以下のリンクで確認できます。
[資料一覧](https://github.com/bbbbruno/habit-dungeon/wiki/%E4%BC%81%E7%94%BB%E8%B3%87%E6%96%99)
