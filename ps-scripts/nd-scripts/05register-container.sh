#!/bin/bash

/opt/akana/ahs/2020/bin/jython.sh -Dorg.slf4j.simpleLogger.logFile=05register-container.log -m akana.container --recipe /opt/akana/ahs/2020/recipes/register-container.json --props /opt/akana/ahs/automation/container-properties/sb07-nd.props
