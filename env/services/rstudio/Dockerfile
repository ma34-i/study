FROM centos:7

#RUN #rm -f /var/run/yum.pid \
#&& yum clean all -y \
RUN yum update -y \
# yum install 
&& yum install -y initscripts wget epel-release openssl-devel \
  libxml2-devel v8-devel gmp-devel libcurl-devel

# R
RUN	yum install -y --nogpgcheck R

# Rstudio
RUN	yum install -y --nogpgcheck https://download2.rstudio.org/rstudio-server-rhel-1.1.453-x86_64.rpm \
# Rstudio Server 永続化
&& yum install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor \
  && chmod 755 -R /var/log/supervisor
ENV PATH /usr/lib/rstudio-server/bin/:$PATH

# curl
RUN wget 'https://curl.haxx.se/download/curl-7.59.0.tar.gz'

# R packages
RUN mkdir /usr/share/doc/R-3.5.0/html \
&& Rscript -e "install.packages(c('devtools','knitr','rmarkdown','shiny','RCurl', 'webshot', 'xts', 'rmdformats'), repos = 'https://cran.rstudio.com')" \
# for algorithm
&& Rscript -e "install.packages(c('tseries', 'KFAS', 'dlm', 'glmnet', 'mclust', 'kernlab', 'igraph', 'relaimpo'), repos='http://cran.ism.ac.jp')" \
# for data handling
&& Rscript -e "install.packages(c('sets', 'tidyverse', 'vars', 'magrittr'), repos='http://cran.ism.ac.jp')" \
# for graph & view
&& Rscript -e "install.packages(c('DT','dygraphs','visNetwork', 'progress','caTools'), repos='http://cran.ism.ac.jp')"

# for pcalg
RUN Rscript -e "source('http://bioconductor.org/biocLite.R')"\
&& Rscript -e "biocLite('RBGL'); biocLite('Rgraphviz')"\
&& Rscript -e "install.packages('pcalg',dependencies = T)"

# for pdf
# RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2 \
# && yum install -y bzip2 \
# && tar jxf phantomjs-1.9.7-linux-x86_64.tar.bz2 \
# && ln -s phantomjs-1.9.7-linux-x86_64 /usr/local/src/phantomjs \
# && ln -s /usr/local/src/phantomjs/bin/phantomjs /usr/local/bin/phantomjs \
# && yum install -y texlive-* 

RUN yum install -y vim

# useradd
RUN useradd -u 2001 alice \
&& echo "alice" | passwd --stdin alice \
&& mkdir /home/alice/workspace \
&& chown alice /home/alice/workspace
# useradd

# RUN yum install -y cron
EXPOSE 8787
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]


