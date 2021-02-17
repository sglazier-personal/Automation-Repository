#!/bin/bash

./jython.sh -Dorg.slf4j.simpleLogger.defaultLogLevel=INFO -Dorg.slf4j.simpleLogger.logFile=04step2.log -m akana.container --recipe ../recipes/nd-cm-step2.json  --props sb12nd.props
