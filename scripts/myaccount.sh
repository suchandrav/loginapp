#!/bin/bash -x
rm -rf results 
cucumber -c -v features/my_account.feature --backtrace --color --format pretty --format junit --out results --out results/cucumber-reports-my_account.html

