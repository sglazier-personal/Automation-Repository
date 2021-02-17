#!/bin/bash

./jython.sh -Dorg.slf4j.simpleLogger.logFile=02admin_listener.log -m akana.container --recipe ../recipes/add-local-listener.json --props admin-listener.props
