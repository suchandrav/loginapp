#!/bin/bash -x
rm -rf results 
cucumber -c -v features/login.feature --backtrace --color --format pretty --format junit --out results --format CustomFormatter --out results/cucumber-reports-login.html

