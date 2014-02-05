#! /bin/sh

# install Solr + tomcat
# by Bachir Soussi Chiadmi www.g-u-i.net
# @bachysoucychymy
# dev@g-u-i.net

# http://www.lullabot.com/blog/article/installing-solr-use-drupal

# tomcat
useradd -Mb /opt tomcat
cd ~/Downloads
wget http://mirrors.linsrv.net/apache/tomcat/tomcat-7/v7.0.42/bin/apache-tomcat-7.0.42.tar.gz
sudo tar -C /opt/ -zxf ~/Downloads/apache-tomcat-7.0.42.tar.gz
cd /opt/
mv apache-tomcat-7.0.42/ tomcat
sudo sed -i s/8080/8983/g /opt/tomcat/conf/server.xml
sudo chown -R tomcat:tomcat /opt/tomcat
sudo -u tomcat /opt/tomcat/bin/startup.sh

# Solr
cd ~/Downloads
wget http://apache.opensourcemirror.com/lucene/solr/4.4.0/solr-4.4.0.tgz
tar -zxf solr-4.4.0.tgz
sudo cp solr-4.4.0/dist/solrj-lib/* /opt/tomcat/lib/
sudo cp solr-4.4.0/example/resources/log4j.properties /opt/tomcat/conf/
sudo cp solr-4.4.0/dist/solr-4.4.0.war /opt/tomcat/webapps/solr.war
sudo echo '<Context docBase="/opt/tomcat/webapps/solr.war" debug="0" crossContext="true">
  <Environment name="solr/home" type="java.lang.String" value="/opt/tomcat/solr" override="true" />
</Context>' > /opt/tomcat/conf/Catalina/localhost/solr.xml

# then you will have to set your cores (indexes) following the tutorial

