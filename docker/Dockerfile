FROM centos:7

ENV http_proxy odmaServerWatch:0867681521@rep.proxy.nic.fujitsu.com:8080
ENV https_proxy odmaServerWatch:0867681521@rep.proxy.nic.fujitsu.com:8080

RUN rm -f /var/run/yum.pid
RUN yum clean all
RUN yum update
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

#RUN wget -d FTP_PROXY='http://odmaServerWatch:0867681521@rep.proxy.nic.fujitsu.com:8080' 'https://curl.haxx.se/download/curl-7.59.0.tar.gz'
RUN wget -e use_proxy=yes -e http_proxy='http://odmaServerWatch:0867681521@rep.proxy.nic.fujitsu.com:8080' -e https_proxy='http://odmaServerWatch:0867681521@rep.proxy.nic.fujitsu.com:8080' -e ftp_proxy='http://odmaServerWatch:0867681521@rep.proxy.nic.fujitsu.com:8080' 'https://curl.haxx.se/download/curl-7.59.0.tar.gz'

RUN yum install libcurl-devel -y

RUN tar xfvz curl-7.59.0.tar.gz

RUN cd curl-7.59.0 \
 	./configure --enable-libcurl-option \
 	make \
 	sudo make install \
 	cd

# R version dependencies
RUN mkdir /usr/share/doc/R-3.5.0/html 
RUN Rscript -e "install.packages(c('devtools','knitr','rmarkdown','shiny','RCurl'), repos = 'https://cran.rstudio.com')"
RUN Rscript -e "install.packages('tseries',dependencies = T, repos='http://cran.ism.ac.jp')"
RUN Rscript -e "install.packages('rmdformats',dependencies = T, repos='http://cran.ism.ac.jp')"

# for algorithm
RUN Rscript -e "install.packages(c('glmnet', 'mclust', 'kernlab', 'igraph', 'relaimpo'), repos='http://cran.ism.ac.jp')"

# for data handling
RUN Rscript -e "install.packages(c('sets', 'tidyverse', 'vars'), repos='http://cran.ism.ac.jp')"

# for graph & view
RUN Rscript -e "install.packages(c('DT','dygraphs','visNetwork', 'progress'), repos='http://cran.ism.ac.jp')"

# for pcalg
RUN Rscript -e "source('http://bioconductor.org/biocLite.R')"\
	Rscript -e "biocLite('RBGL')"\
	Rscript -e "biocLite('Rgraphviz')"\
	Rscript -e "install.packages('pcalg',dependencies = T)"


