# FROM elasticsearch:5.1
#FROM docker.elastic.co/elasticsearch/elasticsearch:6.5.4
FROM docker.elastic.co/elasticsearch/elasticsearch:6.4.3
# x-pack をインストール
# RUN elasticsearch-plugin  install --batch x-pack

# kuromojiをインストール
RUN elasticsearch-plugin  install analysis-kuromoji
