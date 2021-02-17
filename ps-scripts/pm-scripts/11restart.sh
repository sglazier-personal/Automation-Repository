#!/bin/bash

./jython.sh -Dorg.slf4j.simpleLogger.logFile=10restart.log -m akana.container --recipe ../recipes/restart.json --props pmcm.props
