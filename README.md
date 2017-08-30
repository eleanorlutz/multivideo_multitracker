# Multivideo multitracker
[![License](https://img.shields.io/github/license/mashape/apistatus.svg)](http://doge.mit-license.org) 
[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

Python and Bash scripts to automate [multi_tracker](https://github.com/florisvb/multi_tracker) by [florisvb](https://github.com/florisvb) to run the same analysis for multiple video files. This is an unmaintained script tested only on Ubuntu 17.04.

### Instructions
1. Place all videos to be analyzed in one directory.
2. Edit `config.sh` (config parameters are described in the file comments). This is the only file that needs to be edited. 
3. Load environmental variables from `config.sh`.
4. Run `make_directories.sh` to create all of the necessary multitracker directories for each video.
5. Run `make_launch_files.py` to write a separate ROS launch file for each video. 
6. Run `edit_src.py` to specify where the data should be saved for each video. 
7. Run `launch_videos.sh` to analyze all videos.

This is what the process should look like: 
```shell
$ source config.sh
$ sh make_directories.sh
$ python make_launch_files.py
$ python edit_src.py
$ sh launch_videos.sh
```
