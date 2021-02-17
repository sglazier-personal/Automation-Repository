#!/bin/bash

./jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=INFO -Dorg.slf4j.simpleLogger.logFile=08mongo.log -m akana.container --recipe ../recipes/mongo.json --props sb12nd.props
