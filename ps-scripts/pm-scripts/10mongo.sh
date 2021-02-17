#!/bin/bash

./jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=INFO -Dorg.slf4j.simpleLogger.logFile=11mongo.log -m akana.container --recipe ../recipes/mongo.json --props pmcm.props
