## Railsコンテナ作成
podman build . -t rails

## kubernetes環境構築
1. podmanインストール
2. kindインストール
kind create cluster --config=kind-config.yaml

3. kind停止
KIND_EXPERIMENTAL_PROVIDER=podman kind delete cluster

## Kubernatesダッシュボード作成
参考：https://yossi-note.com/deploying_and_logging_into_the_kubernetes_dashboard/
1. kubenetes guiの作成
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
1. guiへのアクセス
kubectl proxy
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/ 
1. 認証トークン取得
kubectl -n kubernetes-dashboard create token admin-user


## Kubenetesでのイメージ利用

### rails
podman build . -t rails
podman save localhost/rails -o rails.tgz
kind load image-archive rails.tgz
### nginx
podman build . -t nginx
podman save localhost/nginx -o nginx.tgz
kind load image-archive nginx.tgz


## ECRへのイメージプッシュ
### ECRログイン
aws ecr get-login-password --region ap-northeast-1 --profile tteshima| podman login --username AWS --password-stdin 827079964324.dkr.ecr.ap-northeast-1.amazonaws.com

### push image
#### nginx
podman tag nginx:latest 827079964324.dkr.ecr.ap-northeast-1.amazonaws.com/nginx:latest
podman push 827079964324.dkr.ecr.ap-northeast-1.amazonaws.com/nginx:latest
#### rails
podman build -t rails .
podman tag rails:latest 827079964324.dkr.ecr.ap-northeast-1.amazonaws.com/rails:latest
podman push 827079964324.dkr.ecr.ap-northeast-1.amazonaws.com/rails:latest

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

WSLでpodmanを利用する
https://qiita.com/yo_C_ta/items/df2a70de6a653226a173

Kubernetes参考資料
https://qiita.com/yuta-katayama-23/items/8d5528005c9ce2b7614c

Nginxのフォワードプロキシ設定
https://github.com/dominikwinter/nginx-forward-proxy/blob/master/Dockerfile