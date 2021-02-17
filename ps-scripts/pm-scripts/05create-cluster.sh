#!/bin/bash

./jython.sh -Dorg.slf4j.simpleLogger.logFile=05cluster.log -m akana.container --recipe ../recipes/add-to-local-cluster.json --props pmcm.props
