#!/bin/bash

adrci exec="set home diag/rdbms/xe/XE; purge -age 0 -type incident"