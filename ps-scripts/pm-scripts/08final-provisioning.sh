#!/bin/bash

/data/u01/apps/Akana/2020/bin/jython.sh -Dorg.slf4j.simpleLogger.logFile=08final.log -m akana.container --recipe /data/u01/apps/Akana/2020/recipes/ps-final-provision.json --props /data/u01/apps/Akana/automation/container-properties/pm-int.props
