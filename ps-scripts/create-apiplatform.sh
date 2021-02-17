#!/bin/sh

# 03Sept2020 - Removed OAuth features from recipes

INSTALL_PATH="/opt/akana/sandbox/2020.1"
AUTOMATION_PATH="/opt/akana/sandbox/automation_2020.1"
PROPERTIES_PATH="$AUTOMATION_PATH/container-properties/sample"
CONTAINER_PROPERTY_FILE="platform.props"
LOG_PATH="$AUTOMATION_PATH/logs"
ADMIN_LISTENER_PROPERTY_FILE="platform-adminListener.props"
SVC_LISTENER_PROPERTY_FILE="platform-svcListener.props"
CONTAINER_NAME="platform"
LOG_LEVEL="INFO"

echo "**** Create PM Container ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.01_create-pm.log -m akana.container --recipe $INSTALL_PATH/recipes/ps-pmcm-noauth.json --props $PROPERTIES_PATH/$CONTAINER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** PM CONTAINER CREATED SUCCESSFULLY ****"

echo "Waiting for next step"
sleep 5

echo "**** Add Admin Listener ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.02_pm_addAdminListener.log -m akana.container --recipe $INSTALL_PATH/recipes/add-local-listener.json  --props $PROPERTIES_PATH/$ADMIN_LISTENER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** Admin Listener Added Sucessfully****"

echo "Waiting for next step"
sleep 5

echo "**** Add Service  Listener ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.03_pm_addHttpsListener.log -m akana.container --recipe $INSTALL_PATH/recipes/add-local-listener.json  --props $PROPERTIES_PATH/$SVC_LISTENER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** SERVICE Listener Added Sucessfully****"

echo "Waiting for next step"
sleep 5

echo "**** Complete Installation & Provisioning ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.04_pm_tasks.log -m akana.container --recipe $INSTALL_PATH/recipes/pm-tasks.json  --props $PROPERTIES_PATH/$CONTAINER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** INSTALLATION & PROVISIONING SUCCESSFULL ****"

echo "Waiting for next step"
sleep 30

echo "**** Add Container to Cluster ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.05_add-to-cluster.log -m akana.container --recipe $INSTALL_PATH/recipes/add-to-local-cluster.json  --props $PROPERTIES_PATH/$CONTAINER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** ADDED CONTAINER TO CLUSTER SUCCESSFULLY ****"

echo "Waiting for next step"
sleep 5

echo "**** Add Container Health Check ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.06_container_health.log -m akana.container --recipe $INSTALL_PATH/recipes/load-balancer-check.json  --props $PROPERTIES_PATH/$CONTAINER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** ADDED CONTAINER HEALTH CHECK SUCCESSFULLY ****"

echo "Waiting for next step"
sleep 5

echo "**** Configure Admin Console ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.07_admin-console_.log -m akana.container --recipe $INSTALL_PATH/recipes/admin-console.json  --props $PROPERTIES_PATH/$CONTAINER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** ADDED CONTAINER HEALTH CHECK SUCCESSFULLY ****"

echo "Waiting for next step"
sleep 5

echo "**** Final provisioning ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.08_final-provisioning.log -m akana.container --recipe $INSTALL_PATH/recipes/ps-final-provision.json  --props $PROPERTIES_PATH/$CONTAINER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** PROVISIONING SUCCESSFULL ****"

echo "Waiting for next step"
sleep 5

echo "**** Create API Portal Tenant ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.09_create-tenant.log -m akana.container --recipe $INSTALL_PATH/recipes/cm-tenant.json  --props $PROPERTIES_PATH/$CONTAINER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** TENANT SUCCESSFULL ****"

echo "Waiting for next step"
sleep 5

#echo "**** Configure MongoDB ****"
#$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.10_configure-mongo.log -m akana.container --recipe $INSTALL_PATH/recipes/mongo.json  --props $PROPERTIES_PATH/$CONTAINER_PROPERTY_FILE --home $INSTALL_PATH
#echo "**** MONGODB SUCCESSFULL ****"

echo "**** Final restart ****"
$INSTALL_PATH/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=$LOG_LEVEL -Dorg.slf4j.simpleLogger.logFile=$LOG_PATH/$CONTAINER_NAME.11_final-restart.log -m akana.container --recipe $INSTALL_PATH/recipes/restart.json  --props $PROPERTIES_PATH/$CONTAINER_PROPERTY_FILE --home $INSTALL_PATH
echo "**** RESTART SUCCESSFULL ****"
