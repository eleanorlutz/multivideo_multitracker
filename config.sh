#!/bin/bash

# The directory that holds all of the videos to be analyzed
export VIDEO_SRC="$HOME/Documents/videos_test/"

# The directory to hold all data folders after analysis
export DESTINATION="$HOME/Documents/analysis_files/"

# The src directory with multitracker parameter files
export PARAMETERS_SRC="$HOME/Documents/demo/demo_1/src/"

# The directory to hold the ROS launch file for each video
export LAUNCH_FILES_SRC="$HOME/Documents/launch_files/"

# Maximum time allowed to analyze a video before process is killed
export ROS_KILL_TIMER="3m"

# Maximum time allowed for tracker to initialize before starting video
export ROS_INITIALIZE_TIMER="10s"

# Remove all previous data analysis files if true
RM_PREVIOUS=$true
