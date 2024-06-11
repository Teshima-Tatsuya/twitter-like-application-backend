## Railsコンテナ作成
podman build . -t rails

## kubernetes環境構築
1. podmanインストール
2. kindインストール
KIND_EXPERIMENTAL_PROVIDER=podman kind create cluster --config=kind-config.yaml

3. kind停止
KIND_EXPERIMENTAL_PROVIDER=podman kind delete cluster

## Kubernatesダッシュボード作成
参考：https://yossi-note.com/deploying_and_logging_into_the_kubernetes_dashboard/
1. kubenetes guiの作成
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
1. guiへのアクセス
kubectl proxy
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/ 


## Kubenetesでのイメージ利用

podman save localhost/rails -o rails.tgz
KIND_EXPERIMENTAL_PROVIDER=podman kind load image-archive rails.tgz

## ECRへのイメージプッシュ
aws ecr get-login-password --region ap-northeast-1 --profile tteshima| podman login --username AWS --password-stdin 827079964324.dkr.ecr.ap-northeast-1.amazonaws.com
podman build -t twitter-like-application .
podman tag twitter-like-application:latest 827079964324.dkr.ecr.ap-northeast-1.amazonaws.com/twitter-like-application:latest
podman push 827079964324.dkr.ecr.ap-northeast-1.amazonaws.com/twitter-like-application:latest

## トラブルシューティング
- podにログインしたい場合
  kubectl exec -it <pod-name> -- <command>

- podのログを確認する場合
  kubectl logs <pod-name>

## 参考文献
Rails Kubernates化
https://qiita.com/tatsurou313/items/223dfa599ee5aaf6b2f0

ホストのボリュームをkindに見せる。
https://qiita.com/Hiroyuki_OSAKI/items/2395e6bbb98856df12f3