#!/bin/bash

buildDir=build_linux
cmake -B ${buildDir} --preset default
cmake --build ${buildDir} --config Release
cmake --install ${buildDir} --config Release
