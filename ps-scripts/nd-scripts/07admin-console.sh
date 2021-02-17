#!/bin/bash

./jython.sh -Dorg.slf4j.simpleLogger.logFile=07admin-console.log -m akana.container --recipe ../recipes/admin-console.json --props sb12nd.props
