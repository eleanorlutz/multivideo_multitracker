#!/bin/bash

for fname in $VIDEO_SRC*
do
	# strip the directory and extension from the filename
	id="${fname##*/}" # includes extension
	id="${id%.*}"

	# create directories to hold files for this video
	mkdir -p "$DESTINATION/$id" "$DESTINATION/$id/data" "$DESTINATION/$id/src"

	# copy parameters for the video into each video /src folder
	cp -r "$PARAMETERS_SRC" "$DESTINATION/$id/"
done
