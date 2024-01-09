#!/bin/bash

buildDir=build_linux
cmake -B ${buildDir} --preset default
cmake --build ${buildDir}
cmake --install ${buildDir}
