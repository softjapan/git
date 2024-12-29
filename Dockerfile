# ベースイメージに Alpine Linux を利用
FROM alpine:3.18

# 最新のパッケージリスト取得 & Git + SSH クライアントをインストール
RUN apk update && \
    apk add --no-cache git openssh-client && \
    rm -rf /var/cache/apk/*

# コンテナ起動時の作業ディレクトリ
WORKDIR /app

# コンテナ実行時に git コマンドが使われるように設定
ENTRYPOINT ["git"]