#!/bin/bash

./jython.sh -Dorg.slf4j.simpleLogger.logFile=03https-listener.log -m akana.container --recipe ../recipes/add-local-listener.json --props https-listener.props
