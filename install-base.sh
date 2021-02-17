#!/bin/sh
INSTALL_PATH="/data/u01/apps/Akana/2020"
#where it can find the zip files, etc that are downloaded, should standardize this location
SOURCE_PATH="/data/u01/apps/Akana/resources"
#where it can find the zip files, etc that are downloaded, should standardize this location
AUTOMATION_FILES="/data/u01/apps/Akana/automation"
AKANA_ZIP=("akana-platform-linux-jre_2020.1.0.zip" "akana-api-platform_2020.1.0.zip" "albertahealthservices-loggers-policy_2.0.0_0909.zip")

#unzip the akana-platform & akana-api-platform
for i in "${AKANA_ZIP[@]}"
do
	unzip $SOURCE_PATH/$i -d $INSTALL_PATH/
done

#unzip updated jce
unzip -j $SOURCE_PATH/jce_policy-8.zip -d $INSTALL_PATH/jre/lib/security/

#unzip custom recipes to INSTALL_PATH/recipes folder
unzip -o $AUTOMATION_FILES/ps-recipes.zip -d $INSTALL_PATH/recipes/

# Configure Logging
cp $INSTALL_PATH/../automation/container-properties/simplelogger.properties $INSTALL_PATH/lib/script/
cp $INSTALL_PATH/lib/ext/slf4j-simple-1.7.19.jar $INSTALL_PATH/lib/script/

sed -i 's/JAVA_OPTS="-Xmx2048M"/JAVA_OPTS="-Xmx4096M"/' $INSTALL_PATH/bin/startup.sh
echo "**** Updated Java Xmx=4096M"

# remove Windoze files
rm $INSTALL_PATH/bin/*exe
rm $INSTALL_PATH/bin/*bat
