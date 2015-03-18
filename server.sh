#!/usr/bin/env bash

coffee --compile src/ test/
if [ $? -eq 0 ]
then coffee src/server.coffee
fi