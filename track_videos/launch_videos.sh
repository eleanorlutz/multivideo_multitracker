#!/bin/bash

for fname in $VIDEO_SRC*
do
	# strip the directory and extension from the filename
	id="${fname##*/}" # includes extension
	id="${id%.*}"

	# clean up any lingering processes 
	rosnode kill -a
	killall -w roscore
	killall -w rosnode
	killall -w rosmaster

	# run the launcher from inside the /src directory
	cd $DESTINATION/$id/src
	# remove pyc files to force recompiling with new parameters
	rm -f $DESTINATION/$id/src/delta_video_config.pyc || true
	rm -f $DESTINATION/$id/src/kalman_parameters.pyc || true

	if [$RM_PREVIOUS -eq $true]
	then
		echo "Removing all existing files from /data directory"
		rm -f $DESTINATION/$id/data/*
	fi	
	roslaunch tracking_launcher.launch & 
	sleep $ROS_INITIALIZE_TIMER # wait to ensure the launcher has started

	# run the video in a subshell
	(roslaunch $HOME/Documents/launch_files/$id.launch & 
	sleep $ROS_KILL_TIMER
	)

	rosnode kill -a
	killall -w roscore
	killall -w rosnode
	killall -w rosmaster
	echo "Finished with video ID $id"
done

echo "launch_videos.sh has finished running"
