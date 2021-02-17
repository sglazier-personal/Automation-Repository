#!/bin/bash

./jython.sh -Dorg.slf4j.simpleLogger.logFile=04pmtasks.log -m akana.container --recipe ../recipes/pm-tasks.json --props pmcm.props
