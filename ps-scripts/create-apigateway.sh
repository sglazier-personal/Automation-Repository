#!/bin/sh
INSTALL_PATH="/opt/akana/sandbox/2020.1"
AUTOMATION_PATH="/opt/akana/sandbox/automation.2020.1"
PROPERTIES_PATH="$AUTOMATION_PATH/container-properties/sample"
CONTAINER_PROPERTY_FILE="gateway.props"
LOG_PATH="$AUTOMATION_PATH/logs"
ADMIN_LISTENER_PROPERTY_FILE="gateway-adminListener.props"
SVC_LISTENER_PROPERTY_FILE="gateway-svcListener.props"
CONTAINER_NAME="nddmz_a_stl"
LOG_LEVEL="INFO"

echo "**** Create ND Container ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.01_create-nd.log -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -m akana.container --recipe $INSTALL_PATH/recipes/nd-cm-all.json --props $PROPERTIES_PATH/$CONTAINER_PROPERTY_FILE
echo "**** ND CONTAINER CREATED SUCCESSFULLY ****"

echo "Waiting for next step"
sleep 5

echo "**** Add Admin Listener ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.02_nd_addAdminListener.log -m akana.container --recipe $INSTALL_PATH/recipes/add-local-listener.json  --props $PROPERTIES_PATH/$ADMIN_LISTENER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** Listener Added Sucessfully ****"

echo "Waiting for next step"
sleep 5

echo "**** Add Service Listener ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.03_nd_addHttpsListener.log -m akana.container --recipe $INSTALL_PATH/recipes/add-local-listener.json  --props $PROPERTIES_PATH/$SVC_LISTENER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** Listener Added Sucessfully ****"

echo "Waiting for next step"
sleep 5

echo "**** Continue ND Configuration ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.04_ndConfig_tasks.log -m akana.container --recipe $INSTALL_PATH/recipes/ps-nd-step2.json  --props $PROPERTIES_PATH/$CONTAINER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** CONFIGURATION SUCCESSFULL ****"

echo "Waiting for next step"
sleep 5

echo "**** Add Container Health Check ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.06_container_health.log -m akana.container --recipe $INSTALL_PATH/recipes/load-balancer-check.json  --props $PROPERTIES_PATH/$CONTAINER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** ADDED CONTAINER HEALTH CHECK SUCCESSFULLY ****"

echo "**** Configure Admin Console ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.07_admin-console_.log -m akana.container --recipe $INSTALL_PATH/recipes/admin-console.json  --props $PROPERTIES_PATH/$CONTAINER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** ADMIN CONSOLE CONFIG COMPLETE ****"

echo "**** Configure Bootstrap Truststore ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.08_trustStore.log -m akana.container --recipe $INSTALL_PATH/recipes/ps-security.json  --props $PROPERTIES_PATH/$CONTAINER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** TRUSTSTORE CONFIG COMPLETE ****"

echo "**** Shutting down container ****"
$INSTALL_PATH/bin/shutdown.sh $CONTAINER_NAME

echo "**** Updating Admin Listener Settings ****"

ADMIN_LISTENER_CONFIG=`grep -iRl "admin" $INSTALL_PATH/instances/$CONTAINER_NAME/cm/com/soa/transport/jetty/endpoint/*`
echo "Finding Admin listener config = " $ADMIN_LISTENER_CONFIG

echo "system.properties"
sed -i 's/org.osgi.service.http.port/org.osgi.service.http.port.secure/' $INSTALL_PATH/instances/$CONTAINER_NAME/system.properties

echo "Change Listener scheme to https"
sed -i 's/\"http\"/\"https\"/' $ADMIN_LISTENER_CONFIG

echo "Change Listener URL to https://"
sed -i 's/http\:/https\:/' $ADMIN_LISTENER_CONFIG

echo "**** Finished Admin Listener Settings ****"

echo "**** Starting Container ****"
rm $INSTALL_PATH/instances/$CONTAINER_NAME/log/*
#$INSTALL_PATH/bin/startup.sh $CONTAINER_NAME -bg
sleep 20
echo "**** Complete ****"
