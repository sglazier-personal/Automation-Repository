#!/bin/bash

/opt/akana/ahs/2020/bin/jython.sh -Dorg.slf4j.simpleLogger.logFile=11restart.log -Dorg.slf4j.simpleLogger.defaultLogLevel=TRACE -m akana.container --recipe /opt/akana/ahs/2020/recipes/restart.json --props /opt/akana/ahs/automation/container-properties/sb07-nd.props
