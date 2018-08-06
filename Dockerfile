FROM r-base:latest

ENV JAVA_HOME       /usr/lib/jvm/java-8-oracle
ENV LANG            en_US.UTF-8
ENV LC_ALL          en_US.UTF-8

RUN apt-get update && \
  apt-get install -y --no-install-recommends locales && \
  locale-gen en_US.UTF-8 && \
  apt-get dist-upgrade -y && \
  apt-get --purge remove openjdk* && \
 apt-get install -y gnupg1 && \
  echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
  
RUN apt-get update && \
  apt-get -y install aptitude && \
  aptitude install -y libcurl4-openssl-dev libssl-dev libcairo2-dev  libxt-dev libxml2-dev r-cran-xml && \
  apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default && \
  apt-get clean all && \
  apt-get install -y libudunits2-dev

RUN mkdir /opt/Rutil
RUN mkdir /app
RUN mkdir /app/packages

RUN R -e 'install.packages(c("stringr","forecast","arules","arulesViz","rpart","e1071","jsonlite","corrgram","caret","ROCR","R2HTML","corrplot","data.table","doParallel","itertools","foreach","lubridate","TeachingSampling","rbokeh","dplyr","xgboost","klaR","elasticsearchr","R.utils","zoo","rJava","RJDBC","loggit","data.table","customelasticsearchr","elasticsearchr","FastRWeb","XML","Hmisc","plyr", "information"), repos="http://cran.us.r-project.org")'

RUN R -e 'install.packages("Rserve", repos="http://www.rforge.net/")'

RUN R -e 'install.packages(c("ada","adabag","dplyr","forecast","gbm","ggplot2"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("glmnet","graphics","Hmisc","igraph","leaps"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("ggord","klaR"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("randomForest"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("MASS"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("mlr"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("quantregForest"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("zoo"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("class"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("Boruta"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("devtools"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("factoextra"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("e1071"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("forecast"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("udunits2"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("ggforce"), repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages(c("ggraph"), repos="http://cran.us.r-project.org")'


