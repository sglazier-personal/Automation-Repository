#!/bin/bash

./jython.sh -Dorg.slf4j.simpleLogger.logFile=01pmcm.log -m akana.container --recipe ../recipes/sg-pm-cm.json --props sb07-pm.props
