#!/bin/bash

./jython.sh -Dorg.slf4j.simpleLogger.logFile=09tenant.log -m akana.container --recipe ../recipes/cm-tenant.json --props pmcm.props
