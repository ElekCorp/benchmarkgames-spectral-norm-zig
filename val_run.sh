#!/bin/bash

valgrind --tool=callgrind --simulate-cache=yes ./main_static $1 && valgrind --tool=callgrind --simulate-cache=yes ./main $1
