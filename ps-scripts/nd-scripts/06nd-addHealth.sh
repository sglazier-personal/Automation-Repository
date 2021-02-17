#!/bin/bash

./jython.sh -Dorg.slf4j.simpleLogger.logFile=06load-balancer.log -m akana.container --recipe ../recipes/load-balancer-check.json --props sb12nd.props
