#!/bin/bash

/opt/akana/ahs/2020/bin/jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=TRACE -Dorg.slf4j.simpleLogger.logFile=03https-listener.log -m akana.container --recipe /opt/akana/ahs/2020/recipes/add-local-listener.json --props /opt/akana/ahs/automation/container-properties/sb07-nd-httpsListener.props
