# Eclipse cheの起動

友人からメモ書きを頂いた

```
docker run --name che -it -p 80:8080 -p 49152-49162:49152-49162 -e CHE_HOST=10.124.198.52 -v /v
ar/run/docker.sock:/var/run/docker.sock codenvy/che start
```

「このコマンドでとりあえず起動するところまではいけました」とのこと
