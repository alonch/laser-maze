#!/usr/bin/env bash

coffee --compile src/ test/
if [ $? -eq 0 ]
then
  node_modules/jasmine-node/bin/jasmine-node --coffee test
fi