#!/bin/bash
#Time
log_time=`date +[%Y-%m-%d]%H:%M:%S`

###manual_properties###
tomcat_basehome_1=/app/tomcat-8081
tomcat_port_1=8081
shell_environment=/bin/bash
war_Dir=/opt/jenkins
war_Name=pay-rs.war
###manual_properties###


#update server environment
echo "**********************************  ${log_time} *************************************"
echo "updating server  environment start"
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.65-3.b17.el7.ppc64le
export JRE_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.65-3.b17.el7.ppc64le/jre
export PATH=$JRE_HOME/bin:$PATH
#export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar/
export CATALINA_2_HOME=/usr/local/tomcat-balland-2
export CATALINA_2_BASE=/usr/local/tomcat-balland-2
export TOMCAT_2_HOME=/app/tomcat-8080
sleep 3
echo "updating server  environment  end"

#build check funcation
echo "check tomcat_1 status..."
check_tomcat_status_1(){
      netstat -ant|grep ${tomcat_port_1} > /dev/null
      t=$?
       if [ $t -eq 0 ]; then
           echo "tomcat_1 is running....port is ${tomcat_port_1}"
           echo "shutdown tomcat_1....."
           echo ">>>>>>>shutdown tomcat_1 begin<<<<<<<<"
           # ${shell_environment} ${tomcat_basehome_1}/bin/shutdown.sh
           ps -ef | grep ${tomcat_basehome_1} | grep -v grep | awk '{print $2}'  | sed -e "s/^/kill -9 /g" | sh
           echo ">>>>>>>shutdown tomcat_1 end <<<<<<<<"
           sleep 5
       elif [ $t -ne 0 ];then
             echo "tomcat is poweroff"
              ${shell_environment} ${tomcat_basehome_1}/bin/shutdown.sh
             sleep 5
       fi
}

#check tomcat status invoke function
check_tomcat_status_1


#transfer  application package
deploy_Loaction_1=${tomcat_basehome_1}/webapps/
war_Dir_Data=`ls ${war_Dir}`
echo "--------------  begin  transfer  war package to tomcat webapps -------------------"

if [ -z $war_Dir ];then
     echo "Folder ${war_Dir} is empty.please check war package in this folder!"
     exit 1
else
     echo "Find ${war_Dir} exist war package ${war_Name}"
    # echo "deleteing old  package ${war_Name} in ${war_Dir}"
    # rm ${war_Dir}/${war_Name}
     echo "deleteing old  package ${war_Name} in ${deploy_Loaction_1}"
     rm ${deploy_Loaction_1}${war_Name}
     echo "start  transfer ${war_Name} to ${deploy_Loaction_1}"
     cp ${war_Dir}/${war_Name}  ${deploy_Loaction_1}
     sleep 3
fi
echo "--------------  transfer  war package to tomcat_1 webapps  end -------------------"

#reboot tomcat_1
echo " >>>>>>>  rebooting  tomcat_1 begin <<<<<<<<"
${shell_environment} ${tomcat_basehome_1}/bin/startup.sh
echo " >>>>>>>  rebooting  tomcat_1 end <<<<<<<<"

echo "the log you can read in canalina.out"
echo "************************ deploy war package into container Successlly  **********************************"
