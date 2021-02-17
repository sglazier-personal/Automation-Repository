#!/bin/bash

/opt/akana/ahs/2020/bin/jython.sh -Dorg.slf4j.simpleLogger.logFile=01nd.log -m akana.container --recipe /opt/akana/ahs/2020/recipes/ps-nd-all.json --props /opt/akana/ahs/automation/container-properties/sb07-nd.props
