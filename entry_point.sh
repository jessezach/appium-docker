#!/bin/bash

NODE_CONFIG_JSON="/root/config.json"
CMD="xvfb-run appium"

if [ -f "$NODE_CONFIG_JSON" ]; then
  CMD+=" --nodeconfig $NODE_CONFIG_JSON"
fi

$CMD
