FROM centos:7

# ENV http_proxy $proxy
# ENV https_proxy $proxy

RUN rm -f /var/run/yum.pid
RUN yum clean all -y
RUN yum update -y
# for R
RUN yum install -y initscripts \
				install -y wget\
				install -y epel-release \
				install -y openssl-devel \
				install -y libxml2-devel \
				install -y v8-devel \
				install -y gmp-devel

RUN	yum install -y --nogpgcheck R
RUN	yum install -y --nogpgcheck https://download2.rstudio.org/rstudio-server-rhel-1.1.453-x86_64.rpm

RUN useradd inui 
RUN echo "inui" | passwd --stdin inui

EXPOSE 8787
RUN rstudio-server start

# RUN wget -e use_proxy=yes -e http_proxy=$proxy -e https_proxy=$proxy -e ftp_proxy=$proxy 'https://curl.haxx.se/download/curl-7.59.0.tar.gz'
RUN wget 'https://curl.haxx.se/download/curl-7.59.0.tar.gz'

RUN yum install libcurl-devel -y

RUN tar xfvz curl-7.59.0.tar.gz

RUN cd curl-7.59.0 \
 	./configure --enable-libcurl-option \
 	make \
 	sudo make install \
 	cd

# R version dependencies
RUN mkdir /usr/share/doc/R-3.5.0/html 
# RUN Rscript -e "install.packages(c('devtools','knitr','rmarkdown','shiny','RCurl'), repos = 'https://cran.rstudio.com')"
# RUN Rscript -e "install.packages('tseries',dependencies = T, repos='http://cran.ism.ac.jp')"
# RUN Rscript -e "install.packages('rmdformats',dependencies = T, repos='http://cran.ism.ac.jp')"
# 
# # for algorithm
# RUN Rscript -e "install.packages(c('glmnet', 'mclust', 'kernlab', 'igraph', 'relaimpo'), repos='http://cran.ism.ac.jp')"
# 
# # for data handling
# RUN Rscript -e "install.packages(c('sets', 'tidyverse', 'vars', 'magrittr'), repos='http://cran.ism.ac.jp')"
# 
# # for graph & view
# RUN Rscript -e "install.packages(c('DT','dygraphs','visNetwork', 'progress'), repos='http://cran.ism.ac.jp')"
# 
# # for pcalg
# RUN Rscript -e "source('http://bioconductor.org/biocLite.R')"\
# 	Rscript -e "biocLite('RBGL')"\
# 	Rscript -e "biocLite('Rgraphviz')"\
# 	Rscript -e "install.packages('pcalg',dependencies = T)"
# 
RUN yum install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor \
  && chmod 755 -R /var/log/supervisor
ENV PATH /usr/lib/rstudio-server/bin/:$PATH
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]





