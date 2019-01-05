```

|-certs/
| |- mydomain.com.crt
| |- mydomain.com.key
|
|-proxy/
| |-docker-compose.yml
|
|-services/
| |-rstudio/
| | |- docker-compose.yml
| |
| |-elastic-elk/
|
|-etc/
  |-makeNetwork.sh
```

## certsディレクトリ
certsディレクトリにはSSL証明書を入れる

mydomain.com.crt、mydomain.com.keyは自社ドメインに合わせてリネーム.
今回はワイルドカード証明書を使うのでドメイン名だけでOK.

もしサービス毎の証明書を使用する場合は
- servicename.mydomain.com.crt
- servicename.mydomain.com.key
等で個別に作成.
